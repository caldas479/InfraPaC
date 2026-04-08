"""
Generate and save the fixed 200-entry stratified sample for RQ2 (and RQ3).

Stratification (seed=42):
  aws:        97 entries
  azure:      48 entries
  kubernetes: 29 entries
  gcp:        24 entries
  github:      2 entries
  ─────────────────────────
  total:     200 entries

Run once before any model experiments:
    uv run python sample_rq2.py

Output: data/rq2_sample.json
"""

import json
import random
import sys
from collections import defaultdict
from pathlib import Path

# ---------------------------------------------------------------------------
# Stratification targets
# ---------------------------------------------------------------------------
TARGETS: dict[str, int] = {
    "aws": 97,
    "azure": 48,
    "kubernetes": 29,
    "gcp": 24,
    "github": 2,  # only 2 exist in the dataset
}
SEED = 42
SAMPLE_SIZE = sum(TARGETS.values())  # 200

DATASET_INDEX = Path("data/datasets/spec_bug_fix_kics/dataset_index.json")
OUTPUT_FILE = Path("data/rq2_sample.json")


def main() -> None:
    # Guard: don't overwrite an existing sample
    if OUTPUT_FILE.exists():
        print(
            f"[sample_rq2] Sample already exists at {OUTPUT_FILE} — skipping generation.\n"
            "Delete the file if you want to regenerate."
        )
        sys.exit(0)

    # Load dataset index
    if not DATASET_INDEX.exists():
        print(f"[sample_rq2] ERROR: Dataset index not found at {DATASET_INDEX}")
        sys.exit(1)

    with open(DATASET_INDEX) as f:
        dataset = json.load(f)

    # Group by category
    by_category: dict[str, list] = defaultdict(list)
    for entry in dataset["entries"]:
        by_category[entry["category"]].append(entry)

    print("[sample_rq2] Dataset category sizes:")
    for cat, entries in sorted(by_category.items()):
        print(f"  {cat:12s}: {len(entries):4d} available")

    # Sample per category
    rng = random.Random(SEED)
    sampled: list[dict] = []
    actual_counts: dict[str, int] = {}

    for cat, target in TARGETS.items():
        available = by_category.get(cat, [])
        n = min(target, len(available))
        chosen = rng.sample(available, n)
        sampled.extend(chosen)
        actual_counts[cat] = n
        if n < target:
            print(
                f"  [WARNING] {cat}: only {n} entries available (target was {target})"
            )

    # Deterministic order: sort by entry_id so the list is stable
    sampled.sort(key=lambda e: e["entry_id"])

    output = {
        "sample_size": len(sampled),
        "target_size": SAMPLE_SIZE,
        "stratification": actual_counts,
        "seed": SEED,
        "source_dataset": dataset.get("dataset_name", "spec_bug_fix_kics"),
        "source_version": dataset.get("version", "unknown"),
        "entries": sampled,
    }

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_FILE, "w") as f:
        json.dump(output, f, indent=2)

    print(f"\n[sample_rq2] Saved {len(sampled)}-entry sample to {OUTPUT_FILE}")
    print("[sample_rq2] Actual counts per category:")
    for cat, n in sorted(actual_counts.items()):
        print(f"  {cat:12s}: {n:3d}")


if __name__ == "__main__":
    main()
