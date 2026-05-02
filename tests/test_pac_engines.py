"""Tests for Policy as Code engines."""

import json
import subprocess
from pathlib import Path
from unittest.mock import MagicMock, Mock, patch

import pytest

from src.models import PolicyViolation
from src.pac_engines.kics_engine import KICSEngine
from src.pac_engines.opa_engine import OPAEngine


class TestOPAEngine:
    """Tests for OPA engine."""

    def test_initialization_success(self, sample_opa_config):
        """Test OPA engine initialization with valid config."""
        with patch("subprocess.run") as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            assert engine.binary_path == "opa"
            assert engine.timeout == 30

    def test_initialization_binary_not_found(self, sample_opa_config):
        """Test OPA engine initialization when binary is not found."""
        with patch("subprocess.run", side_effect=FileNotFoundError()):
            with pytest.raises(FileNotFoundError):
                OPAEngine(sample_opa_config)

    def test_evaluate_returns_violations(
        self, sample_opa_config, sample_rego_policy, sample_terraform_script
    ):
        """Test evaluate method returns violations."""
        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            # Mock evaluation
            opa_output = {
                "result": [
                    {
                        "expressions": [
                            {
                                "value": [
                                    "S3 bucket 'test-bucket' must have versioning enabled"
                                ]
                            }
                        ]
                    }
                ]
            }
            mock_run.return_value = Mock(
                returncode=0, stdout=json.dumps(opa_output), stderr=""
            )

            violations = engine.evaluate(sample_rego_policy, sample_terraform_script)

            assert len(violations) == 1
            assert isinstance(violations[0], PolicyViolation)
            assert "versioning" in violations[0].message.lower()

    def test_evaluate_no_violations(self, sample_opa_config):
        """Test evaluate method with compliant code."""
        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            # Mock evaluation with no violations
            opa_output = {"result": [{"expressions": [{"value": []}]}]}
            mock_run.return_value = Mock(
                returncode=0, stdout=json.dumps(opa_output), stderr=""
            )

            violations = engine.evaluate("policy", "script")
            assert len(violations) == 0

    def test_evaluate_timeout(self, sample_opa_config):
        """Test evaluate method handles timeout."""
        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            # Mock timeout
            mock_run.side_effect = subprocess.TimeoutExpired("opa", 30)

            violations = engine.evaluate("policy", "script")
            assert violations == []

    def test_validate_compliant_code(self, sample_opa_config):
        """Test validate method with compliant code."""
        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            # Mock evaluation with no violations
            opa_output = {"result": [{"expressions": [{"value": []}]}]}
            mock_run.return_value = Mock(
                returncode=0, stdout=json.dumps(opa_output), stderr=""
            )

            is_valid = engine.validate("policy", "script")
            assert is_valid is True

    def test_validate_non_compliant_code(self, sample_opa_config):
        """Test validate method with non-compliant code."""
        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            # Mock evaluation with violations
            opa_output = {
                "result": [{"expressions": [{"value": ["Violation message"]}]}]
            }
            mock_run.return_value = Mock(
                returncode=0, stdout=json.dumps(opa_output), stderr=""
            )

            is_valid = engine.validate("policy", "script")
            assert is_valid is False

    def test_format_violation_from_string(self, sample_opa_config):
        """Test _format_violation with string input."""
        with patch("subprocess.run") as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            violation = engine._format_violation("Test violation message")
            assert isinstance(violation, PolicyViolation)
            assert violation.message == "Test violation message"
            assert violation.severity == "error"

    def test_format_violation_from_dict(self, sample_opa_config):
        """Test _format_violation with dict input."""
        with patch("subprocess.run") as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)

            violation_data = {
                "message": "Test message",
                "severity": "warning",
                "line": 10,
                "resource": "aws_s3_bucket.test",
            }
            violation = engine._format_violation(violation_data)
            assert isinstance(violation, PolicyViolation)
            assert violation.message == "Test message"
            assert violation.severity == "warning"
            assert violation.line == 10
            assert violation.resource == "aws_s3_bucket.test"


class TestKICSEngine:
    """Tests for KICS engine."""

    def test_initialization_success(self, sample_kics_config):
        """Test KICS engine initialization with valid config."""
        with patch("subprocess.run") as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)
            assert engine.binary_path == "kics"
            assert engine.timeout == 60
            assert engine._cached_metadata is None

    def test_initialization_binary_not_found(self, sample_kics_config):
        """Test KICS engine initialization when binary is not found."""
        with patch("subprocess.run", side_effect=FileNotFoundError()):
            with pytest.raises(FileNotFoundError):
                KICSEngine(sample_kics_config)

    def test_evaluate_returns_violations(
        self, sample_kics_config, sample_rego_policy, sample_terraform_script
    ):
        """Test evaluate method returns violations."""
        # Mock KICS scan with violations
        kics_output = {
            "queries": [
                {
                    "query_name": "S3 Bucket Versioning Disabled",
                    "query_id": "b234567",
                    "severity": "MEDIUM",
                    "platform": "Terraform",
                    "category": "Best Practices",
                    "description": "S3 bucket does not have versioning enabled",
                    "files": [
                        {
                            "file_name": "main.tf",
                            "line": 1,
                            "resource_type": "aws_s3_bucket",
                            "resource_name": "test",
                            "expected_value": "versioning should be enabled",
                            "actual_value": "versioning is not set",
                        }
                    ],
                }
            ],
            "files_scanned": 1,
            "queries_total": 1,
        }

        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock KICS scan - write results file when called
            def run_kics(*args, **kwargs):
                # Extract results directory from command
                cmd = args[0] if args else kwargs.get("args", [])
                if isinstance(cmd, list) and "-o" in cmd:
                    results_dir = Path(cmd[cmd.index("-o") + 1])
                    results_file = results_dir / "results.json"
                    results_file.write_text(json.dumps(kics_output))
                return Mock(returncode=50, stdout="", stderr="")

            mock_run.side_effect = run_kics

            violations = engine.evaluate(sample_rego_policy, sample_terraform_script)

            assert len(violations) == 1
            assert isinstance(violations[0], PolicyViolation)
            assert "versioning" in violations[0].message.lower()

    def test_evaluate_no_violations(self, sample_kics_config):
        """Test evaluate method with compliant code."""
        kics_output = {
            "queries": [],
            "files_scanned": 1,
            "queries_total": 1,
        }

        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock KICS scan
            def run_kics(*args, **kwargs):
                cmd = args[0] if args else kwargs.get("args", [])
                if isinstance(cmd, list) and "-o" in cmd:
                    results_dir = Path(cmd[cmd.index("-o") + 1])
                    results_file = results_dir / "results.json"
                    results_file.write_text(json.dumps(kics_output))
                return Mock(returncode=0, stdout="", stderr="")

            mock_run.side_effect = run_kics

            violations = engine.evaluate("policy", "script")
            assert len(violations) == 0

    def test_evaluate_timeout(self, sample_kics_config):
        """Test evaluate method handles timeout."""
        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock timeout on scan
            mock_run.side_effect = subprocess.TimeoutExpired("kics", 60)

            violations = engine.evaluate("policy", "script")
            assert violations == []

    def test_validate_compliant_code(self, sample_kics_config):
        """Test validate method with compliant code."""
        kics_output = {
            "queries": [],
            "files_scanned": 1,
            "queries_total": 1,
        }

        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock KICS scan
            def run_kics(*args, **kwargs):
                cmd = args[0] if args else kwargs.get("args", [])
                if isinstance(cmd, list) and "-o" in cmd:
                    results_dir = Path(cmd[cmd.index("-o") + 1])
                    results_file = results_dir / "results.json"
                    results_file.write_text(json.dumps(kics_output))
                return Mock(returncode=0, stdout="", stderr="")

            mock_run.side_effect = run_kics

            is_valid = engine.validate("policy", "script")
            assert is_valid is True

    def test_validate_non_compliant_code(self, sample_kics_config):
        """Test validate method with non-compliant code."""
        kics_output = {
            "queries": [
                {
                    "query_name": "Security Issue",
                    "query_id": "abc123",
                    "severity": "HIGH",
                    "platform": "Terraform",
                    "category": "Security",
                    "description": "Security violation found",
                    "files": [
                        {
                            "file_name": "main.tf",
                            "line": 1,
                            "resource_type": "aws_s3_bucket",
                            "resource_name": "test",
                        }
                    ],
                }
            ],
            "files_scanned": 1,
            "queries_total": 1,
        }

        with patch("subprocess.run") as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock KICS scan
            def run_kics(*args, **kwargs):
                cmd = args[0] if args else kwargs.get("args", [])
                if isinstance(cmd, list) and "-o" in cmd:
                    results_dir = Path(cmd[cmd.index("-o") + 1])
                    results_file = results_dir / "results.json"
                    results_file.write_text(json.dumps(kics_output))
                return Mock(returncode=50, stdout="", stderr="")

            mock_run.side_effect = run_kics

            is_valid = engine.validate("policy", "script")
            assert is_valid is False

    def test_find_libraries_path_success(self, sample_kics_config):
        """Test _find_libraries_path finds libraries."""
        with patch("subprocess.run") as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock a library path that exists
            with patch("pathlib.Path.exists", return_value=True):
                with patch("pathlib.Path.is_dir", return_value=True):
                    lib_path = engine._find_libraries_path()
                    assert lib_path is not None

    def test_find_libraries_path_not_found(self, sample_kics_config):
        """Test _find_libraries_path handles missing libraries."""
        with patch("subprocess.run") as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="KICS version")
            engine = KICSEngine(sample_kics_config)

            # Mock no library paths exist
            with patch("pathlib.Path.exists", return_value=False):
                lib_path = engine._find_libraries_path()
                assert lib_path is None
