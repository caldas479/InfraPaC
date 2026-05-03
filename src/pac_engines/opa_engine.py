# ============================================================================
# src/pac_engines/opa_engine.py
# ============================================================================

import json
import logging
import re
import subprocess
import tempfile
from pathlib import Path
from typing import Any, Dict, List

from src.models import PolicyViolation
from src.pac_engines.base_engine import BasePaCEngine

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
                opa_query = self._build_query(policy)
                cmd = [
                    self.binary_path,
                    "eval",
                    "-d",
                    str(policy_file),
                    "-i",
                    str(input_file),
                    "--format",
                    "json",
                    opa_query,
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

    def _build_query(self, policy: str) -> str:
        """
        Derive the OPA query string from the policy's package declaration.

        Looks for ``package <name>`` and returns ``data.<name>.deny``.
        Falls back to ``data.terraform.deny`` for backward compatibility.

        Args:
            policy: Rego policy source text

        Returns:
            OPA query string (e.g. ``data.kubernetes.deny``)
        """
        match = re.search(r"^\s*package\s+([\w.]+)", policy, re.MULTILINE)
        if match:
            package_name = match.group(1)
            query = f"data.{package_name}.deny"
            logger.debug(f"Derived OPA query from package: {query}")
            return query
        logger.debug("No package declaration found; using default data.terraform.deny")
        return "data.terraform.deny"

    # Signatures that unambiguously identify an IaC format before parsing.
    # Patterns are checked against the first non-blank line of the script.
    _HCL_PATTERN = re.compile(
        r"""
        ^\s*(?:
            resource   |  # resource "aws_s3_bucket" "name" {
            variable   |  # variable "foo" {
            output     |  # output "bar" {
            locals     |  # locals {
            module     |  # module "name" {
            provider   |  # provider "aws" {
            terraform  |  # terraform {
            data          # data "source" "name" {
        )\s+["{\w]
        """,
        re.VERBOSE | re.MULTILINE,
    )
    _JSON_PATTERN = re.compile(r"^\s*[{\[]", re.MULTILINE)
    _YAML_PATTERN = re.compile(
        r"""
        ^\s*(?:
            ---\s*$           |  # YAML document separator
            \w[\w\s]*:\s       |  # key: value  (covers apiVersion, kind, …)
            -\s+\w               # list item
        )
        """,
        re.VERBOSE | re.MULTILINE,
    )

    def _detect_format(self, iac_script: str) -> str:
        """
        Detect the serialisation format of an IaC script from its content.

        Checks syntactic signatures in order of specificity:

        1. **HCL** — recognises top-level Terraform block keywords
           (``resource``, ``variable``, ``output``, ``locals``, ``module``,
           ``provider``, ``terraform``, ``data``).
        2. **JSON** — script starts with ``{`` or ``[``.
        3. **YAML** — contains a YAML document separator (``---``) or a
           ``key: value`` pair typical of Kubernetes / CloudFormation manifests.

        Args:
            iac_script: Raw IaC script content.

        Returns:
            One of ``"hcl"``, ``"json"``, ``"yaml"``, or ``"unknown"``.
        """
        if self._HCL_PATTERN.search(iac_script):
            return "hcl"
        if self._JSON_PATTERN.match(iac_script.lstrip()):
            return "json"
        if self._YAML_PATTERN.search(iac_script):
            return "yaml"
        return "unknown"

    def _prepare_input(self, iac_script: str) -> Dict[str, Any]:
        """
        Prepare IaC script as JSON input for OPA.

        Detects the script format once via :meth:`_detect_format`, then
        routes directly to the appropriate parser — no trial-and-error.

        Supported formats:

        * **HCL** (Terraform) — parsed with ``python-hcl2`` and transformed
          into the nested ``resource`` structure OPA policies expect.
        * **JSON** (Pulumi stack exports, CloudFormation JSON) — parsed
          with the stdlib ``json`` module.
        * **YAML** (Kubernetes manifests, CloudFormation YAML) — parsed
          with ``PyYAML``.
        * **unknown** — wrapped as ``{"iac_script": <raw text>}`` so a
          policy can still operate on the raw string if needed.

        Args:
            iac_script: Raw IaC script content.

        Returns:
            Dictionary representation for OPA evaluation.
        """
        fmt = self._detect_format(iac_script)
        logger.debug(f"Detected IaC format: {fmt}")

        if fmt == "hcl":
            return self._parse_hcl(iac_script)
        if fmt == "json":
            return self._parse_json(iac_script)
        if fmt == "yaml":
            return self._parse_yaml(iac_script)

        logger.warning(
            "Could not detect IaC script format. " "Falling back to raw string input."
        )
        return {"iac_script": iac_script}

    def _parse_hcl(self, iac_script: str) -> Dict[str, Any]:
        """Parse an HCL (Terraform) script into an OPA-ready dict."""
        import hcl2

        def _convert_tuples(obj):
            if isinstance(obj, tuple):
                return list(obj)
            elif isinstance(obj, dict):
                return {k: _convert_tuples(v) for k, v in obj.items()}
            elif isinstance(obj, list):
                return [_convert_tuples(i) for i in obj]
            return obj

        def _transform_resources(data):
            result = {"resource": {}}
            if "resource" in data and isinstance(data["resource"], list):
                for resource_block in data["resource"]:
                    for resource_type, instances in resource_block.items():
                        if resource_type not in result["resource"]:
                            result["resource"][resource_type] = {}
                        for name, config in instances.items():
                            transformed_config = {}
                            for key, value in config.items():
                                if (
                                    isinstance(value, list)
                                    and len(value) == 1
                                    and isinstance(value[0], dict)
                                ):
                                    transformed_config[key] = value[0]
                                else:
                                    transformed_config[key] = value
                            result["resource"][resource_type][name] = transformed_config
            return result

        parsed = hcl2.loads(iac_script)
        result = _transform_resources(_convert_tuples(parsed))
        logger.debug(f"Prepared OPA input (HCL): {json.dumps(result, indent=2)}")
        return result

    def _parse_json(self, iac_script: str) -> Dict[str, Any]:
        """Parse a JSON IaC script (e.g. Pulumi stack export) into a dict."""
        result = json.loads(iac_script)
        logger.debug("Parsed IaC script as JSON.")
        return result

    def _parse_yaml(self, iac_script: str) -> Dict[str, Any]:
        """Parse a YAML IaC script (e.g. Kubernetes manifest) into a dict."""
        import yaml

        result = yaml.safe_load(iac_script)
        logger.debug("Parsed IaC script as YAML.")
        return result

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
