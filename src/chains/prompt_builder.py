# ============================================================================
# src/chains/prompt_builder.py
# ============================================================================

import logging
from typing import Any, Dict, List

logger = logging.getLogger(__name__)


class PromptBuilder:
    """
    Builds structured prompts for LLM-based IaC repair.
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize prompt builder.

        Args:
            config: Configuration dictionary
        """
        self.config = config

    def build_repair_prompt(
        self,
        policy: str,
        iac_script: str,
        violations: List[Dict[str, Any]],
        iteration: int = 1,
        previous_attempt: str = None,
    ) -> str:
        """
        Build a repair prompt for the LLM.

        Args:
            policy: Policy code (Rego/Sentinel)
            iac_script: Current IaC script
            violations: List of violations
            iteration: Current iteration number
            previous_attempt: Previous repair attempt (if any)

        Returns:
            Formatted prompt string
        """
        prompt_parts = []

        # System context
        prompt_parts.append(
            "You are an expert Infrastructure as Code (IaC) engineer specializing in "
            "Terraform and policy compliance. Your task is to repair Terraform scripts "
            "to comply with given policies."
        )
        prompt_parts.append("")

        # Policy section
        prompt_parts.append("## Policy")
        prompt_parts.append("The following policy must be satisfied:")
        prompt_parts.append("```")
        prompt_parts.append(policy.strip())
        prompt_parts.append("```")
        prompt_parts.append("")

        # Violations section
        prompt_parts.append("## Violations Detected")
        prompt_parts.append(f"The current script has {len(violations)} violation(s):")
        for idx, violation in enumerate(violations, 1):
            msg = violation.get("message", "Unknown violation")
            severity = violation.get("severity", "error")
            prompt_parts.append(f"{idx}. [{severity.upper()}] {msg}")
            if "resource" in violation:
                prompt_parts.append(f"   Resource: {violation['resource']}")
            if "line" in violation and violation["line"]:
                prompt_parts.append(f"   Line: {violation['line']}")
        prompt_parts.append("")

        # Current script
        prompt_parts.append("## Current Terraform Script")
        if previous_attempt:
            prompt_parts.append(f"(Iteration {iteration} - Previous repair attempt)")
        prompt_parts.append("```terraform")
        prompt_parts.append(iac_script.strip())
        prompt_parts.append("```")
        prompt_parts.append("")

        # Instructions
        prompt_parts.append("## Instructions")
        prompt_parts.append(
            "Please provide a corrected version of the Terraform script that resolves "
            "ALL violations while maintaining the intended infrastructure functionality."
        )
        prompt_parts.append("")
        prompt_parts.append("Requirements:")
        prompt_parts.append("1. Fix all reported violations")
        prompt_parts.append("2. Preserve the original infrastructure intent")
        prompt_parts.append("3. Use Terraform best practices")
        prompt_parts.append("4. Return ONLY the corrected Terraform code")
        prompt_parts.append("5. Do not include explanations or markdown formatting")
        prompt_parts.append("")

        if previous_attempt:
            prompt_parts.append(
                "Note: The previous repair attempt still had violations. "
                "Please ensure this version addresses all issues."
            )
            prompt_parts.append("")

        return "\n".join(prompt_parts)

    def build_validation_prompt(
        self,
        policy: str,
        original_script: str,
        repaired_script: str,
    ) -> str:
        """
        Build a prompt to validate repair quality.

        Args:
            policy: Policy code
            original_script: Original IaC script
            repaired_script: Repaired IaC script

        Returns:
            Validation prompt
        """
        return f"""
Compare the original and repaired Terraform scripts to ensure:
1. The repaired version addresses policy violations
2. Original functionality is preserved
3. No new issues were introduced

Original Script:
```terraform
{original_script}
```

Repaired Script:
```terraform
{repaired_script}
```

Policy:
```
{policy}
```

Please confirm if the repair is valid (YES/NO) and explain why.
"""
