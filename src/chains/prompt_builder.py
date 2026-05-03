# ============================================================================
# src/chains/prompt_builder.py
# ============================================================================

import logging
from typing import List

from langchain_core.prompts import ChatPromptTemplate

from src.models import PolicyViolation

logger = logging.getLogger(__name__)


class PromptBuilder:
    """
    Builds structured prompts for LLM-based IaC repair.

    Supports multiple prompt styles (default, minimal, minimal_no_policy, costar)
    and accepts an iac_language parameter so generated prompts name the specific
    language being repaired (Terraform, CloudFormation, Kubernetes, etc.).
    """

    def build_repair_prompt_template(
        self, style: str = "default", iac_language: str = "IaC"
    ) -> ChatPromptTemplate:
        """
        Build a repair prompt template with variables for the LLM.

        Args:
            style: Prompt style. One of "default", "minimal", "minimal_no_policy",
                   or "costar". Defaults to "default".
            iac_language: Human-readable IaC language name shown in prompts,
                          such as Terraform, CloudFormation, or Kubernetes.
                          Defaults to the generic label "IaC".

        Returns:
            ChatPromptTemplate with input variables: policy, violations_text,
            and iac_script.
        """
        lang = iac_language  # shorthand

        if style == "minimal_no_policy":
            system_content = f"""Violations:
{{violations_text}}

{lang} script:
{{iac_script}}

Return the fixed {lang} script in the repaired_script field. No explanations."""

        elif style == "minimal":
            system_content = f"""Policy:
{{policy}}

Violations:
{{violations_text}}

{lang} script:
{{iac_script}}

Return the fixed {lang} script in the repaired_script field. No explanations."""

        elif style == "costar":
            system_content = f"""# Context
You are a senior Infrastructure as Code security engineer. A {lang} script has failed an automated policy compliance check.

# Objective
Repair the {lang} script so it resolves ALL listed violations while preserving the original infrastructure intent.

# Style
Minimal and precise — only change what is necessary to fix the violations.

# Tone
Technical and direct.

# Audience
An automated validation system. No explanations or comments are needed.

# Response
Return ONLY valid {lang} code in the repaired_script field.
- No markdown code fences
- No inline comments
- Proper newlines and indentation

## Policy
{{policy}}

## Violations
{{violations_text}}

## Current {lang} Script
{{iac_script}}"""

        else:  # default
            system_content = f"""You are an expert Infrastructure as Code (IaC) engineer specializing in {lang} and policy compliance. Your task is to repair {lang} scripts to comply with given policies.

## Policy
The following policy must be satisfied:
{{policy}}

## Violations Detected
{{violations_text}}

## Current {lang} Script
```
{{iac_script}}
```

Instructions
Provide the corrected {lang} script in the `repaired_script` field. The script should resolve ALL violations while maintaining the intended infrastructure functionality.

Requirements:

Fix all reported violations
Preserve the original infrastructure intent
Use {lang} best practices
Provide ONLY valid {lang} code in the repaired_script field
DO NOT include markdown code fences or explanations
IMPORTANT: Use proper formatting with newlines (\\n) between lines - do not return code as a single line
Maintain proper indentation and structure
"""

        prompt = ChatPromptTemplate.from_messages(
            [("system", system_content), ("human", f"Repair this {lang} script.")]
        )

        return prompt

    @staticmethod
    def format_violations(violations: List[PolicyViolation]) -> str:
        """
        Format a violations list into a human-readable string for prompt injection.

        Args:
            violations: List of PolicyViolation objects to format.

        Returns:
            A numbered, multi-line string describing each violation, including
            severity, resource, and line number where available. Returns
            "No violations detected." when the list is empty.
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
