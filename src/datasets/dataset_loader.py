# ============================================================================
# src/datasets/dataset_loader.py
# ============================================================================

import json
from pathlib import Path
from typing import Iterator, List, Optional

from .models import DatasetEntry, IaCScript, Policy, PolicyViolation


class DatasetLoader:
    """
    Loader for Spec-Bug-Fix datasets.

    Supports loading datasets in various formats (JSON, JSONL).
    """

    def __init__(self, base_path: str, cache_enabled: bool = True) -> None:
        """
        Initialize dataset loader.

        Args:
            base_path: Base directory containing datasets
            cache_enabled: Whether to enable dataset caching
        """
        self.base_path = Path(base_path)
        self.cache_enabled = cache_enabled
        self._cache: List[DatasetEntry] = []

    def load(self, dataset_name: Optional[str] = None) -> List[DatasetEntry]:
        """
        Load dataset from disk.

        Args:
            dataset_name: Specific dataset to load. If None, loads all datasets.

        Returns:
            List of dataset entries
        """
        if self.cache_enabled and self._cache:
            return self._cache

        entries = []

        if dataset_name:
            dataset_path = self.base_path / dataset_name
            entries = self._load_from_path(dataset_path)
        else:
            # Load all datasets in base_path
            for dataset_dir in self.base_path.iterdir():
                if dataset_dir.is_dir():
                    entries.extend(self._load_from_path(dataset_dir))

        if self.cache_enabled:
            self._cache = entries

        return entries

    def _load_from_path(self, path: Path) -> List[DatasetEntry]:
        """Load dataset entries from a specific path."""
        entries = []

        # Try loading JSON file
        json_file = path / "dataset.json"
        if json_file.exists():
            entries.extend(self._load_json(json_file))

        # Try loading JSONL file
        jsonl_file = path / "dataset.jsonl"
        if jsonl_file.exists():
            entries.extend(self._load_jsonl(jsonl_file))

        return entries

    def _load_json(self, file_path: Path) -> List[DatasetEntry]:
        """Load dataset from JSON file."""
        with open(file_path, "r") as f:
            data = json.load(f)

        if isinstance(data, list):
            return [self._parse_entry(entry) for entry in data]
        elif isinstance(data, dict) and "entries" in data:
            return [self._parse_entry(entry) for entry in data["entries"]]
        else:
            return [self._parse_entry(data)]

    def _load_jsonl(self, file_path: Path) -> List[DatasetEntry]:
        """Load dataset from JSONL file."""
        entries = []
        with open(file_path, "r") as f:
            for line in f:
                if line.strip():
                    entry_data = json.loads(line)
                    entries.append(self._parse_entry(entry_data))
        return entries

    def _parse_entry(self, data: dict) -> DatasetEntry:
        """Parse a dataset entry from dictionary."""
        return DatasetEntry(**data)

    def iterate(self, batch_size: Optional[int] = None) -> Iterator[DatasetEntry]:
        """
        Iterate over dataset entries.

        Args:
            batch_size: If specified, yields batches of entries

        Yields:
            Dataset entries or batches of entries
        """
        entries = self.load()

        if batch_size:
            for i in range(0, len(entries), batch_size):
                yield entries[i : i + batch_size]
        else:
            yield from entries
