"""Tests for LangChain chains."""

from unittest.mock import MagicMock, Mock, patch

import pytest

from src.chains.prompt_builder import PromptBuilder
from src.chains.repair_chain import RepairChain
from src.models import PolicyViolation


class TestPromptBuilder:
    """Tests for PromptBuilder."""

    def test_initialization(self, sample_llm_config):
        """Test PromptBuilder initialization."""
        builder = PromptBuilder(sample_llm_config)
        assert builder.config == sample_llm_config

    def test_build_repair_prompt_template(self, sample_llm_config):
        """Test building a repair prompt template."""
        builder = PromptBuilder(sample_llm_config)

        template = builder.build_repair_prompt_template()

        # Check that template is created
        assert template is not None
        # Check that template has the expected input variables
        prompt_text = str(template.messages[0].prompt.template)
        assert "{policy}" in prompt_text
        assert "{violations_text}" in prompt_text
        assert "{iac_script}" in prompt_text
        assert "Infrastructure as Code" in prompt_text
        assert "Violations Detected" in prompt_text
        assert "Instructions" in prompt_text

    def test_format_violations_single(self, sample_llm_config, sample_policy_violation):
        """Test formatting a single violation."""
        builder = PromptBuilder(sample_llm_config)

        violations_text = builder.format_violations([sample_policy_violation])

        assert "1 violation(s)" in violations_text
        assert sample_policy_violation.message in violations_text
        assert sample_policy_violation.resource in violations_text

    def test_format_violations_multiple(self, sample_llm_config):
        """Test formatting multiple violations."""
        builder = PromptBuilder(sample_llm_config)

        violations = [
            PolicyViolation(message="Violation 1", severity="error"),
            PolicyViolation(
                message="Violation 2", severity="warning", resource="aws_s3_bucket.test"
            ),
            PolicyViolation(message="Violation 3", severity="error", line=10),
        ]

        violations_text = builder.format_violations(violations)

        assert "3 violation(s)" in violations_text
        assert "Violation 1" in violations_text
        assert "Violation 2" in violations_text
        assert "Violation 3" in violations_text
        assert "Resource: aws_s3_bucket.test" in violations_text
        assert "Line: 10" in violations_text

    def test_format_violations_with_severity(self, sample_llm_config):
        """Test that severity is included in formatted violations."""
        builder = PromptBuilder(sample_llm_config)

        violations = [
            PolicyViolation(message="Critical issue", severity="critical"),
            PolicyViolation(message="Warning issue", severity="warning"),
        ]

        violations_text = builder.format_violations(violations)

        assert "[CRITICAL]" in violations_text
        assert "[WARNING]" in violations_text


class TestRepairChain:
    """Tests for RepairChain."""

    def test_initialization_ollama(self, sample_llm_config):
        """Test RepairChain initialization with Ollama."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)

            assert chain.llm_config == sample_llm_config
            assert chain.prompt_builder is not None
            mock_ollama.assert_called_once()

    def test_initialization_openai(self):
        """Test RepairChain initialization with OpenAI."""
        config = {
            "provider": "openai",
            "model": "gpt-4",
            "temperature": 0.2,
            "max_tokens": 2048,
        }

        with patch("src.chains.repair_chain.ChatOpenAI") as mock_openai:
            mock_openai.return_value = Mock()
            chain = RepairChain(config)

            mock_openai.assert_called_once()

    def test_initialization_unsupported_provider(self):
        """Test RepairChain initialization with unsupported provider."""
        config = {
            "provider": "unsupported",
            "model": "test",
        }

        with pytest.raises(ValueError, match="Unsupported LLM provider"):
            RepairChain(config)

    def test_repair_basic(self, sample_llm_config, sample_policy_violation):
        """Test basic repair functionality."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama, patch(
            "src.chains.repair_chain.PromptBuilder"
        ) as mock_builder_class:
            # Setup mock LLM
            mock_llm = Mock()
            mock_response = Mock()
            mock_response.content = 'resource "aws_s3_bucket" "test" {\n  versioning {\n    enabled = true\n  }\n}'
            mock_ollama.return_value = mock_llm

            # Setup mock prompt builder
            mock_builder = Mock()
            mock_template = Mock()
            mock_chain = Mock()
            mock_chain.invoke.return_value = mock_response
            mock_template.__or__ = Mock(return_value=mock_chain)
            mock_builder.build_repair_prompt_template.return_value = mock_template
            mock_builder.format_violations.return_value = "Test violation"
            mock_builder_class.return_value = mock_builder

            chain = RepairChain(sample_llm_config)

            result = chain.repair(
                policy="policy",
                iac_script="script",
                violations=[sample_policy_violation],
            )

            assert "versioning" in result
            assert "enabled = true" in result

    def test_extract_code_with_terraform_markers(self, sample_llm_config):
        """Test _extract_code with terraform code markers."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)

            response = Mock()
            response.content = """Here is the fixed code:

```terraform
resource "aws_s3_bucket" "test" {
  bucket = "test"
  versioning {
    enabled = true
  }
}
```

This fixes the issue."""

            code = chain._extract_code(response)

            assert "resource" in code
            assert "versioning" in code
            assert "Here is the fixed code" not in code
            assert "This fixes the issue" not in code
            assert "```" not in code

    def test_extract_code_with_hcl_markers(self, sample_llm_config):
        """Test _extract_code with hcl code markers."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)

            response = Mock()
            response.content = '```hcl\nresource "aws_s3_bucket" "test" { }\n```'

            code = chain._extract_code(response)

            assert 'resource "aws_s3_bucket" "test" { }' in code
            assert "```" not in code

    def test_extract_code_without_markers(self, sample_llm_config):
        """Test _extract_code without code markers."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)

            response = Mock()
            response.content = 'resource "aws_s3_bucket" "test" { }'

            code = chain._extract_code(response)

            assert code == 'resource "aws_s3_bucket" "test" { }'

    def test_extract_code_from_string_response(self, sample_llm_config):
        """Test _extract_code with string response (not AIMessage)."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)

            response = "plain string response"

            code = chain._extract_code(response)

            assert code == "plain string response"

    def test_extract_code_with_multiple_code_blocks(self, sample_llm_config):
        """Test _extract_code with multiple code blocks - should return the last one."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)

            response = Mock()
            response.content = """Here is the original code with the issue:

```terraform
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security group for web servers"
  vpc_id      = "vpc-12345678"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

The corrected Terraform script satisfies the policy by restricting the CIDR blocks.
The corrected Terraform script is:

```terraform
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security group for web servers"
  vpc_id      = "vpc-12345678"

  ingress {
    description = "SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.0.2.42/32"]
  }
}
```"""

            code = chain._extract_code(response)

            # Should extract the LAST code block (the corrected one)
            assert "192.0.2.42/32" in code
            assert "SSH from specific IP" in code
            # Should NOT contain the first code block content
            assert "SSH from anywhere" not in code
            assert "0.0.0.0/0" not in code
            # Should not contain explanatory text
            assert "The corrected Terraform script" not in code
            assert "```" not in code
