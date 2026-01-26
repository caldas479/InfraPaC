"""Tests for LangChain chains."""

from unittest.mock import MagicMock, Mock, patch

import pytest

from src.chains.prompt_builder import PromptBuilder
from src.chains.repair_chain import RepairChain
from src.models import PolicyViolation, RepairOutput


class TestPromptBuilder:
    """Tests for PromptBuilder."""

    def test_initialization(self):
        """Test PromptBuilder initialization."""
        builder = PromptBuilder()
        assert builder is not None

    def test_build_repair_prompt_template(self):
        """Test building a repair prompt template."""
        builder = PromptBuilder()

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

    def test_format_violations_single(self, sample_policy_violation):
        """Test formatting a single violation."""
        builder = PromptBuilder()

        violations_text = builder.format_violations([sample_policy_violation])

        assert "1 violation(s)" in violations_text
        assert sample_policy_violation.message in violations_text
        assert sample_policy_violation.resource in violations_text

    def test_format_violations_multiple(self):
        """Test formatting multiple violations."""
        builder = PromptBuilder()

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

    def test_format_violations_with_severity(self):
        """Test that severity is included in formatted violations."""
        builder = PromptBuilder()

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
            mock_llm = Mock()
            mock_structured_llm = Mock()
            mock_llm.with_structured_output.return_value = mock_structured_llm
            mock_ollama.return_value = mock_llm

            chain = RepairChain(sample_llm_config)

            assert chain.llm_config == sample_llm_config
            assert chain.prompt_builder is not None
            mock_ollama.assert_called_once()
            mock_llm.with_structured_output.assert_called_once_with(RepairOutput)

    def test_initialization_openai(self):
        """Test RepairChain initialization with OpenAI."""
        config = {
            "provider": "openai",
            "model": "gpt-4",
            "temperature": 0.2,
            "max_tokens": 2048,
        }

        with patch("src.chains.repair_chain.ChatOpenAI") as mock_openai:
            mock_llm = Mock()
            mock_structured_llm = Mock()
            mock_llm.with_structured_output.return_value = mock_structured_llm
            mock_openai.return_value = mock_llm

            chain = RepairChain(config)

            mock_openai.assert_called_once()
            mock_llm.with_structured_output.assert_called_once_with(RepairOutput)

    def test_initialization_unsupported_provider(self):
        """Test RepairChain initialization with unsupported provider."""
        config = {
            "provider": "unsupported",
            "model": "test",
        }

        with pytest.raises(ValueError, match="Unsupported LLM provider"):
            RepairChain(config)

    def test_repair_basic(self, sample_llm_config, sample_policy_violation):
        """Test basic repair functionality with structured output."""
        with (
            patch("src.chains.repair_chain.ChatOllama") as mock_ollama,
            patch("src.chains.repair_chain.PromptBuilder") as mock_builder_class,
        ):
            # Setup mock LLM with structured output
            mock_llm = Mock()
            mock_structured_llm = Mock()
            mock_llm.with_structured_output.return_value = mock_structured_llm
            mock_ollama.return_value = mock_llm

            # Setup mock response as RepairOutput
            mock_response = RepairOutput(
                repaired_script='resource "aws_s3_bucket" "test" {\n  versioning {\n    enabled = true\n  }\n}'
            )

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

    def test_repair_structured_output_failure(
        self, sample_llm_config, sample_policy_violation
    ):
        """Test repair with structured output failure."""
        with (
            patch("src.chains.repair_chain.ChatOllama") as mock_ollama,
            patch("src.chains.repair_chain.PromptBuilder") as mock_builder_class,
        ):
            # Setup mock LLM with structured output
            mock_llm = Mock()
            mock_structured_llm = Mock()
            mock_llm.with_structured_output.return_value = mock_structured_llm
            mock_ollama.return_value = mock_llm

            # Setup mock prompt builder
            mock_builder = Mock()
            mock_template = Mock()
            mock_chain = Mock()
            # Simulate structured output failure
            mock_chain.invoke.side_effect = Exception(
                "Structured output parsing failed"
            )
            mock_template.__or__ = Mock(return_value=mock_chain)
            mock_builder.build_repair_prompt_template.return_value = mock_template
            mock_builder.format_violations.return_value = "Test violation"
            mock_builder_class.return_value = mock_builder

            chain = RepairChain(sample_llm_config)

            # Should raise ValueError with helpful error message
            with pytest.raises(ValueError, match="Failed to parse structured output"):
                chain.repair(
                    policy="policy",
                    iac_script="script",
                    violations=[sample_policy_violation],
                )

    def test_initialization_with_structured_output_failure(self, sample_llm_config):
        """Test initialization when provider doesn't support structured output."""
        with patch("src.chains.repair_chain.ChatOllama") as mock_ollama:
            mock_llm = Mock()
            # Simulate with_structured_output not supported
            mock_llm.with_structured_output.side_effect = AttributeError(
                "Not supported"
            )
            mock_ollama.return_value = mock_llm

            # Should raise ValueError with helpful error message
            with pytest.raises(ValueError, match="does not support structured output"):
                RepairChain(sample_llm_config)
