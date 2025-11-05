# ============================================================================
# src/pac_engines/opa_engine.py
# ============================================================================

import json
import logging
import subprocess
import tempfile
from pathlib import Path
from typing import Any, Dict, List

from src.models import PolicyViolation

from .base_engine import BasePaCEngine

logger = logging.getLogger(__name__)


class OPAEngine(BasePaCEngine):
    """
    Open Policy Agent (OPA) engine implementation.

    Executes Rego policies against Terraform/IaC scripts.
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize OPA engine.

        Args:
            config: Configuration dictionary with 'binary_path' and 'timeout'
        """
        super().__init__(config)
        self._verify_installation()

    def _verify_installation(self) -> None:
        """Verify that OPA is installed and accessible."""
        try:
            result = subprocess.run(
                [self.binary_path, "version"], capture_output=True, text=True, timeout=5
            )
            if result.returncode == 0:
                logger.info(f"OPA found: {result.stdout.strip()}")
            else:
                logger.warning(f"OPA verification failed: {result.stderr}")
        except FileNotFoundError:
            logger.error(f"OPA binary not found at {self.binary_path}")
            raise
        except Exception as e:
            logger.error(f"Error verifying OPA installation: {e}")
            raise

    def evaluate(self, policy: str, iac_script: str) -> List[PolicyViolation]:
        """
        Evaluate IaC script against Rego policy.

        Args:
            policy: Rego policy content
            iac_script: Terraform/IaC script content

        Returns:
            List of PolicyViolation objects
        """
        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_path = Path(tmp_dir)

            # Write policy file
            policy_file = tmp_path / "policy.rego"
            policy_file.write_text(policy)

            # Write IaC input file
            input_file = tmp_path / "input.json"
            # Convert Terraform to JSON representation
            input_data = self._prepare_input(iac_script)
            input_file.write_text(json.dumps(input_data))

            # Execute OPA eval
            try:
                logger.debug(f"OPA input data: {input_file.read_text()}")
                cmd = [
                    self.binary_path,
                    "eval",
                    "-d",
                    str(policy_file),
                    "-i",
                    str(input_file),
                    "--format",
                    "json",
                    "data.terraform.deny",
                ]
                logger.debug(f"OPA command: {' '.join(cmd)}")

                result = subprocess.run(
                    cmd, capture_output=True, text=True, timeout=self.timeout
                )
                if result.returncode != 0:
                    logger.error(f"OPA evaluation failed: {result.stderr}")
                    return []

                logger.debug(f"OPA stdout: {result.stdout}")
                output = json.loads(result.stdout)
                return self._parse_violations(output)

            except subprocess.TimeoutExpired:
                logger.error(f"OPA evaluation timed out after {self.timeout}s")
                return []
            except Exception as e:
                logger.error(f"Error during OPA evaluation: {e}")
                return []

    def validate(self, policy: str, iac_script: str) -> bool:
        """
        Validate if IaC script complies with policy.

        Args:
            policy: Rego policy content
            iac_script: Terraform/IaC script content

        Returns:
            True if no violations found, False otherwise
        """
        violations = self.evaluate(policy, iac_script)
        return len(violations) == 0

    def _prepare_input(self, iac_script: str) -> Dict[str, Any]:
        """
        Prepare IaC script as JSON input for OPA by parsing HCL.

        Args:
            iac_script: Raw Terraform/IaC script

        Returns:
            Dictionary representation for OPA evaluation
        """
        try:
            import hcl2

            # Parse HCL to Python dict
            parsed = hcl2.loads(iac_script)

            # Convert any tuples to lists (hcl2 specific)
            def _convert_tuples(obj):
                if isinstance(obj, tuple):
                    return list(obj)
                elif isinstance(obj, dict):
                    return {k: _convert_tuples(v) for k, v in obj.items()}
                elif isinstance(obj, list):
                    return [_convert_tuples(i) for i in obj]
                return obj

            # Transform the structure to match OPA expectations
            def _transform_resources(data):
                result = {"resource": {}}
                if "resource" in data and isinstance(data["resource"], list):
                    for resource_block in data["resource"]:
                        for resource_type, instances in resource_block.items():
                            if resource_type not in result["resource"]:
                                result["resource"][resource_type] = {}
                            for name, config in instances.items():
                                # Transform block attributes to be objects instead of lists
                                transformed_config = {}
                                for key, value in config.items():
                                    if (
                                        isinstance(value, list)
                                        and len(value) == 1
                                        and isinstance(value[0], dict)
                                    ):
                                        # Convert block to object
                                        transformed_config[key] = value[0]
                                    else:
                                        transformed_config[key] = value
                                result["resource"][resource_type][
                                    name
                                ] = transformed_config
                return result

            parsed_data = _convert_tuples(parsed)
            result = _transform_resources(parsed_data)
            logger.debug(f"Prepared OPA input: {json.dumps(result, indent=2)}")
            return result

        except Exception as e:
            logger.error(f"Error parsing Terraform HCL: {e}")
            return {}

    def _parse_violations(self, opa_output: Dict[str, Any]) -> List[PolicyViolation]:
        """
        Parse OPA output into violation list.

        Args:
            opa_output: Raw OPA JSON output

        Returns:
            List of PolicyViolation objects
        """
        violations = []

        # Extract violations from OPA result
        if "result" in opa_output:
            results = opa_output["result"]
            if isinstance(results, list) and results:
                for result in results:
                    if "expressions" in result:
                        for expr in result["expressions"]:
                            if "value" in expr and expr["value"]:
                                # Handle different violation formats
                                value = expr["value"]
                                if isinstance(value, list):
                                    for v in value:
                                        violations.append(self._format_violation(v))
                                else:
                                    violations.append(self._format_violation(value))

        return violations

    def _format_violation(self, violation_data: Any) -> PolicyViolation:
        """Format a single violation into PolicyViolation object."""
        if isinstance(violation_data, str):
            return PolicyViolation(message=violation_data, severity="error")
        elif isinstance(violation_data, dict):
            return PolicyViolation(
                message=violation_data.get(
                    "msg", violation_data.get("message", "Unknown violation")
                ),
                severity=violation_data.get("severity", "error"),
                line=violation_data.get("line"),
                resource=violation_data.get("resource"),
                details=violation_data,
            )
        else:
            return PolicyViolation(message=str(violation_data), severity="error")
