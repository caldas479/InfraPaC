"""Pytest configuration and fixtures."""

from pathlib import Path
from typing import Any, Dict

import pytest

from src.models import PolicyViolation


@pytest.fixture
def sample_opa_config() -> Dict[str, Any]:
    """Sample OPA configuration for testing."""
    return {
        "binary_path": "opa",
        "timeout": 30,
    }


@pytest.fixture
def sample_kics_config() -> Dict[str, Any]:
    """Sample KICS configuration for testing."""
    return {
        "binary_path": "kics",
        "timeout": 60,
    }


@pytest.fixture
def sample_llm_config() -> Dict[str, Any]:
    """Sample LLM configuration for testing."""
    return {
        "provider": "ollama",
        "model": "codellama",
        "temperature": 0.2,
        "max_tokens": 2048,
        "base_url": "http://localhost:11434",
    }


@pytest.fixture
def sample_repair_config() -> Dict[str, Any]:
    """Sample repair configuration for testing."""
    return {
        "max_iterations": 3,
        "validation_timeout": 30,
    }


@pytest.fixture
def sample_policy_violation() -> PolicyViolation:
    """Sample policy violation for testing."""
    return PolicyViolation(
        message="S3 bucket 'test-bucket' must have versioning enabled",
        severity="error",
        resource="aws_s3_bucket.test",
        line=5,
    )


@pytest.fixture
def sample_terraform_script() -> str:
    """Sample Terraform script for testing."""
    return """resource "aws_s3_bucket" "test" {
  bucket = "test-bucket"
  acl    = "private"
}
"""


@pytest.fixture
def sample_rego_policy() -> str:
    """Sample Rego policy for testing."""
    return """package terraform

deny contains msg if {
    bucket := input.resource.aws_s3_bucket[_]
    not bucket.versioning.enabled
    msg := sprintf("S3 bucket '%v' must have versioning enabled", [bucket.bucket])
}
"""


@pytest.fixture
def examples_dir() -> Path:
    """Path to examples directory."""
    return Path(__file__).parent.parent / "examples"


@pytest.fixture
def test_data_dir() -> Path:
    """Path to test data directory."""
    return Path(__file__).parent / "data"
