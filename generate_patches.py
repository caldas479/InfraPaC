"""
Generate patches for SpecBugFix dataset entries.

This script:
1. Loads each dataset entry
2. Uses the repair agent to fix the buggy code
3. Validates the fix against the policy
4. Saves the repaired code to patch.tf
"""

from datetime import datetime
import json
import sys
from pathlib import Path
from typing import Dict, Optional

from src.agents.repair_agent import RepairAgent
from src.pac_engines.opa_engine import OPAEngine
from src.utils.config_loader import load_config
from src.utils.logging_config import setup_logging


def generate_patch(
    entry: Dict, base_path: Path, repair_agent: RepairAgent, opa_engine: OPAEngine
) -> Optional[str]:
    """Generate patch for a single dataset entry."""
    entry_path = base_path / entry["path"]

    # Load files
    policy_file = entry_path / "policy.rego"
    buggy_file = entry_path / "buggy.tf"
    patch_file = entry_path / "patch.tf"

    policy = policy_file.read_text()
    buggy_tf = buggy_file.read_text()

    # Attempt repair
    result = repair_agent.repair(
        iac_script=buggy_tf,
        policy=policy,
        violations=opa_engine.evaluate(policy, buggy_tf),
    )

    if result.success:
        repaired_code = result.repaired_script
        patch_file.write_text(repaired_code)
        return repaired_code

    else:
        error = result.reason or "Unknown error"
        return None


def main():
    """Generate patches for all dataset entries."""
    import argparse

    parser = argparse.ArgumentParser(
        description="Generate patches for SpecBugFix dataset"
    )
    parser.add_argument(
        "--entry-id",
        type=str,
        help="Generate patch for specific entry ID only (e.g., opa_storage_001)",
    )
    parser.add_argument(
        "--category",
        type=str,
        help="Generate patches for specific category only (e.g., storage, iam)",
    )
    parser.add_argument(
        "--skip-existing",
        action="store_true",
        help="Skip entries that already have non-empty patch.tf files",
    )
    parser.add_argument("--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    # Load configuration first to get model name
    config = load_config("src/config/default_config.yaml")
    
    # Load dataset index to get dataset name
    base_path = Path("data/datasets/spec_bug_fix")
    index_file = base_path / "dataset_index.json"
    
    with open(index_file) as f:
        dataset = json.load(f)
    
    dataset_name = dataset.get('dataset_name', 'spec_bug_fix')
    model_name = config.get('llm', {}).get('model', 'unknown_model')

    # Create log file path
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    results_dir = Path("results") / dataset_name / model_name
    results_dir.mkdir(parents=True, exist_ok=True)
    log_file = str(results_dir / f"execution_{timestamp}.log")
    
    # Setup logging with dataset and model info for automatic log file creation
    log_level = "DEBUG" if args.verbose else "INFO"
    logger = setup_logging(level=log_level, log_file=log_file)

    logger.info("=" * 70)
    logger.info("SpecBugFix Patch Generator")
    logger.info("=" * 70)

    # Initialize engines
    logger.info("Initializing repair agent and OPA engine...")
    opa_engine = OPAEngine(config["opa"])
    repair_agent = RepairAgent(
        opa_engine, config=config.get("repair", {}), llm_config=config.get("llm", {})
    )

    logger.info(f"Dataset: {dataset['dataset_name']} v{dataset['version']}")
    logger.info(f"Total entries: {dataset['total_entries']}")

    # Filter entries if needed
    entries = dataset["entries"]

    if args.entry_id:
        entries = [e for e in entries if e["id"] == args.entry_id]
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

    # Generate patches
    results = []
    for i, entry in enumerate(entries, 1):
        logger.info(
            f"[{i}/{len(entries)}] Processing {entry['id']} ({entry['category']}/{entry['subcategory']})"
        )
        logger.info(f"Violation: {entry['violation']}")

        # Check if patch already exists
        if args.skip_existing:
            patch_path = base_path / entry["path"] / "patch.tf"
            if patch_path.exists() and patch_path.stat().st_size > 0:
                logger.info("Patch already exists, skipping...")
                results.append({"id": entry["id"], "status": "skipped"})
                continue
        try:
            repaired_code = generate_patch(entry, base_path, repair_agent, opa_engine)

            if repaired_code:
                results.append(
                    {
                        "id": entry["id"],
                        "status": "success",
                        "code_length": len(repaired_code),
                    }
                )
            else:
                results.append(
                    {
                        "id": entry["id"],
                        "status": "failed",
                        "reason": "repair or validation failed",
                    }
                )
        except Exception as e:
            logger.error(f"    Error: {e}")
            results.append({"id": entry["id"], "status": "error", "reason": str(e)})

    # Results
    logger.info("=" * 70)
    logger.info("Results")
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

    # Show details
    if failed:
        logger.info("Failed entries:")
        for r in failed:
            logger.info(f"{r['id']}: {r.get('reason', 'Unknown')}")

    if errors:
        logger.info("Error entries:")
        for r in errors:
            logger.info(f"{r['id']}: {r.get('reason', 'Unknown')}")

    # Exit code
    if failed or errors:
        sys.exit(1)
    else:
        logger.info("All patches generated successfully!")
        sys.exit(0)


if __name__ == "__main__":
    main()
