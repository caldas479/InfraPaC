# ============================================================================
# src/utils/env_loader.py
# ============================================================================

import os
from pathlib import Path
from typing import Optional

from dotenv import load_dotenv


def load_environment(env_file: Optional[str] = None) -> None:
    """
    Load environment variables from .env file.
    
    Args:
        env_file: Path to .env file. If None, searches for .env in project root.
    """
    if env_file:
        env_path = Path(env_file)
    else:
        # Search for .env in current directory and parent directories
        current_dir = Path.cwd()
        env_path = current_dir / ".env"
        
        if not env_path.exists():
            # Try parent directories
            for parent in current_dir.parents:
                env_path = parent / ".env"
                if env_path.exists():
                    break
    
    if env_path.exists():
        load_dotenv(env_path)
    else:
        # No .env file found, rely on system environment variables
        pass


def get_env_variable(key: str, default: Optional[str] = None, required: bool = False) -> Optional[str]:
    """
    Get environment variable with optional default and validation.
    
    Args:
        key: Environment variable name
        default: Default value if not found
        required: If True, raises ValueError when variable is not set
    
    Returns:
        Environment variable value or default
    
    Raises:
        ValueError: If required=True and variable is not set
    """
    value = os.getenv(key, default)
    
    if required and value is None:
        raise ValueError(f"Required environment variable '{key}' is not set")
    
    return value