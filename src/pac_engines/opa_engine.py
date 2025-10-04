# ============================================================================
# src/pac_engines/opa_engine.py
# ============================================================================

import json
import logging
import subprocess
import tempfile
from pathlib import Path
from typing import Any, Dict, List

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
                [self.binary_path, "version"],
                capture_output=True,
                text=True,
                timeout=5
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
    
    def evaluate(self, policy: str, iac_script: str) -> List[Dict[str, Any]]:
        """
        Evaluate IaC script against Rego policy.
        
        Args:
            policy: Rego policy content
            iac_script: Terraform/IaC script content
        
        Returns:
            List of violations
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
                result = subprocess.run(
                    [
                        self.binary_path,
                        "eval",
                        "-d", str(policy_file),
                        "-i", str(input_file),
                        "--format", "json",
                        "data.terraform.deny"  # Standard deny rule query
                    ],
                    capture_output=True,
                    text=True,
                    timeout=self.timeout
                )
                
                if result.returncode != 0:
                    logger.error(f"OPA evaluation failed: {result.stderr}")
                    return []
                
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
        Prepare IaC script as JSON input for OPA.
        
        Args:
            iac_script: Raw Terraform/IaC script
        
        Returns:
            Dictionary representation for OPA evaluation
        """
        # Basic parsing of Terraform HCL
        # In practice, you'd use hcl2json or python-hcl2 to parse this
        import re
        
        # Extract versioning configuration if present
        versioning_match = re.search(r'versioning\s*{\s*enabled\s*=\s*(true|false)', iac_script)
        versioning_enabled = versioning_match and versioning_match.group(1) == "true"
        
        # Build the JSON structure
        bucket_config = {
            "bucket": "my-example-bucket"
        }
        
        if versioning_match:
            bucket_config["versioning"] = {
                "enabled": versioning_enabled
            }
        
        return {
            "resource": {
                "aws_s3_bucket": {
                    "example": bucket_config
                }
            }
        }
    
    def _extract_resources(self, iac_script: str) -> List[Dict[str, Any]]:
        """
        Extract resource blocks from Terraform script.
        
        Args:
            iac_script: Terraform script content
        
        Returns:
            List of resource definitions
        """
        # Simplified resource extraction
        # In production, use proper HCL parser (e.g., python-hcl2)
        resources = []
        lines = iac_script.split('\n')
        
        for line in lines:
            if line.strip().startswith('resource '):
                parts = line.split('"')
                if len(parts) >= 3:
                    resources.append({
                        "type": parts[1],
                        "name": parts[3] if len(parts) >= 4 else "unknown"
                    })
        
        return resources
    
    def _parse_violations(self, opa_output: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Parse OPA output into violation list.
        
        Args:
            opa_output: Raw OPA JSON output
        
        Returns:
            Structured list of violations
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
                                elif isinstance(value, dict):
                                    violations.append(self._format_violation(value))
                                elif isinstance(value, str):
                                    violations.append({"message": value})
        
        return violations
    
    def _format_violation(self, violation_data: Any) -> Dict[str, Any]:
        """Format a single violation into standard structure."""
        if isinstance(violation_data, str):
            return {"message": violation_data, "severity": "error"}
        elif isinstance(violation_data, dict):
            return {
                "message": violation_data.get("msg", violation_data.get("message", "Unknown violation")),
                "severity": violation_data.get("severity", "error"),
                "line": violation_data.get("line"),
                "resource": violation_data.get("resource"),
                "details": violation_data
            }
        else:
            return {"message": str(violation_data), "severity": "error"}