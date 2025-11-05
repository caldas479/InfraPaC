#!/usr/bin/env python3
"""
Generate patches for SpecBugFix dataset entries.

This script:
1. Loads each dataset entry
2. Uses the repair agent to fix the buggy code
3. Validates the fix against the policy
4. Saves the repaired code to patch.tf
"""

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

    print(f"  📝 Original code ({len(buggy_tf)} chars)")

    # Attempt repair
    print(f"  🔧 Attempting repair...")
    result = repair_agent.repair(
        iac_script=buggy_tf,
        policy=policy,
        violations=opa_engine.evaluate(policy, buggy_tf),
    )

    if result.success:
        repaired_code = result.repaired_script
        iterations = result.iterations

        print(f"  ✅ Repair successful after {iterations} iteration(s)")
        print(f"  📄 Repaired code ({len(repaired_code)} chars)")

        # Validate the repaired code
        print(f"  🔍 Validating repaired code...")
        is_valid = opa_engine.validate(policy, repaired_code)

        if is_valid:
            print(f"  ✅ Validation passed - no policy violations")

            # Save to patch.tf
            patch_file.write_text(repaired_code)

            # Get relative path for display
            try:
                relative_path = patch_file.relative_to(Path.cwd())
            except ValueError:
                relative_path = patch_file

            print(f"  💾 Saved to {relative_path}")

            return repaired_code
        else:
            print(f"  ❌ Validation failed - repaired code still has violations")
            violations = opa_engine.evaluate(policy, repaired_code)
            for v in violations:
                print(f"     - {v.message}")
            return None
    else:
        error = result.reason or "Unknown error"
        print(f"  ❌ Repair failed: {error}")
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

    # Setup logging
    log_level = "DEBUG" if args.verbose else "INFO"
    setup_logging(level=log_level)

    print("=" * 70)
    print("SpecBugFix Patch Generator")
    print("=" * 70)

    # Load configuration
    config = load_config("src/config/default_config.yaml")

    # Initialize engines
    print("\n🔧 Initializing repair agent and OPA engine...")
    opa_engine = OPAEngine(config["opa"])
    repair_agent = RepairAgent(
        opa_engine, config=config.get("repair", {}), llm_config=config.get("llm", {})
    )

    # Load dataset index
    base_path = Path("data/datasets/spec_bug_fix")
    index_file = base_path / "dataset_index.json"

    with open(index_file) as f:
        dataset = json.load(f)

    print(f"\n📊 Dataset: {dataset['dataset_name']} v{dataset['version']}")
    print(f"Total entries: {dataset['total_entries']}\n")

    # Filter entries if needed
    entries = dataset["entries"]

    if args.entry_id:
        entries = [e for e in entries if e["id"] == args.entry_id]
        if not entries:
            print(f"❌ Entry ID '{args.entry_id}' not found in dataset")
            sys.exit(1)
        print(f"🎯 Filtering to entry: {args.entry_id}\n")

    if args.category:
        entries = [e for e in entries if e["category"] == args.category]
        if not entries:
            print(f"❌ No entries found for category '{args.category}'")
            sys.exit(1)
        print(f"🎯 Filtering to category: {args.category} ({len(entries)} entries)\n")

    # Generate patches
    results = []
    for i, entry in enumerate(entries, 1):
        print(
            f"\n[{i}/{len(entries)}] Processing {entry['id']} ({entry['category']}/{entry['subcategory']})"
        )
        print(f"  📋 Violation: {entry['violation']}")

        # Check if patch already exists
        if args.skip_existing:
            patch_file = base_path / entry["path"] / "patch.tf"
            if patch_file.exists():
                content = patch_file.read_text().strip()
                if content and not content.startswith("# This file will be populated"):
                    print(f"  ⏭️  Skipping - patch.tf already exists")
                    results.append(
                        {
                            "id": entry["id"],
                            "status": "skipped",
                            "reason": "patch exists",
                        }
                    )
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
            print(f"  ❌ Error: {e}")
            results.append({"id": entry["id"], "status": "error", "reason": str(e)})

    # Summary
    print("\n" + "=" * 70)
    print("SUMMARY")
    print("=" * 70)

    successful = [r for r in results if r["status"] == "success"]
    failed = [r for r in results if r["status"] == "failed"]
    errors = [r for r in results if r["status"] == "error"]
    skipped = [r for r in results if r["status"] == "skipped"]

    print(f"\nTotal processed: {len(results)}")
    print(f"✅ Successful: {len(successful)}")
    print(f"❌ Failed: {len(failed)}")
    print(f"⚠️  Errors: {len(errors)}")
    print(f"⏭️  Skipped: {len(skipped)}")

    if successful:
        success_rate = len(successful) / len(results) * 100
        print(f"\n📈 Success rate: {success_rate:.1f}%")

    # Show details
    if failed:
        print("\n❌ Failed entries:")
        for r in failed:
            print(f"  - {r['id']}: {r.get('reason', 'Unknown')}")

    if errors:
        print("\n⚠️  Error entries:")
        for r in errors:
            print(f"  - {r['id']}: {r.get('reason', 'Unknown')}")

    # Exit code
    if failed or errors:
        sys.exit(1)
    else:
        print("\n🎉 All patches generated successfully!")
        sys.exit(0)


if __name__ == "__main__":
    main()
