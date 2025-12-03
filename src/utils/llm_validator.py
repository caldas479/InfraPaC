"""
Validation utilities for LLM provider and model configurations.
"""

from typing import Dict, List, Optional


class LLMValidationError(Exception):
    """Raised when LLM configuration is invalid."""
    pass


# Define compatible models for each provider
PROVIDER_MODELS: Dict[str, List[str]] = {
    "ollama": [
        "codellama",
        "llama2",
        "mistral",
        "phi",
        "deepseek-coder",
        "qwen",
        "gemma",
        # Add more Ollama models as needed
    ],
    "openai": [
        "gpt-4",
        "gpt-4-turbo",
        "gpt-4-turbo-preview",
        "gpt-3.5-turbo",
        "gpt-3.5-turbo-16k",
        # Add more OpenAI models as needed
    ],
}


def validate_llm_config(provider: str, model: str) -> None:
    """
    Validate that the model is compatible with the provider.
    
    Args:
        provider: LLM provider (e.g., 'ollama', 'openai')
        model: Model name (e.g., 'codellama', 'gpt-4')
        
    Raises:
        LLMValidationError: If provider is unknown or model is incompatible
    """
    if provider not in PROVIDER_MODELS:
        supported = ", ".join(PROVIDER_MODELS.keys())
        raise LLMValidationError(
            f"Unknown provider '{provider}'. Supported providers: {supported}"
        )
    
    # Check if model is in the known list for this provider
    # Note: This is a soft check - we allow unknown models with a warning
    if model not in PROVIDER_MODELS[provider]:
        # For OpenAI, be strict about model names
        if provider == "openai":
            supported = ", ".join(PROVIDER_MODELS["openai"])
            raise LLMValidationError(
                f"Model '{model}' is not a known OpenAI model. "
                f"Supported models: {supported}"
            )
        # For Ollama, allow any model (user might have custom models)
        # Just return without error - caller can log a warning if needed


def get_supported_models(provider: str) -> Optional[List[str]]:
    """
    Get list of supported models for a provider.
    
    Args:
        provider: LLM provider name
        
    Returns:
        List of supported model names, or None if provider is unknown
    """
    return PROVIDER_MODELS.get(provider)
