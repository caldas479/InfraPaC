"""
Unit tests for LLM configuration validation.
"""

import pytest

from src.utils.llm_validator import (
    LLMValidationError,
    get_supported_models,
    validate_llm_config,
)


def test_validate_valid_openai_model():
    """Test validation with valid OpenAI model."""
    validate_llm_config("openai", "gpt-4")  # Should not raise


def test_validate_valid_ollama_model():
    """Test validation with valid Ollama model."""
    validate_llm_config("ollama", "codellama")  # Should not raise


def test_validate_invalid_provider():
    """Test validation with invalid provider."""
    with pytest.raises(LLMValidationError, match="Unknown provider"):
        validate_llm_config("invalid-provider", "some-model")


def test_validate_invalid_openai_model():
    """Test validation with invalid OpenAI model."""
    with pytest.raises(LLMValidationError, match="not a known OpenAI model"):
        validate_llm_config("openai", "invalid-model")


def test_validate_unknown_ollama_model():
    """Test validation with unknown Ollama model (should pass)."""
    validate_llm_config("ollama", "custom-model")  # Should not raise


def test_get_supported_models():
    """Test getting supported models for a provider."""
    openai_models = get_supported_models("openai")
    assert openai_models is not None
    assert "gpt-4" in openai_models

    ollama_models = get_supported_models("ollama")
    assert ollama_models is not None
    assert "codellama" in ollama_models

    invalid = get_supported_models("invalid")
    assert invalid is None
