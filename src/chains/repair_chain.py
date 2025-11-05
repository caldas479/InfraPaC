# ============================================================================

import logging
from typing import Any, Dict, List, Optional

from langchain_ollama import ChatOllama
from langchain_openai import ChatOpenAI

from src.models import PolicyViolation
from .prompt_builder import PromptBuilder


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
        self.prompt_builder = PromptBuilder(llm_config)
        self.llm = self._initialize_llm()

    def _initialize_llm(self) -> Any:
        """Initialize the LLM based on configuration."""
        provider = self.llm_config.get("provider", "ollama")

        if provider == "ollama":
            return ChatOllama(
                model=self.llm_config.get("model", "codellama"),
                temperature=self.llm_config.get("temperature", 0.2),
                num_ctx=self.llm_config.get("max_tokens", 2048),
                base_url=self.llm_config.get("base_url", "http://localhost:11434"),
            )
        elif provider == "openai":
            return ChatOpenAI(
                model=self.llm_config.get("model", "gpt-4"),
                temperature=self.llm_config.get("temperature", 0.2),
                max_tokens=self.llm_config.get("max_tokens", 2048),
                timeout=self.llm_config.get("timeout", 60),
            )
        # Add other providers (HuggingFace, Anthropic) as needed
        else:
            raise ValueError(f"Unsupported LLM provider: {provider}")

    def repair(
        self,
        policy: str,
        iac_script: str,
        violations: List[PolicyViolation],
        iteration: int = 1,
        previous_attempt: Optional[str] = None,
    ) -> str:
        """
        Generate a repaired IaC script.

        Args:
            policy: Policy code
            iac_script: Current IaC script
            violations: List of PolicyViolation objects
            iteration: Current iteration number
            previous_attempt: Previous repair attempt

        Returns:
            Repaired IaC script
        """
        # Build prompt
        prompt = self.prompt_builder.build_repair_prompt(
            policy=policy,
            iac_script=iac_script,
            violations=violations,
            iteration=iteration,
            previous_attempt=previous_attempt,
        )

        # Log the prompt for debugging
        logger = logging.getLogger(__name__)
        logger.debug(f"Prompt:\n{prompt}")

        # Create chain and execute
        response = self.llm.invoke(prompt)

        # Log raw response
        response_text = (
            response.content if hasattr(response, "content") else str(response)
        )
        logger.debug(f"Raw response:\n{response_text}")

        # Extract Terraform code from response
        repaired_script = self._extract_code(response)

        return repaired_script

    def _extract_code(self, response: Any) -> str:
        """
        Extract Terraform code from LLM response.

        Args:
            response: LLM response (can be string or AIMessage)

        Returns:
            Extracted Terraform code
        """
        # Handle AIMessage from ChatOllama
        if hasattr(response, "content"):
            response_text = response.content
        else:
            response_text = str(response)

        # If the response has ```terraform or ```hcl markers, extract content between them
        if "```terraform" in response_text or "```hcl" in response_text:
            start_marker = response_text.find("```")
            if start_marker == -1:
                return response_text.strip()

            # Skip the opening ``` and any language identifier
            start = response_text.find("\n", start_marker) + 1
            if start == 0:  # No newline found
                return response_text[start_marker + 3 :].strip()

            # Find the closing ```
            end = response_text.find("```", start)
            if end == -1:
                return response_text[start:].strip()

            return response_text[start:end].strip()

        # Otherwise return the raw response (assume it's just the code)
        return response_text.strip()
