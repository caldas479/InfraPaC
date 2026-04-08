"""
RQ2 — Model Comparison Experiment Runner

Runs the InfraPaC repair pipeline on the fixed 200-entry RQ2 sample using an
OpenRouter-hosted model and reports:

  FR  — Fix Rate:             % entries repaired within 3 iterations
  RR  — Retry Rate:           % successful repairs that needed >1 iteration
  MRA — Mean Repair Attempts: average iterations across successful repairs
  CPR — Cost per Repair:      avg OpenRouter cost per successfully repaired entry (USD)

Usage:
    uv run python run_rq2.py --model meta-llama/llama-3.3-70b-instruct
    uv run python run_rq2.py --model deepseek/deepseek-chat-v3-0324 --workers 4
    uv run python run_rq2.py --model mistralai/mistral-large-2411 --workers 4 --verbose

Required environment variable:
    OPENROUTER_API_KEY
"""

import argparse
import json
import logging
import sys
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
from pathlib import Path
from statistics import mean
from typing import Any, Dict, List

from langchain_community.callbacks import get_openai_callback

from src.agents.repair_agent import RepairAgent
from src.pac_engines.kics_engine import KICSEngine
from src.utils.config_loader import load_config
from src.utils.env_loader import load_environment
from src.utils.logging_config import setup_logging

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
SAMPLE_FILE = Path("data/rq2_sample.json")
DATASET_BASE = Path("data/datasets/spec_bug_fix_kics")
RESULTS_BASE = Path("results/rq2")

# OpenRouter pricing (USD per 1M tokens) — from openrouter.ai/models, April 2026
# Used as fallback when the API doesn't return cost in usage headers.
OPENROUTER_PRICING: Dict[str, Dict[str, float]] = {
    "meta-llama/llama-3.3-70b-instruct": {"input": 0.383, "output": 0.604},
    "meta-llama/llama-3.3-70b-instruct:free": {"input": 0.00, "output": 0.00},
    "deepseek/deepseek-chat-v3-0324": {"input": 0.27, "output": 1.10},
    "mistralai/mistral-large-2411": {"input": 2.00, "output": 6.00},
}

# Thread-safe progress counter
progress_lock = threading.Lock()


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def safe_model_name(model: str) -> str:
    """Sanitise model string for use as a directory name."""
    return model.replace("/", "_").replace(":", "-")


def compute_cost(model: str, prompt_tokens: int, completion_tokens: int) -> float:
    """Estimate cost in USD using published OpenRouter per-token rates."""
    pricing = OPENROUTER_PRICING.get(model)
    if pricing is None:
        return 0.0
    return (
        prompt_tokens * pricing["input"] + completion_tokens * pricing["output"]
    ) / 1_000_000


def build_llm_config(
    model: str, provider: str, base_config: Dict[str, Any]
) -> Dict[str, Any]:
    """Build the LLM config dict for the given provider, overriding base config values."""
    llm_cfg = dict(base_config.get("llm", {}))
    llm_cfg["provider"] = provider
    llm_cfg["model"] = model
    llm_cfg["temperature"] = 0.2
    llm_cfg["max_tokens"] = 2048
    llm_cfg["timeout"] = 120
    return llm_cfg


# ---------------------------------------------------------------------------
# Per-entry processing
# ---------------------------------------------------------------------------


def process_entry(
    entry: Dict,
    entry_num: int,
    total: int,
    base_path: Path,
    config: Dict[str, Any],
    llm_config: Dict[str, Any],
    skip_existing: bool,
) -> Dict:
    """
    Process a single dataset entry.  Creates its own KICSEngine and RepairAgent
    so it is safe to call from multiple threads.

    Returns a result dict:
        entry_id, status, iterations, prompt_tokens, completion_tokens, total_cost
    """
    logger = logging.getLogger(__name__)
    entry_path = base_path / entry["path"]

    policy_file = entry_path / "policy.rego"
    buggy_file = entry_path / "buggy.tf"
    patch_file = entry_path / "patch.tf"
    metadata_file = entry_path / "metadata.json"

    with progress_lock:
        logger.info(
            f"\n[{entry_num}/{total}] Processing {entry['entry_id']} ({entry['category']})"
        )

    # Optional skip
    if skip_existing and patch_file.exists() and patch_file.stat().st_size > 0:
        with progress_lock:
            logger.info(f"[{entry_num}/{total}] Patch already exists, skipping...")
        return {"entry_id": entry["entry_id"], "status": "skipped"}

    # Load files
    try:
        policy = policy_file.read_text()
        buggy_tf = buggy_file.read_text()
    except FileNotFoundError as exc:
        with progress_lock:
            logger.error(f"[{entry_num}/{total}] Missing file: {exc}")
        return {
            "entry_id": entry["entry_id"],
            "status": "error",
            "reason": str(exc),
            "iterations": 0,
            "prompt_tokens": 0,
            "completion_tokens": 0,
            "total_cost": 0.0,
        }

    metadata = None
    if metadata_file.exists():
        try:
            metadata = json.loads(metadata_file.read_text())
        except json.JSONDecodeError as exc:
            logger.warning(
                f"Failed to parse metadata.json for {entry['entry_id']}: {exc}"
            )

    # Create per-thread engine and agent
    kics_engine = KICSEngine(config["kics"])
    repair_agent = RepairAgent(
        kics_engine,
        config=config.get("repair", {}),
        llm_config=llm_config,
    )

    # Initial violation detection
    try:
        violations = kics_engine.evaluate(policy, buggy_tf, metadata)
    except Exception as exc:
        with progress_lock:
            logger.error(f"[{entry_num}/{total}] KICS evaluation error: {exc}")
        return {
            "entry_id": entry["entry_id"],
            "status": "error",
            "reason": str(exc),
            "iterations": 0,
            "prompt_tokens": 0,
            "completion_tokens": 0,
            "total_cost": 0.0,
        }

    # Run repair with token/cost tracking
    # get_openai_callback() only captures usage from OpenAI-compatible responses;
    # for Ollama it returns zeros, which is fine since cost is $0 anyway.
    try:
        with get_openai_callback() as cb:
            result = repair_agent.repair(
                iac_script=buggy_tf,
                policy=policy,
                violations=violations,
            )

        prompt_tokens = cb.prompt_tokens
        completion_tokens = cb.completion_tokens
        model_id = llm_config.get("model", "")
        total_cost = compute_cost(model_id, prompt_tokens, completion_tokens)

    except Exception as exc:
        with progress_lock:
            logger.error(f"[{entry_num}/{total}] Repair error: {exc}")
        return {
            "entry_id": entry["entry_id"],
            "status": "error",
            "reason": str(exc),
            "iterations": 0,
            "prompt_tokens": 0,
            "completion_tokens": 0,
            "total_cost": 0.0,
        }

    if result.success:
        patch_file.write_text(result.repaired_script)
        with progress_lock:
            logger.info(
                f"[{entry_num}/{total}] ✓ Repaired in {result.iterations} iteration(s) "
                f"| tokens: {prompt_tokens}+{completion_tokens} | cost: ${total_cost:.6f}"
            )
        return {
            "entry_id": entry["entry_id"],
            "status": "success",
            "iterations": result.iterations,
            "prompt_tokens": prompt_tokens,
            "completion_tokens": completion_tokens,
            "total_cost": total_cost,
        }
    else:
        with progress_lock:
            logger.warning(
                f"[{entry_num}/{total}] ✗ Failed after {result.iterations} iteration(s) — "
                f"{result.reason}"
            )
        return {
            "entry_id": entry["entry_id"],
            "status": "failed",
            "reason": result.reason or "repair or validation failed",
            "iterations": result.iterations,
            "prompt_tokens": prompt_tokens,
            "completion_tokens": completion_tokens,
            "total_cost": total_cost,
        }


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def main() -> None:
    parser = argparse.ArgumentParser(
        description="RQ2 Model Comparison Experiment Runner"
    )
    parser.add_argument(
        "--model",
        type=str,
        required=True,
        help=(
            "Model name — OpenRouter string for cloud models "
            "(e.g. meta-llama/llama-3.3-70b-instruct) or Ollama model name "
            "(e.g. codellama)"
        ),
    )
    parser.add_argument(
        "--provider",
        type=str,
        default="openrouter",
        choices=["openrouter", "ollama"],
        help="LLM provider (default: openrouter)",
    )
    parser.add_argument(
        "--workers",
        type=int,
        default=1,
        help="Number of parallel workers (default: 1)",
    )
    parser.add_argument(
        "--entry-id",
        type=str,
        default=None,
        help="Run on a single entry by ID (e.g. kics_aws_s3_bucket_with_all_permissions_001)",
    )
    parser.add_argument(
        "--skip-existing",
        action="store_true",
        help="Skip entries that already have a non-empty patch.tf",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Enable DEBUG logging",
    )
    args = parser.parse_args()

    # -----------------------------------------------------------------------
    # Validate prerequisites
    # -----------------------------------------------------------------------
    import os

    load_environment()  # loads .env if present
    if args.provider == "openrouter" and not os.environ.get("OPENROUTER_API_KEY"):
        print("ERROR: OPENROUTER_API_KEY environment variable is not set.")
        sys.exit(1)

    if not SAMPLE_FILE.exists():
        print(
            f"ERROR: Sample file not found at {SAMPLE_FILE}.\n"
            "Run `uv run python sample_rq2.py` first."
        )
        sys.exit(1)

    # -----------------------------------------------------------------------
    # Load sample
    # -----------------------------------------------------------------------
    with open(SAMPLE_FILE) as f:
        sample = json.load(f)

    entries: List[Dict] = sample["entries"]

    # Optional: filter to a single entry for smoke-testing / cost estimation
    if args.entry_id:
        entries = [e for e in entries if e["entry_id"] == args.entry_id]
        if not entries:
            print(f"ERROR: entry_id '{args.entry_id}' not found in the RQ2 sample.")
            sys.exit(1)

    total_entries = len(entries)

    # -----------------------------------------------------------------------
    # Load base config and build LLM config
    # -----------------------------------------------------------------------
    config = load_config("src/config/default_config.yaml")
    llm_config = build_llm_config(args.model, args.provider, config)

    # -----------------------------------------------------------------------
    # Set up logging
    # -----------------------------------------------------------------------
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    model_dir = RESULTS_BASE / safe_model_name(args.model)
    model_dir.mkdir(parents=True, exist_ok=True)
    log_file = str(model_dir / f"execution_{timestamp}.log")

    log_level = "DEBUG" if args.verbose else "INFO"
    logger = setup_logging(level=log_level, log_file=log_file)

    # -----------------------------------------------------------------------
    # Header
    # -----------------------------------------------------------------------
    logger.info("=" * 70)
    logger.info("RQ2 Model Comparison Experiment")
    logger.info("=" * 70)
    logger.info(f"Model:          {args.model}")
    logger.info(f"Provider:       {args.provider}")
    logger.info(f"Temperature:    {llm_config['temperature']}")
    logger.info(f"Max tokens:     {llm_config['max_tokens']}")
    logger.info(f"Max iterations: {config.get('repair', {}).get('max_iterations', 3)}")
    logger.info(f"Sample file:    {SAMPLE_FILE}")
    logger.info(f"Sample size:    {total_entries}")
    logger.info(f"Stratification: {sample.get('stratification', {})}")
    logger.info(f"Workers:        {args.workers}")
    logger.info(f"Log file:       {log_file}")

    # -----------------------------------------------------------------------
    # Run repairs
    # -----------------------------------------------------------------------
    results: List[Dict] = []

    if args.workers == 1:
        logger.info("Running in sequential mode")

        for i, entry in enumerate(entries, 1):
            result = process_entry(
                entry=entry,
                entry_num=i,
                total=total_entries,
                base_path=DATASET_BASE,
                config=config,
                llm_config=llm_config,
                skip_existing=args.skip_existing,
            )
            results.append(result)
    else:
        logger.info(f"Running in parallel mode with {args.workers} workers")
        logger.info("Note: log messages may be interleaved from different workers\n")

        with ThreadPoolExecutor(max_workers=args.workers) as executor:
            future_map = {}
            for i, entry in enumerate(entries, 1):
                future = executor.submit(
                    process_entry,
                    entry,
                    i,
                    total_entries,
                    DATASET_BASE,
                    config,
                    llm_config,
                    args.skip_existing,
                )
                future_map[future] = (i, entry)

            for future in as_completed(future_map):
                i, entry = future_map[future]
                try:
                    results.append(future.result())
                except Exception as exc:
                    logger.error(f"[{i}/{total_entries}] Unexpected error: {exc}")
                    results.append(
                        {
                            "entry_id": entry["entry_id"],
                            "status": "error",
                            "reason": str(exc),
                            "iterations": 0,
                            "prompt_tokens": 0,
                            "completion_tokens": 0,
                            "total_cost": 0.0,
                        }
                    )

    # -----------------------------------------------------------------------
    # Compute standard summary stats
    # -----------------------------------------------------------------------
    successful = [r for r in results if r["status"] == "success"]
    failed = [r for r in results if r["status"] == "failed"]
    errors = [r for r in results if r["status"] == "error"]
    skipped = [r for r in results if r["status"] == "skipped"]
    attempted = [r for r in results if r["status"] != "skipped"]
    n_attempted = len(attempted)
    n_successful = len(successful)

    success_rate = (n_successful / n_attempted * 100) if n_attempted > 0 else 0.0

    logger.info("\n" + "=" * 70)
    logger.info("RESULTS SUMMARY")
    logger.info("=" * 70)
    logger.info(f"Total processed: {len(results)}")
    logger.info(f"Skipped:         {len(skipped)}")
    logger.info(f"Attempted:       {n_attempted}")
    logger.info(f"Successful:      {n_successful}")
    logger.info(f"Failed:          {len(failed)}")
    logger.info(f"Errors:          {len(errors)}")
    logger.info(f"Success rate:    {success_rate:.1f}%")

    if failed:
        logger.info("\nFailed entries:")
        for r in failed:
            logger.info(f"  - {r['entry_id']}: {r.get('reason', 'Unknown')}")

    if errors:
        logger.info("\nError entries:")
        for r in errors:
            logger.info(f"  - {r['entry_id']}: {r.get('reason', 'Unknown')}")

    # -----------------------------------------------------------------------
    # Compute RQ2 metrics
    # -----------------------------------------------------------------------
    # Fix Rate
    fr = success_rate

    # Retry Rate — % of successful repairs that needed >1 iteration
    retried = [r for r in successful if r.get("iterations", 1) > 1]
    rr = (len(retried) / n_successful * 100) if n_successful > 0 else 0.0

    # Mean Repair Attempts — average iterations among successful repairs
    mra = mean(r.get("iterations", 1) for r in successful) if successful else 0.0

    # Cost per Repair
    total_successful_cost = sum(r.get("total_cost", 0.0) for r in successful)
    cpr = (total_successful_cost / n_successful) if n_successful > 0 else 0.0

    # Overall token / cost totals
    total_cost_all = sum(r.get("total_cost", 0.0) for r in attempted)
    total_prompt_tokens = sum(r.get("prompt_tokens", 0) for r in attempted)
    total_completion_tokens = sum(r.get("completion_tokens", 0) for r in attempted)
    total_tokens = total_prompt_tokens + total_completion_tokens

    logger.info("\n" + "=" * 70)
    logger.info("RQ2 METRICS")
    logger.info("=" * 70)
    logger.info(f"Fix Rate (FR):              {fr:.1f}%")
    logger.info(f"Retry Rate (RR):            {rr:.1f}%")
    logger.info(f"Mean Repair Attempts (MRA): {mra:.2f}")
    logger.info(f"Cost per Repair (CPR):      ${cpr:.6f} USD")
    logger.info(f"Total cost (all entries):   ${total_cost_all:.4f} USD")
    logger.info(f"Total tokens used:          {total_tokens:,}")
    logger.info(f"  Prompt tokens:            {total_prompt_tokens:,}")
    logger.info(f"  Completion tokens:        {total_completion_tokens:,}")
    logger.info(f"\nLog file saved to: {log_file}")
    logger.info("=" * 70)
    logger.info("RQ2 experiment complete!")

    # Exit code: non-zero if there were unexpected errors
    sys.exit(1 if errors else 0)


if __name__ == "__main__":
    main()
