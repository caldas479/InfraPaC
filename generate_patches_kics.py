"""
Generate patches for KICS-imported dataset entries.

This script:
1. Loads each kics dataset entry
2. Uses the repair agent to fix the buggy code
3. Validates the fix against the policy
4. Saves the repaired code to patch.tf
"""

import argparse
import json
import logging
import sys
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

from src.agents.repair_agent import RepairAgent
from src.pac_engines.kics_engine import KICSEngine
from src.utils.config_loader import load_config
from src.utils.logging_config import setup_logging

# Thread-safe counter for progress tracking
progress_lock = threading.Lock()


def generate_patch(
    entry: Dict, base_path: Path, repair_agent: RepairAgent, kics_engine: KICSEngine
) -> Optional[str]:
    """Generate patch for a single dataset entry."""
    entry_path = base_path / entry["path"]

    # Load files
    policy_file = entry_path / "policy.rego"
    buggy_file = entry_path / "buggy.tf"
    patch_file = entry_path / "patch.tf"
    metadata_file = entry_path / "metadata.json"

    policy = policy_file.read_text()
    buggy_tf = buggy_file.read_text()

    # Load metadata if it exists
    metadata = None
    if metadata_file.exists():
        try:
            metadata = json.loads(metadata_file.read_text())
        except json.JSONDecodeError as e:
            logging.getLogger(__name__).warning(
                f"Failed to parse metadata.json for {entry['entry_id']}: {e}"
            )

    # Attempt repair
    result = repair_agent.repair(
        iac_script=buggy_tf,
        policy=policy,
        violations=kics_engine.evaluate(policy, buggy_tf, metadata),
    )

    if result.success:
        repaired_code = result.repaired_script
        patch_file.write_text(repaired_code)
        return repaired_code

    else:
        error = result.reason or "Unknown error"
        return None


def process_entry_wrapper(
    entry: Dict,
    entry_num: int,
    total_entries: int,
    base_path: Path,
    skip_existing: bool,
    config: Dict,
) -> Dict:
    """
    Wrapper function for processing a single entry (thread-safe).

    Returns a result dictionary with status information.
    """
    logger = logging.getLogger(__name__)

    with progress_lock:
        logger.info(
            f"\n[{entry_num}/{total_entries}] Processing {entry['entry_id']} ({entry['category']})"
        )

    try:
        # Check if patch already exists
        if skip_existing:
            patch_path = base_path / entry["path"] / "patch.tf"
            if patch_path.exists() and patch_path.stat().st_size > 0:
                with progress_lock:
                    logger.info(
                        f"[{entry_num}/{total_entries}] Patch already exists, skipping..."
                    )
                return {"entry_id": entry["entry_id"], "status": "skipped"}

        # Create new engine instances per thread (not thread-safe to share)
        kics_engine = KICSEngine(config["kics"])
        repair_agent = RepairAgent(
            kics_engine,
            config=config.get("repair", {}),
            llm_config=config.get("llm", {}),
        )

        repaired_code = generate_patch(entry, base_path, repair_agent, kics_engine)

        if repaired_code:
            with progress_lock:
                logger.info(
                    f"[{entry_num}/{total_entries}] ✓ Successfully generated patch"
                )
            return {
                "entry_id": entry["entry_id"],
                "status": "success",
                "code_length": len(repaired_code),
            }
        else:
            with progress_lock:
                logger.warning(
                    f"[{entry_num}/{total_entries}] ✗ Failed to generate patch"
                )
            return {
                "entry_id": entry["entry_id"],
                "status": "failed",
                "reason": "repair or validation failed",
            }

    except Exception as e:
        with progress_lock:
            logger.error(f"[{entry_num}/{total_entries}] ✗ Error: {e}")
        return {"entry_id": entry["entry_id"], "status": "error", "reason": str(e)}


def main():
    """Generate patches for kics dataset entries."""
    parser = argparse.ArgumentParser(
        description="Generate patches for KICS-imported dataset"
    )
    parser.add_argument(
        "--entry-id",
        type=str,
        help="Generate patch for specific entry ID only (e.g., kics_aws_s3_bucket_without_versioning_001)",
    )
    parser.add_argument(
        "--category",
        type=str,
        help="Generate patches for specific category only (e.g., aws, azure, gcp)",
    )
    parser.add_argument(
        "--skip-existing",
        action="store_true",
        help="Skip entries that already have non-empty patch.tf files",
    )
    parser.add_argument(
        "--workers",
        type=int,
        default=1,
        help="Number of parallel workers (default: 1 for sequential processing)",
    )
    parser.add_argument("--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    # Load configuration first to get model name
    config = load_config("src/config/default_config.yaml")

    # Load dataset index
    base_path = Path("data/datasets/spec_bug_fix_kics")
    index_file = base_path / "dataset_index.json"

    if not index_file.exists():
        print(f"Error: Dataset index not found at {index_file}")
        print("Please run import_kics_dataset.py first to import kics examples")
        sys.exit(1)

    with open(index_file) as f:
        dataset = json.load(f)

    dataset_name = dataset.get("dataset_name", "spec_bug_fix_kics")
    model_name = config.get("llm", {}).get("model", "unknown_model")

    # Create log file path
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    results_dir = Path("results") / dataset_name / model_name
    results_dir.mkdir(parents=True, exist_ok=True)
    log_file = str(results_dir / f"execution_{timestamp}.log")

    # Setup logging
    log_level = "DEBUG" if args.verbose else "INFO"
    logger = setup_logging(level=log_level, log_file=log_file)

    logger.info("=" * 70)
    logger.info("KICS Dataset Patch Generator")
    logger.info("=" * 70)

    logger.info(f"Dataset: {dataset['dataset_name']} v{dataset['version']}")
    logger.info(f"Total entries: {dataset['total_entries']}")
    logger.info(f"Workers: {args.workers}")

    # Filter entries if needed
    entries = dataset["entries"]

    if args.entry_id:
        entries = [e for e in entries if e["entry_id"] == args.entry_id]
        if not entries:
            logger.error(f"Entry ID '{args.entry_id}' not found in dataset")
            sys.exit(1)
        logger.info(f"Filtering to entry: {args.entry_id}\n")

    if args.category:
        entries = [e for e in entries if e["category"] == args.category]
        if not entries:
            logger.info(f"No entries found for category '{args.category}'")
            sys.exit(1)
        logger.info(f"Filtering to category: {args.category} ({len(entries)} entries)")

    # Generate patches (parallel or sequential based on workers)
    results = []

    if args.workers == 1:
        # Sequential processing (original behavior)
        logger.info("Running in sequential mode")
        kics_engine = KICSEngine(config["kics"])
        repair_agent = RepairAgent(
            kics_engine,
            config=config.get("repair", {}),
            llm_config=config.get("llm", {}),
        )

        for i, entry in enumerate(entries, 1):
            logger.info(
                f"\n[{i}/{len(entries)}] Processing {entry['entry_id']} ({entry['category']})"
            )

            # Check if patch already exists
            if args.skip_existing:
                patch_path = base_path / entry["path"] / "patch.tf"
                if patch_path.exists() and patch_path.stat().st_size > 0:
                    logger.info("Patch already exists, skipping...")
                    results.append({"entry_id": entry["entry_id"], "status": "skipped"})
                    continue
            try:
                repaired_code = generate_patch(
                    entry, base_path, repair_agent, kics_engine
                )

                if repaired_code:
                    logger.info("✓ Successfully generated patch")
                    results.append(
                        {
                            "entry_id": entry["entry_id"],
                            "status": "success",
                            "code_length": len(repaired_code),
                        }
                    )
                else:
                    logger.warning("✗ Failed to generate patch")
                    results.append(
                        {
                            "entry_id": entry["entry_id"],
                            "status": "failed",
                            "reason": "repair or validation failed",
                        }
                    )
            except Exception as e:
                logger.error(f"✗ Error: {e}")
                results.append(
                    {"entry_id": entry["entry_id"], "status": "error", "reason": str(e)}
                )
    else:
        # Parallel processing with ThreadPoolExecutor
        logger.info(f"Running in parallel mode with {args.workers} workers")
        logger.info("Note: Log messages may be interleaved from different workers\n")

        with ThreadPoolExecutor(max_workers=args.workers) as executor:
            # Submit all tasks
            future_to_entry = {}
            for i, entry in enumerate(entries, 1):
                future = executor.submit(
                    process_entry_wrapper,
                    entry,
                    i,
                    len(entries),
                    base_path,
                    args.skip_existing,
                    config,
                )
                future_to_entry[future] = (i, entry)

            # Collect results as they complete
            for future in as_completed(future_to_entry):
                i, entry = future_to_entry[future]
                try:
                    result = future.result()
                    results.append(result)
                except Exception as e:
                    logger.error(f"[{i}/{len(entries)}] Unexpected error: {e}")
                    results.append(
                        {
                            "entry_id": entry["entry_id"],
                            "status": "error",
                            "reason": str(e),
                        }
                    )

    # Results summary
    logger.info("\n" + "=" * 70)
    logger.info("RESULTS SUMMARY")
    logger.info("=" * 70)

    successful = [r for r in results if r["status"] == "success"]
    failed = [r for r in results if r["status"] == "failed"]
    errors = [r for r in results if r["status"] == "error"]
    skipped = [r for r in results if r["status"] == "skipped"]
    attempted = len(results) - len(skipped)
    success_rate = (len(successful) / attempted * 100) if attempted > 0 else 0.0

    logger.info(f"Total processed: {len(results)}")
    logger.info(f"Skipped: {len(skipped)}")
    logger.info(f"Attempted: {attempted}")
    logger.info(f"Successful: {len(successful)}")
    logger.info(f"Failed: {len(failed)}")
    logger.info(f"Errors: {len(errors)}")
    logger.info(f"Success rate: {success_rate:.1f}%")

    # Show failed entries
    if failed:
        logger.info("\nFailed entries:")
        for r in failed:
            logger.info(f"  - {r['entry_id']}: {r.get('reason', 'Unknown')}")

    if errors:
        logger.info("\nError entries:")
        for r in errors:
            logger.info(f"  - {r['entry_id']}: {r.get('reason', 'Unknown')}")

    logger.info(f"\nLog file saved to: {log_file}")
    logger.info("=" * 70)

    # Exit code
    if errors:
        sys.exit(1)
    else:
        logger.info("Patch generation complete!")
        sys.exit(0)


if __name__ == "__main__":
    main()
