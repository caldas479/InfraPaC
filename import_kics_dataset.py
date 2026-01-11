#!/usr/bin/env python3
"""
Import test cases from Checkmarx/kics repository into InfraPaC dataset format.
"""
import json
import logging
import shutil
from pathlib import Path
from typing import Dict, List

# Setup logging
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)


def find_kics_queries(kics_path: Path, provider: str = "aws") -> List[Path]:
    """
    Find all kics query directories for a specific provider.

    Args:
        kics_path: Path to kics repository
        provider: Cloud provider (aws, azure, gcp, etc.)

    Returns:
        List of query directory paths
    """
    queries_path = kics_path / "assets" / "queries" / "terraform" / provider
    if not queries_path.exists():
        logger.error(f"Queries path not found: {queries_path}")
        return []

    # Find all directories with a query.rego file
    query_dirs = []
    for query_dir in queries_path.iterdir():
        if query_dir.is_dir() and (query_dir / "query.rego").exists():
            query_dirs.append(query_dir)

    logger.info(f"Found {len(query_dirs)} queries for provider '{provider}'")
    return query_dirs


def load_metadata(query_dir: Path) -> Dict:
    """Load metadata.json from query directory."""
    metadata_file = query_dir / "metadata.json"
    if metadata_file.exists():
        with open(metadata_file, "r") as f:
            return json.load(f)
    return {}


def import_query_to_dataset(
    query_dir: Path, dataset_path: Path, provider: str, max_positive_tests: int = 3
) -> List[str]:
    """
    Import a single kics query with its test cases into our dataset.

    Args:
        query_dir: Path to kics query directory
        dataset_path: Path to our dataset root
        provider: Cloud provider name
        max_positive_tests: Maximum number of positive (buggy) test cases to import

    Returns:
        List of created entry IDs
    """
    query_name = query_dir.name
    metadata = load_metadata(query_dir)

    # Read the policy
    policy_file = query_dir / "query.rego"
    if not policy_file.exists():
        logger.warning(f"No query.rego found in {query_dir}")
        return []

    # Find test cases
    test_dir = query_dir / "test"
    if not test_dir.exists():
        logger.warning(f"No test directory found in {query_dir}")
        return []

    positive_files = sorted(test_dir.glob("positive*.tf"))[:max_positive_tests]
    negative_files = sorted(test_dir.glob("negative*.tf"))

    if not positive_files:
        logger.warning(f"No positive test cases found in {query_dir}")
        return []

    logger.info(f"Importing '{query_name}': {len(positive_files)} positive tests")

    created_entries = []

    # Create entries for each positive test case
    for idx, positive_file in enumerate(positive_files, 1):
        # Create entry ID
        entry_id = f"kics_{provider}_{query_name}_{idx:03d}"
        entry_path = dataset_path / provider / entry_id
        entry_path.mkdir(parents=True, exist_ok=True)

        # Copy policy
        shutil.copy(policy_file, entry_path / "policy.rego")

        # Copy buggy file
        shutil.copy(positive_file, entry_path / "buggy.tf")

        # If there's a corresponding negative file, use it as reference
        if idx <= len(negative_files):
            negative_file = negative_files[idx - 1]
            shutil.copy(negative_file, entry_path / "fixed.tf")

        # Create metadata file
        entry_metadata = {
            "entry_id": entry_id,
            "category": provider,
            "policy_engine": "opa",
            "iac_tool": "terraform",
            "source": "kics",
            "original_query": query_name,
            "description": metadata.get("description", ""),
            "severity": metadata.get("severity", "UNKNOWN"),
            "query_id": metadata.get("id", ""),
            "query_name": metadata.get("queryName", query_name),
        }

        with open(entry_path / "metadata.json", "w") as f:
            json.dump(entry_metadata, f, indent=2)

        created_entries.append(entry_id)
        logger.debug(f"Created entry: {entry_id}")

    return created_entries


def update_dataset_index(dataset_path: Path, all_entries: List[Dict]):
    """Update or create dataset_index.json with all entries."""
    index_file = dataset_path / "dataset_index.json"

    index_data = {
        "dataset_name": "spec_bug_fix_kics",
        "version": "1.0.0",
        "source": "Checkmarx/kics",
        "description": "Dataset imported from Checkmarx KICS OPA policies and test cases",
        "total_entries": len(all_entries),
        "entries": all_entries,
    }

    with open(index_file, "w") as f:
        json.dump(index_data, f, indent=2)

    logger.info(f"Updated dataset index: {index_file}")


def main():
    """Main import function."""
    # Paths
    kics_path = Path("data/external-repos/kics")
    dataset_path = Path("data/datasets/spec_bug_fix_kics")

    if not kics_path.exists():
        logger.error(f"KICS repository not found at {kics_path}")
        logger.error(
            "Please clone it first: git clone https://github.com/Checkmarx/kics.git data/external-repos/kics"
        )
        return

    # Create dataset directory
    dataset_path.mkdir(parents=True, exist_ok=True)

    # Import queries by provider
    providers = [
        "aws",
        "gcp",
        "azure",
        "kubernetes",
        "github",
    ]  # Start with AWS, can add more later
    all_entries = []

    for provider in providers:
        logger.info(f"\n{'='*80}")
        logger.info(f"Importing {provider.upper()} queries")
        logger.info(f"{'='*80}")

        query_dirs = find_kics_queries(kics_path, provider)

        for query_dir in query_dirs:
            entry_ids = import_query_to_dataset(
                query_dir,
                dataset_path,
                provider,
                max_positive_tests=2,  # Import up to 2 positive tests per query
            )

            for entry_id in entry_ids:
                all_entries.append(
                    {
                        "entry_id": entry_id,
                        "category": provider,
                        "path": f"{provider}/{entry_id}",
                    }
                )

    # Update index
    update_dataset_index(dataset_path, all_entries)

    logger.info(f"\n{'='*80}")
    logger.info(f"Import complete!")
    logger.info(f"Total entries created: {len(all_entries)}")
    logger.info(f"Dataset location: {dataset_path}")
    logger.info(f"{'='*80}")

    # Print summary by category
    from collections import Counter

    category_counts = Counter(entry["category"] for entry in all_entries)
    logger.info(f"\nEntries by category:")
    for category, count in category_counts.items():
        logger.info(f"  {category}: {count} entries")


if __name__ == "__main__":
    main()
