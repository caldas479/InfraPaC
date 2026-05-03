# ============================================================================

import logging
import os
from typing import Any, Dict, List

from langchain_ollama import ChatOllama
from langchain_openai import ChatOpenAI

from src.chains.prompt_builder import PromptBuilder
from src.models import PolicyViolation, RepairOutput

logger = logging.getLogger(__name__)


class RepairChain:
    """
    LangChain-based repair chain for IaC scripts.
    """

    def __init__(self, llm_config: Dict[str, Any]) -> None:
        """
        Initialize repair chain.

        Args:
            llm_config: LLM configuration dictionary
        """
        self.llm_config = llm_config
        self.prompt_builder = PromptBuilder()
        self.llm = self._initialize_llm()
        prompt_style = llm_config.get("prompt_style", "default")
        iac_language = llm_config.get("iac_language", "IaC")
        self.prompt_template = self.prompt_builder.build_repair_prompt_template(
            style=prompt_style, iac_language=iac_language
        )

    def _initialize_llm(self) -> Any:
        """Initialize the LLM based on configuration with structured output."""
        provider = self.llm_config.get("provider", "ollama")

        if provider == "ollama":
            llm = ChatOllama(
                model=self.llm_config.get("model", "codellama"),
                temperature=self.llm_config.get("temperature", 0.2),
                num_ctx=self.llm_config.get("max_tokens", 2048),
                base_url=self.llm_config.get("base_url", "http://localhost:11434"),
            )
        elif provider == "openai":
            llm = ChatOpenAI(
                model=self.llm_config.get("model", "gpt-4"),
                temperature=self.llm_config.get("temperature", 0.2),
                max_tokens=self.llm_config.get("max_tokens", 2048),
                timeout=self.llm_config.get("timeout", 60),
            )
        elif provider == "openrouter":
            api_key = self.llm_config.get("api_key") or os.environ.get(
                "OPENROUTER_API_KEY", ""
            )
            llm = ChatOpenAI(
                model=self.llm_config.get("model", "meta-llama/llama-3.3-70b-instruct"),
                temperature=self.llm_config.get("temperature", 0.2),
                max_tokens=self.llm_config.get("max_tokens", 2048),
                timeout=self.llm_config.get("timeout", 120),
                openai_api_base="https://openrouter.ai/api/v1",
                openai_api_key=api_key,
            )
        # Add other providers (HuggingFace, Anthropic) as needed
        else:
            raise ValueError(f"Unsupported LLM provider: {provider}")

        # Wrap LLM with structured output
        try:
            return llm.with_structured_output(RepairOutput)
        except Exception as e:
            raise ValueError(
                f"Provider '{provider}' does not support structured output. "
                f"Error: {e}. Please use a provider that supports structured output."
            )

    def repair(
        self, policy: str, iac_script: str, violations: List[PolicyViolation]
    ) -> str:
        """
        Generate a repaired IaC script using structured output.

        Args:
            policy: Policy code (Rego)
            iac_script: Current IaC script
            violations: List of PolicyViolation objects

        Returns:
            Repaired IaC script

        Raises:
            ValueError: If structured output parsing fails
        """
        # Format violations
        violations_text = self.prompt_builder.format_violations(violations)

        # Create the repair chain with the template and invoke with variables
        repair_chain = self.prompt_template | self.llm

        # Invoke the chain with the actual values - returns RepairOutput
        try:
            response: RepairOutput = repair_chain.invoke(
                {
                    "policy": policy.strip(),
                    "violations_text": violations_text,
                    "iac_script": iac_script.strip(),
                }
            )

            # Log the structured response
            logger.debug(f"Structured response: {response}")

            # Access the repaired script directly from structured output
            return response.repaired_script

        except Exception as e:
            provider = self.llm_config.get("provider", "unknown")
            logger.error(f"Structured output parsing failed: {e}")
            raise ValueError(
                f"Failed to parse structured output from provider '{provider}'. "
                f"Error: {e}"
            )
