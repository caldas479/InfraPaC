# ============================================================================
# src/chains/prompt_builder.py
# ============================================================================

import logging
from typing import Any, Dict, List

from langchain_core.prompts import ChatPromptTemplate

from src.models import PolicyViolation

logger = logging.getLogger(__name__)


class PromptBuilder:
    """
    Builds structured prompts for LLM-based IaC repair.
    """

    def build_repair_prompt_template(self) -> ChatPromptTemplate:
        """
        Build a repair prompt template with variables for the LLM.

        Returns:
            ChatPromptTemplate with variables: policy, violations_text, iac_script, iteration, previous_attempt
        """
        system_content = """You are an expert Infrastructure as Code (IaC) engineer specializing in Terraform and policy compliance. Your task is to repair Terraform scripts to comply with given policies.

## Policy
The following policy must be satisfied:
{policy}

## Violations Detected
{violations_text}

## Current Terraform Script
```terraform
{iac_script}
```

Instructions
Please provide a corrected version of the Terraform script that resolves ALL violations while maintaining the intended infrastructure functionality.

Requirements:

Fix all reported violations
Preserve the original infrastructure intent
Use Terraform best practices
Return ONLY the corrected Terraform code
Do not include explanations or markdown formatting
"""

        prompt = ChatPromptTemplate.from_messages(
            [("system", system_content), ("human", "Repair this Terraform script.")]
        )

        return prompt

    @staticmethod
    def format_violations(violations: List[PolicyViolation]) -> str:
        """
        Format violations list into a string.

        Args:
            violations: List of PolicyViolation objects

        Returns:
            Formatted violations text
        """
        if not violations:
            return "No violations detected."

        violations_text = f"The current script has {len(violations)} violation(s):\n"
        for idx, violation in enumerate(violations, 1):
            msg = violation.message
            severity = violation.severity
            violations_text += f"{idx}. [{severity.upper()}] {msg}"
            if violation.resource:
                violations_text += f"\n   Resource: {violation.resource}"
            if violation.line:
                violations_text += f"\n   Line: {violation.line}"
            violations_text += "\n"

        return violations_text

    # TODO: implement evolve_prompt(prompt, reflection)
