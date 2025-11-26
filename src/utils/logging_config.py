# ============================================================================
# src/utils/logging_config.py
# ============================================================================

import logging
import sys
from pathlib import Path
from typing import Optional

import colorlog


def setup_logging(
    level: str = "INFO",
    log_file: Optional[str] = None,
    format_string: Optional[str] = None,
) -> logging.Logger:
    """
    Configure logging for the application with colored output.

    Args:
        level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        log_file: Optional path to log file
        format_string: Optional custom format string

    Returns:
        Configured logger instance
    """
    if format_string is None:
        # Color format for console
        console_format = (
            "%(log_color)s%(asctime)s - %(name)s - %(levelname)s%(reset)s - "
            "%(blue)s%(message)s"
        )
        # Standard format for file
        file_format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    else:
        console_format = file_format = format_string

    # Create colored formatter for console
    console_formatter = colorlog.ColoredFormatter(
        console_format,
        datefmt="%Y-%m-%d %H:%M:%S",
        reset=True,
        log_colors={
            "DEBUG": "cyan",
            "INFO": "green",
            "WARNING": "yellow",
            "ERROR": "red",
            "CRITICAL": "red,bg_white",
        },
        secondary_log_colors={},
        style="%",
    )

    # Create standard formatter for file
    file_formatter = logging.Formatter(file_format)

    # Setup root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(level)

    # Clear existing handlers
    root_logger.handlers.clear()

    # Console handler with colors
    console_handler = colorlog.StreamHandler(sys.stdout)
    console_handler.setFormatter(console_formatter)
    root_logger.addHandler(console_handler)

    # File handler (if specified)
    if log_file:
        log_path = Path(log_file)
        log_path.parent.mkdir(parents=True, exist_ok=True)
        file_handler = logging.FileHandler(log_path)
        file_handler.setFormatter(file_formatter)
        root_logger.addHandler(file_handler)

    return root_logger
