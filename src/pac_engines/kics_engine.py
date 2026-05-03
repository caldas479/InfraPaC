# ============================================================================
# src/pac_engines/kics_engine.py
# ============================================================================

import json
import logging
import subprocess
import tempfile
from pathlib import Path
from typing import Any, Dict, List, Optional

from src.models import PolicyViolation
from src.pac_engines.base_engine import BasePaCEngine

logger = logging.getLogger(__name__)


class KICSEngine(BasePaCEngine):
    """
    KICS (Keeping Infrastructure as Code Secure) engine implementation.

    Executes KICS queries against IaC scripts using custom query paths and
    automatically locates KICS helper libraries for policy evaluation.

    KICS is an open-source security scanner for Infrastructure as Code that
    supports multiple platforms including Terraform, CloudFormation, Kubernetes,
    Docker, and more. This engine integrates KICS into the InfraPaC repair
    framework to detect and fix security violations across all supported formats.

    The engine creates temporary directories for queries, IaC files, and results;
    generates the metadata.json required for KICS query recognition; automatically
    finds KICS libraries from common installation paths; executes the KICS scan
    with proper exit-code handling; and parses the JSON output into
    PolicyViolation objects.

    KICS must be installed and accessible via the binary_path in the config.
    Install with brew install kics on macOS or download from
    https://github.com/Checkmarx/kics.

    Example:
        engine = KICSEngine({"binary_path": "kics", "timeout": 60})
        violations = engine.evaluate(policy_text, iac_text)
        is_compliant = engine.validate(policy_text, iac_text)
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize KICS engine.

        Args:
            config: Configuration dictionary with 'binary_path' and 'timeout'
        """
        super().__init__(config)
        self._verify_installation()
        self._cached_metadata: Optional[Dict[str, Any]] = None

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

    def evaluate(
        self, policy: str, iac_script: str, metadata: Optional[Dict[str, Any]] = None
    ) -> List[PolicyViolation]:
        """
        Evaluate an IaC script against a KICS query.

        Steps performed:
        1. Creates temporary directories for queries, IaC files, and results.
        2. Writes the Rego policy to query.rego.
        3. Generates the metadata.json required by KICS for query recognition.
        4. Writes the IaC script to the filename specified in metadata (default main.tf).
        5. Locates KICS helper libraries and passes them to the scan command.
        6. Executes the KICS scan with JSON output format.
        7. Parses the JSON results into PolicyViolation objects.

        KICS exit codes:
            0  — no issues found
            20 — INFO severity violations
            30 — LOW severity violations
            40 — MEDIUM severity violations
            50 — HIGH severity violations
            60 — CRITICAL severity violations

        Args:
            policy: KICS query (Rego policy) content.
            iac_script: IaC script content in any KICS-supported format.
            metadata: Optional dict with keys query_id, query_name, severity,
                      description, platform, and iac_filename. Uses defaults
                      when not provided.

        Returns:
            List of PolicyViolation objects. Returns an empty list if the scan
            fails, times out, or produces no violations.
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

            # Use provided metadata, cached metadata, or fallback to defaults
            if metadata:
                # Cache metadata for subsequent calls
                self._cached_metadata = metadata
                kics_metadata = {
                    "id": metadata.get("query_id", "custom-query"),
                    "queryName": metadata.get("query_name", "Custom Policy Query"),
                    "severity": metadata.get("severity", "MEDIUM").upper(),
                    "category": metadata.get("category", "Security"),
                    "descriptionText": metadata.get(
                        "description", "Custom policy evaluation"
                    ),
                    "platform": metadata.get("platform", "Terraform"),
                    "descriptionID": metadata.get("query_id", "custom"),
                }
            elif self._cached_metadata:
                # Reuse cached metadata from previous call
                kics_metadata = {
                    "id": self._cached_metadata.get("query_id", "custom-query"),
                    "queryName": self._cached_metadata.get(
                        "query_name", "Custom Policy Query"
                    ),
                    "severity": self._cached_metadata.get("severity", "MEDIUM").upper(),
                    "category": self._cached_metadata.get("category", "Security"),
                    "descriptionText": self._cached_metadata.get(
                        "description", "Custom policy evaluation"
                    ),
                    "platform": self._cached_metadata.get("platform", "Terraform"),
                    "descriptionID": self._cached_metadata.get("query_id", "custom"),
                }
            else:
                kics_metadata = {
                    "id": "custom-query",
                    "queryName": "Custom Policy Query",
                    "severity": "MEDIUM",
                    "category": "Security",
                    "descriptionText": "Custom policy evaluation",
                    "platform": "Terraform",
                    "descriptionID": "custom",
                }

            metadata_file.write_text(json.dumps(kics_metadata, indent=2))

            # Write IaC file — use the filename from metadata when available
            # so KICS can infer the platform from the extension (e.g. .tf, .yaml, .json)
            iac_filename = (
                metadata.get("iac_filename")
                if metadata
                else (
                    self._cached_metadata.get("iac_filename")
                    if self._cached_metadata
                    else None
                )
            ) or "main.tf"
            iac_file = iac_dir / iac_filename
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

    def _find_libraries_path(self) -> Optional[Path]:
        """
        Find the KICS libraries directory from common installation locations.

        Searches in order:
        1. data/external-repos/kics/assets/libraries (project-local KICS clone)
        2. /opt/homebrew/opt/kics/share/kics/assets/libraries (Homebrew on Apple Silicon)
        3. /usr/local/share/kics/assets/libraries (manual or Intel Homebrew install)

        Returns:
            Path to the KICS libraries directory, or None if not found. When None
            is returned, queries that import library helper functions may fail.
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

    def validate(
        self, policy: str, iac_script: str, metadata: Optional[Dict[str, Any]] = None
    ) -> bool:
        """
        Check whether an IaC script complies with a KICS policy.

        Args:
            policy: KICS query (Rego policy) content.
            iac_script: IaC script content in any KICS-supported format.
            metadata: Optional metadata dict passed through to evaluate.

        Returns:
            True if no violations are found, False otherwise.
        """
        violations = self.evaluate(policy, iac_script, metadata)
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
