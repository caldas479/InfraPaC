# ============================================================================
# src/pac_engines/kics_engine.py
# ============================================================================

import json
import logging
import subprocess
import tempfile
from pathlib import Path
from typing import Any, Dict, List

from src.models import PolicyViolation
from src.pac_engines.base_engine import BasePaCEngine

logger = logging.getLogger(__name__)


class KICSEngine(BasePaCEngine):
    """
    KICS (Keeping Infrastructure as Code Secure) engine implementation.

    Executes KICS queries against Terraform/IaC scripts using custom query paths
    and automatically locates KICS helper libraries for policy evaluation.

    KICS is an open-source security scanner for Infrastructure as Code that
    supports multiple platforms including Terraform, CloudFormation, Kubernetes,
    Docker, and more. This engine integrates KICS into the InfraPaC repair
    framework to detect and fix security violations in Terraform configurations.

    The engine:
    - Creates temporary directories for queries, IaC files, and results
    - Generates required metadata.json for KICS query recognition
    - Automatically finds KICS libraries from multiple common paths
    - Executes KICS scan with proper exit code handling
    - Parses JSON output into PolicyViolation objects

    Example:
        >>> config = {"binary_path": "kics", "timeout": 60}
        >>> engine = KICSEngine(config)
        >>> policy = Path("policy.rego").read_text()
        >>> iac = Path("main.tf").read_text()
        >>> violations = engine.evaluate(policy, iac)
        >>> is_compliant = engine.validate(policy, iac)

    Note:
        KICS must be installed and accessible via the binary_path specified
        in the configuration. Install with: brew install kics (macOS) or
        download from https://github.com/Checkmarx/kics
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize KICS engine.

        Args:
            config: Configuration dictionary with 'binary_path' and 'timeout'
        """
        super().__init__(config)
        self._verify_installation()

    def _verify_installation(self) -> None:
        """
        Verify that KICS is installed and accessible.

        Runs 'kics version' to check if the binary is available and executable.
        Logs the version information on success or raises an exception on failure.

        Raises:
            FileNotFoundError: If KICS binary is not found at the configured path
            Exception: If KICS verification fails for other reasons
        """
        try:
            result = subprocess.run(
                [self.binary_path, "version"],
                capture_output=True,
                text=True,
                timeout=5,
            )
            if result.returncode == 0:
                logger.info(f"KICS found: {result.stdout.strip()}")
            else:
                logger.warning(f"KICS verification failed: {result.stderr}")
        except FileNotFoundError:
            logger.error(f"KICS binary not found at {self.binary_path}")
            raise
        except Exception as e:
            logger.error(f"Error verifying KICS installation: {e}")
            raise

    def evaluate(self, policy: str, iac_script: str) -> List[PolicyViolation]:
        """
        Evaluate IaC script against KICS query.

        This method performs the following steps:
        1. Creates temporary directories for queries, IaC files, and results
        2. Writes the Rego policy to query.rego
        3. Generates metadata.json required by KICS for query recognition
        4. Writes the IaC script to main.tf
        5. Locates KICS helper libraries and includes them in the scan
        6. Executes KICS scan with JSON output format
        7. Parses the JSON results into PolicyViolation objects

        KICS uses exit codes to indicate findings:
        - 0: No issues found
        - 20: INFO severity violations
        - 30: LOW severity violations
        - 40: MEDIUM severity violations
        - 50: HIGH severity violations
        - 60: CRITICAL severity violations

        Args:
            policy: KICS query (Rego policy) content
            iac_script: Terraform/IaC script content

        Returns:
            List of PolicyViolation objects containing detailed information
            about each violation found. Returns empty list if scan fails or
            no violations are detected.

        Note:
            The method uses temporary directories that are automatically
            cleaned up after the scan completes.
        """
        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_path = Path(tmp_dir)

            # Create directories for KICS
            queries_dir = tmp_path / "queries"
            queries_dir.mkdir()
            iac_dir = tmp_path / "iac"
            iac_dir.mkdir()
            results_dir = tmp_path / "results"
            results_dir.mkdir()

            # Write query file
            query_file = queries_dir / "query.rego"
            query_file.write_text(policy)

            # Write metadata.json (required by KICS to recognize the query)
            metadata_file = queries_dir / "metadata.json"
            metadata = {
                "id": "custom-query",
                "queryName": "Custom Policy Query",
                "severity": "MEDIUM",
                "category": "Security",
                "descriptionText": "Custom policy evaluation",
                "platform": "Terraform",
                "descriptionID": "custom",
            }
            metadata_file.write_text(json.dumps(metadata, indent=2))

            # Write IaC file
            iac_file = iac_dir / "main.tf"
            iac_file.write_text(iac_script)

            # Prepare results file path
            results_file = results_dir / "results.json"

            # Execute KICS scan
            try:
                cmd = [
                    self.binary_path,
                    "scan",
                    "-p",
                    str(iac_dir),
                    "-q",
                    str(queries_dir),
                    "-o",
                    str(results_dir),
                    "--report-formats",
                    "json",
                    "--output-name",
                    "results",
                    "--no-progress",
                ]

                # Find KICS libraries path
                libraries_path = self._find_libraries_path()
                # Add libraries path if found
                if libraries_path:
                    cmd.extend(["-b", str(libraries_path)])
                    logger.debug(f"Using KICS libraries from {libraries_path}")

                logger.debug(f"KICS command: {' '.join(cmd)}")

                result = subprocess.run(
                    cmd, capture_output=True, text=True, timeout=self.timeout
                )

                # KICS returns non-zero exit code when it finds violations
                # Exit codes: 0 = no issues, 20-60 = violations by severity
                # 20=INFO, 30=LOW, 40=MEDIUM, 50=HIGH, 60=CRITICAL
                # Other codes are actual errors
                if result.returncode not in range(0, 70):
                    logger.error(f"KICS scan failed with exit code {result.returncode}")
                    logger.error(f"KICS stderr: {result.stderr}")
                    logger.error(f"KICS stdout: {result.stdout}")
                    return []

                logger.debug(f"KICS stdout: {result.stdout}")
                logger.debug(f"KICS stderr: {result.stderr}")

                # Read results from JSON file
                if results_file.exists():
                    with open(results_file, "r") as f:
                        output = json.load(f)
                    logger.debug(f"KICS output keys: {output.keys()}")
                    logger.debug(
                        f"KICS queries found: {output.get('queries_total', 0)}"
                    )
                    if "queries" in output:
                        logger.debug(
                            f"Number of query results: {len(output['queries'])}"
                        )
                    return self._parse_violations(output)
                else:
                    logger.warning(f"KICS results file not found: {results_file}")
                    return []

            except subprocess.TimeoutExpired:
                logger.error(f"KICS scan timed out after {self.timeout}s")
                return []
            except Exception as e:
                logger.error(f"Error during KICS scan: {e}")
                return []

    def _find_libraries_path(self) -> Path:
        """
        Find KICS libraries path from common locations.

        KICS queries often use helper functions from library files (common.rego,
        terraform.rego, etc.). This method searches for libraries in:
        1. data/external-repos/kics/assets/libraries (project-local KICS repo)
        2. /opt/homebrew/opt/kics/share/kics/assets/libraries (Homebrew install)
        3. /usr/local/share/kics/assets/libraries (Manual install)

        Returns:
            Path to KICS libraries directory, or None if not found. If None,
            queries using library functions may fail to execute properly.
        """
        potential_paths = [
            Path("data/external-repos/kics/assets/libraries"),
            Path("/opt/homebrew/opt/kics/share/kics/assets/libraries"),
            Path("/usr/local/share/kics/assets/libraries"),
        ]

        for lib_path in potential_paths:
            if lib_path.exists() and lib_path.is_dir():
                logger.debug(f"Found KICS libraries at {lib_path}")
                return lib_path

        logger.warning(
            "KICS libraries not found. Queries using helper functions may fail."
        )
        return None

    def validate(self, policy: str, iac_script: str) -> bool:
        """
        Validate if IaC script complies with policy.

        Args:
            policy: KICS query (Rego policy) content
            iac_script: Terraform/IaC script content

        Returns:
            True if no violations found, False otherwise
        """
        violations = self.evaluate(policy, iac_script)
        return len(violations) == 0

    def _parse_violations(self, kics_output: Dict[str, Any]) -> List[PolicyViolation]:
        """
        Parse KICS JSON output into violation list.

        KICS output format:
        {
            "queries": [...],
            "files_scanned": N,
            "files_parsed": N,
            "files_failed_to_scan": 0,
            "queries_total": N,
            "queries_failed_to_execute": 0,
            "queries_failed_to_compute_similarity_id": 0,
            "scan_id": "...",
            "severity_counters": {...},
            "total_counter": N,
            "total_bom_resources": 0,
            "start": "...",
            "end": "...",
            "paths": [...],
            "queries_results": [
                {
                    "query_name": "...",
                    "query_id": "...",
                    "severity": "HIGH|MEDIUM|LOW|INFO",
                    "platform": "Terraform",
                    "cloud_provider": "AWS",
                    "category": "...",
                    "description": "...",
                    "description_id": "...",
                    "files": [
                        {
                            "file_name": "main.tf",
                            "similarity_id": "...",
                            "line": 1,
                            "resource_type": "...",
                            "resource_name": "...",
                            "issue_type": "...",
                            "search_key": "...",
                            "search_line": 0,
                            "search_value": "...",
                            "expected_value": "...",
                            "actual_value": "..."
                        }
                    ]
                }
            ]
        }

        Args:
            kics_output: Raw KICS JSON output

        Returns:
            List of PolicyViolation objects
        """
        violations = []

        # Extract violations from KICS results
        if "queries" in kics_output:
            for query_result in kics_output["queries"]:
                query_name = query_result.get("query_name", "Unknown Query")
                query_id = query_result.get("query_id", "")
                severity = query_result.get("severity", "MEDIUM").lower()
                description = query_result.get("description", "")
                category = query_result.get("category", "")

                # Process each file that has violations for this query
                for file_result in query_result.get("files", []):
                    violation_msg = self._build_violation_message(
                        query_name=query_name,
                        description=description,
                        file_result=file_result,
                    )

                    violation = PolicyViolation(
                        message=violation_msg,
                        severity=severity,
                        line=file_result.get("line"),
                        resource=f"{file_result.get('resource_type', '')}.{file_result.get('resource_name', '')}",
                        details={
                            "query_id": query_id,
                            "query_name": query_name,
                            "category": category,
                            "description": description,
                            "expected_value": file_result.get("expected_value"),
                            "actual_value": file_result.get("actual_value"),
                            "search_key": file_result.get("search_key"),
                            "file_name": file_result.get("file_name"),
                        },
                    )
                    violations.append(violation)

        logger.info(f"Parsed {len(violations)} violations from KICS output")
        return violations

    def _build_violation_message(
        self, query_name: str, description: str, file_result: Dict[str, Any]
    ) -> str:
        """
        Build a human-readable violation message from KICS result.

        Args:
            query_name: Name of the violated query
            description: Query description
            file_result: Individual file result from KICS

        Returns:
            Formatted violation message
        """
        resource_info = ""
        if file_result.get("resource_type") and file_result.get("resource_name"):
            resource_info = (
                f" in {file_result['resource_type']}.{file_result['resource_name']}"
            )

        expected = file_result.get("expected_value", "")
        actual = file_result.get("actual_value", "")

        msg_parts = [f"{query_name}{resource_info}"]

        if description:
            msg_parts.append(description)

        if expected and actual:
            msg_parts.append(f"Expected: {expected}")
            msg_parts.append(f"Actual: {actual}")

        return " | ".join(msg_parts)
