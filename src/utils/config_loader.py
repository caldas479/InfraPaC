# ===========================================================================
# src/utils/config_loader.py
# ============================================================================

import json
from pathlib import Path
from typing import Any, Dict

import yaml


def load_config(config_path: str) -> Dict[str, Any]:
    """
    Load configuration from YAML or JSON file.

    Args:
        config_path: Path to configuration file

    Returns:
        Configuration dictionary

    Raises:
        FileNotFoundError: If config file doesn't exist
        ValueError: If file format is not supported
    """
    path = Path(config_path)

    if not path.exists():
        raise FileNotFoundError(f"Configuration file not found: {config_path}")

    suffix = path.suffix.lower()

    if suffix in [".yaml", ".yml"]:
        with open(path, "r") as f:
            return yaml.safe_load(f)
    elif suffix == ".json":
        with open(path, "r") as f:
            return json.load(f)
    else:
        raise ValueError(f"Unsupported configuration file format: {suffix}")


def save_config(config: Dict[str, Any], config_path: str) -> None:
    """
    Save configuration to YAML or JSON file.

    Args:
        config: Configuration dictionary
        config_path: Path to save configuration
    """
    path = Path(config_path)
    path.parent.mkdir(parents=True, exist_ok=True)

    suffix = path.suffix.lower()

    if suffix in [".yaml", ".yml"]:
        with open(path, "w") as f:
            yaml.dump(config, f, default_flow_style=False)
    elif suffix == ".json":
        with open(path, "w") as f:
            json.dump(config, f, indent=2)
    else:
        raise ValueError(f"Unsupported configuration file format: {suffix}")


def merge_configs(*configs: Dict[str, Any]) -> Dict[str, Any]:
    """
    Merge multiple configuration dictionaries.
    Later configs override earlier ones.

    Args:
        *configs: Configuration dictionaries to merge

    Returns:
        Merged configuration dictionary
    """
    merged = {}

    for config in configs:
        _deep_merge(merged, config)

    return merged


def _deep_merge(base: Dict[str, Any], update: Dict[str, Any]) -> None:
    """
    Deep merge update dict into base dict (in-place).

    Args:
        base: Base dictionary to update
        update: Dictionary with updates
    """
    for key, value in update.items():
        if key in base and isinstance(base[key], dict) and isinstance(value, dict):
            _deep_merge(base[key], value)
        else:
            base[key] = value
