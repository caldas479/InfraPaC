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

    def build_repair_prompt_template(
        self, style: str = "default"
    ) -> ChatPromptTemplate:
        """
        Build a repair prompt template with variables for the LLM.

        Args:
            style: Prompt style — "default", "minimal", or "costar"

        Returns:
            ChatPromptTemplate with variables: policy, violations_text, iac_script
        """
        if style == "minimal_no_policy":
            system_content = """Violations:
{violations_text}

Terraform script:
{iac_script}

Return the fixed Terraform script in the repaired_script field. No explanations."""

        elif style == "minimal":
            system_content = """Policy:
{policy}

Violations:
{violations_text}

Terraform script:
{iac_script}

Return the fixed Terraform script in the repaired_script field. No explanations."""

        elif style == "costar":
            system_content = """# Context
You are a senior Infrastructure as Code security engineer. A Terraform script has failed an automated policy compliance check.

# Objective
Repair the Terraform script so it resolves ALL listed violations while preserving the original infrastructure intent.

# Style
Minimal and precise — only change what is necessary to fix the violations.

# Tone
Technical and direct.

# Audience
An automated validation system. No explanations or comments are needed.

# Response
Return ONLY valid Terraform HCL in the repaired_script field.
- No markdown code fences
- No inline comments
- Proper newlines and indentation

## Policy
{policy}

## Violations
{violations_text}

## Current Terraform Script
{iac_script}"""

        else:  # default
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
Provide the corrected Terraform script in the `repaired_script` field. The script should resolve ALL violations while maintaining the intended infrastructure functionality.

Requirements:

Fix all reported violations
Preserve the original infrastructure intent
Use Terraform best practices
Provide ONLY valid Terraform code in the repaired_script field
DO NOT include markdown code fences (```terraform) or explanations
IMPORTANT: Use proper Terraform formatting with newlines (\\n) between lines - do not return code as a single line
Maintain proper indentation and structure as standard Terraform files
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
