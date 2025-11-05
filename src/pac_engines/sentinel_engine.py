# ============================================================================
# src/pac_engines/sentinel_engine.py
# ============================================================================
import json
import logging
import subprocess
import tempfile
from pathlib import Path
from typing import Any, Dict, List

from src.datasets.models import PolicyViolation

from .base_engine import BasePaCEngine

logger = logging.getLogger(__name__)


class SentinelEngine(BasePaCEngine):
    """
    HashiCorp Sentinel engine implementation.

    Executes Sentinel policies against Terraform plans.
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize Sentinel engine.

        Args:
            config: Configuration dictionary with 'binary_path' and 'timeout'
        """
        super().__init__(config)
        self._verify_installation()

    def _verify_installation(self) -> None:
        """Verify that Sentinel is installed and accessible."""
        try:
            result = subprocess.run(
                [self.binary_path, "version"], capture_output=True, text=True, timeout=5
            )
            if result.returncode == 0:
                logger.info(f"Sentinel found: {result.stdout.strip()}")
            else:
                logger.warning(f"Sentinel verification failed: {result.stderr}")
        except FileNotFoundError:
            logger.error(f"Sentinel binary not found at {self.binary_path}")
            raise
        except Exception as e:
            logger.error(f"Error verifying Sentinel installation: {e}")
            raise

    def evaluate(self, policy: str, iac_script: str) -> List[PolicyViolation]:
        """
        Evaluate IaC script against Sentinel policy.

        Args:
            policy: Sentinel policy content
            iac_script: Terraform script content

        Returns:
            List of PolicyViolation objects
        """
        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_path = Path(tmp_dir)

            # Write policy file
            policy_file = tmp_path / "policy.sentinel"
            policy_file.write_text(policy)

            # Generate Terraform plan (simplified)
            plan_file = tmp_path / "plan.json"
            plan_data = self._generate_plan(iac_script)
            plan_file.write_text(json.dumps(plan_data))

            # Execute Sentinel apply
            try:
                result = subprocess.run(
                    [self.binary_path, "apply", "-json", str(policy_file)],
                    capture_output=True,
                    text=True,
                    timeout=self.timeout,
                    cwd=str(tmp_path),
                )

                if result.returncode == 0:
                    # Policy passed
                    return []
                else:
                    # Parse failures
                    output = json.loads(result.stdout) if result.stdout else {}
                    return self._parse_violations(output)

            except subprocess.TimeoutExpired:
                logger.error(f"Sentinel evaluation timed out after {self.timeout}s")
                return []
            except Exception as e:
                logger.error(f"Error during Sentinel evaluation: {e}")
                return []

    def validate(self, policy: str, iac_script: str) -> bool:
        """
        Validate if IaC script complies with policy.

        Args:
            policy: Sentinel policy content
            iac_script: Terraform script content

        Returns:
            True if no violations found, False otherwise
        """
        violations = self.evaluate(policy, iac_script)
        return len(violations) == 0

    def _generate_plan(self, iac_script: str) -> Dict[str, Any]:
        """
        Generate Terraform plan representation.

        Args:
            iac_script: Terraform script content

        Returns:
            Plan data structure
        """
        # Simplified plan generation
        # In production, run `terraform plan -out=plan.tfplan` and convert to JSON
        return {
            "terraform_version": "1.5.0",
            "resource_changes": self._extract_resource_changes(iac_script),
        }

    def _extract_resource_changes(self, iac_script: str) -> List[Dict[str, Any]]:
        """Extract resource changes from IaC script."""
        resources = []
        lines = iac_script.split("\n")

        for line in lines:
            if line.strip().startswith("resource "):
                parts = line.split('"')
                if len(parts) >= 3:
                    resources.append(
                        {
                            "type": parts[1],
                            "name": parts[3] if len(parts) >= 4 else "unknown",
                        }
                    )

        return resources

    def _parse_violations(
        self, sentinel_output: Dict[str, Any]
    ) -> List[PolicyViolation]:
        """
        Parse Sentinel output into violation list.

        Args:
            sentinel_output: Raw Sentinel JSON output

        Returns:
            List of PolicyViolation objects
        """
        violations = []

        if "result" in sentinel_output and not sentinel_output["result"]:
            # Policy failed
            trace = sentinel_output.get("trace", [])
            for entry in trace:
                if entry.get("type") == "error":
                    violations.append(
                        PolicyViolation(
                            message=entry.get("message", "Policy violation"),
                            severity="error",
                            details=entry,
                        )
                    )

        return (
            violations
            if violations
            else [PolicyViolation(message="Sentinel policy failed", severity="error")]
        )
