"""Tests for Policy as Code engines."""

import pytest
from unittest.mock import Mock, patch, MagicMock
import subprocess
import json

from src.pac_engines.opa_engine import OPAEngine
from src.pac_engines.sentinel_engine import SentinelEngine
from src.models import PolicyViolation


class TestOPAEngine:
    """Tests for OPA engine."""

    def test_initialization_success(self, sample_opa_config):
        """Test OPA engine initialization with valid config."""
        with patch('subprocess.run') as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            assert engine.binary_path == "opa"
            assert engine.timeout == 30

    def test_initialization_binary_not_found(self, sample_opa_config):
        """Test OPA engine initialization when binary is not found."""
        with patch('subprocess.run', side_effect=FileNotFoundError()):
            with pytest.raises(FileNotFoundError):
                OPAEngine(sample_opa_config)

    def test_evaluate_returns_violations(self, sample_opa_config, sample_rego_policy, sample_terraform_script):
        """Test evaluate method returns violations."""
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            # Mock evaluation
            opa_output = {
                "result": [{
                    "expressions": [{
                        "value": ["S3 bucket 'test-bucket' must have versioning enabled"]
                    }]
                }]
            }
            mock_run.return_value = Mock(
                returncode=0,
                stdout=json.dumps(opa_output),
                stderr=""
            )
            
            violations = engine.evaluate(sample_rego_policy, sample_terraform_script)
            
            assert len(violations) == 1
            assert isinstance(violations[0], PolicyViolation)
            assert "versioning" in violations[0].message.lower()

    def test_evaluate_no_violations(self, sample_opa_config):
        """Test evaluate method with compliant code."""
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            # Mock evaluation with no violations
            opa_output = {
                "result": [{
                    "expressions": [{
                        "value": []
                    }]
                }]
            }
            mock_run.return_value = Mock(
                returncode=0,
                stdout=json.dumps(opa_output),
                stderr=""
            )
            
            violations = engine.evaluate("policy", "script")
            assert len(violations) == 0

    def test_evaluate_timeout(self, sample_opa_config):
        """Test evaluate method handles timeout."""
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            # Mock timeout
            mock_run.side_effect = subprocess.TimeoutExpired("opa", 30)
            
            violations = engine.evaluate("policy", "script")
            assert violations == []

    def test_validate_compliant_code(self, sample_opa_config):
        """Test validate method with compliant code."""
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            # Mock evaluation with no violations
            opa_output = {
                "result": [{
                    "expressions": [{
                        "value": []
                    }]
                }]
            }
            mock_run.return_value = Mock(
                returncode=0,
                stdout=json.dumps(opa_output),
                stderr=""
            )
            
            is_valid = engine.validate("policy", "script")
            assert is_valid is True

    def test_validate_non_compliant_code(self, sample_opa_config):
        """Test validate method with non-compliant code."""
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            # Mock evaluation with violations
            opa_output = {
                "result": [{
                    "expressions": [{
                        "value": ["Violation message"]
                    }]
                }]
            }
            mock_run.return_value = Mock(
                returncode=0,
                stdout=json.dumps(opa_output),
                stderr=""
            )
            
            is_valid = engine.validate("policy", "script")
            assert is_valid is False

    def test_format_violation_from_string(self, sample_opa_config):
        """Test _format_violation with string input."""
        with patch('subprocess.run') as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            violation = engine._format_violation("Test violation message")
            assert isinstance(violation, PolicyViolation)
            assert violation.message == "Test violation message"
            assert violation.severity == "error"

    def test_format_violation_from_dict(self, sample_opa_config):
        """Test _format_violation with dict input."""
        with patch('subprocess.run') as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="OPA version")
            engine = OPAEngine(sample_opa_config)
            
            violation_data = {
                "message": "Test message",
                "severity": "warning",
                "line": 10,
                "resource": "aws_s3_bucket.test"
            }
            violation = engine._format_violation(violation_data)
            assert isinstance(violation, PolicyViolation)
            assert violation.message == "Test message"
            assert violation.severity == "warning"
            assert violation.line == 10
            assert violation.resource == "aws_s3_bucket.test"


class TestSentinelEngine:
    """Tests for Sentinel engine."""

    def test_initialization_success(self):
        """Test Sentinel engine initialization with valid config."""
        config = {"binary_path": "sentinel", "timeout": 30}
        with patch('subprocess.run') as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="Sentinel version")
            engine = SentinelEngine(config)
            assert engine.binary_path == "sentinel"
            assert engine.timeout == 30

    def test_initialization_binary_not_found(self):
        """Test Sentinel engine initialization when binary is not found."""
        config = {"binary_path": "sentinel", "timeout": 30}
        with patch('subprocess.run', side_effect=FileNotFoundError()):
            with pytest.raises(FileNotFoundError):
                SentinelEngine(config)

    def test_evaluate_policy_passed(self):
        """Test evaluate method when policy passes."""
        config = {"binary_path": "sentinel", "timeout": 30}
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="Sentinel version")
            engine = SentinelEngine(config)
            
            # Mock policy evaluation - passed
            mock_run.return_value = Mock(returncode=0, stdout="", stderr="")
            
            violations = engine.evaluate("policy", "script")
            assert len(violations) == 0

    def test_evaluate_policy_failed(self):
        """Test evaluate method when policy fails."""
        config = {"binary_path": "sentinel", "timeout": 30}
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="Sentinel version")
            engine = SentinelEngine(config)
            
            # Mock policy evaluation - failed
            sentinel_output = {
                "result": False,
                "trace": [
                    {"type": "error", "message": "Policy violation detected"}
                ]
            }
            mock_run.return_value = Mock(
                returncode=1,
                stdout=json.dumps(sentinel_output),
                stderr=""
            )
            
            violations = engine.evaluate("policy", "script")
            assert len(violations) > 0
            assert isinstance(violations[0], PolicyViolation)

    def test_validate_compliant_code(self):
        """Test validate method with compliant code."""
        config = {"binary_path": "sentinel", "timeout": 30}
        with patch('subprocess.run') as mock_run:
            # Mock verification
            mock_run.return_value = Mock(returncode=0, stdout="Sentinel version")
            engine = SentinelEngine(config)
            
            # Mock policy evaluation - passed
            mock_run.return_value = Mock(returncode=0, stdout="", stderr="")
            
            is_valid = engine.validate("policy", "script")
            assert is_valid is True

    def test_extract_resource_changes(self):
        """Test _extract_resource_changes method."""
        config = {"binary_path": "sentinel", "timeout": 30}
        with patch('subprocess.run') as mock_run:
            mock_run.return_value = Mock(returncode=0, stdout="Sentinel version")
            engine = SentinelEngine(config)
            
            script = '''resource "aws_s3_bucket" "test" {
  bucket = "test-bucket"
}

resource "aws_instance" "web" {
  ami = "ami-12345"
}'''
            
            resources = engine._extract_resource_changes(script)
            assert len(resources) == 2
            assert resources[0]["type"] == "aws_s3_bucket"
            assert resources[0]["name"] == "test"
            assert resources[1]["type"] == "aws_instance"
            assert resources[1]["name"] == "web"
