"""Tests for LangChain chains."""

import pytest
from unittest.mock import Mock, patch, MagicMock

from src.chains.prompt_builder import PromptBuilder
from src.chains.repair_chain import RepairChain
from src.models import PolicyViolation


class TestPromptBuilder:
    """Tests for PromptBuilder."""

    def test_initialization(self, sample_llm_config):
        """Test PromptBuilder initialization."""
        builder = PromptBuilder(sample_llm_config)
        assert builder.config == sample_llm_config

    def test_build_repair_prompt_basic(self, sample_llm_config, sample_policy_violation):
        """Test building a basic repair prompt."""
        builder = PromptBuilder(sample_llm_config)
        
        policy = "package terraform\ndeny[msg] { ... }"
        iac_script = 'resource "aws_s3_bucket" "test" { }'
        violations = [sample_policy_violation]
        
        prompt = builder.build_repair_prompt(policy, iac_script, violations)
        
        assert "Infrastructure as Code" in prompt
        assert "Policy" in prompt
        assert policy in prompt
        assert iac_script in prompt
        assert sample_policy_violation.message in prompt
        assert "Violations Detected" in prompt
        assert "Instructions" in prompt

    def test_build_repair_prompt_with_iteration(self, sample_llm_config, sample_policy_violation):
        """Test building repair prompt with iteration number."""
        builder = PromptBuilder(sample_llm_config)
        
        prompt = builder.build_repair_prompt(
            "policy",
            "script",
            [sample_policy_violation],
            iteration=2,
            previous_attempt="previous code"
        )
        
        assert "Iteration 2" in prompt
        assert "previous repair attempt" in prompt.lower()

    def test_build_repair_prompt_multiple_violations(self, sample_llm_config):
        """Test building repair prompt with multiple violations."""
        builder = PromptBuilder(sample_llm_config)
        
        violations = [
            PolicyViolation(message="Violation 1", severity="error"),
            PolicyViolation(message="Violation 2", severity="warning", resource="aws_s3_bucket.test"),
            PolicyViolation(message="Violation 3", severity="error", line=10),
        ]
        
        prompt = builder.build_repair_prompt("policy", "script", violations)
        
        assert "3 violation(s)" in prompt
        assert "Violation 1" in prompt
        assert "Violation 2" in prompt
        assert "Violation 3" in prompt
        assert "Resource: aws_s3_bucket.test" in prompt
        assert "Line: 10" in prompt

    def test_build_repair_prompt_with_severity(self, sample_llm_config):
        """Test that severity is included in prompt."""
        builder = PromptBuilder(sample_llm_config)
        
        violations = [
            PolicyViolation(message="Critical issue", severity="critical"),
            PolicyViolation(message="Warning issue", severity="warning"),
        ]
        
        prompt = builder.build_repair_prompt("policy", "script", violations)
        
        assert "[CRITICAL]" in prompt
        assert "[WARNING]" in prompt

    def test_build_validation_prompt(self, sample_llm_config):
        """Test building validation prompt."""
        builder = PromptBuilder(sample_llm_config)
        
        policy = "package terraform"
        original = 'resource "aws_s3_bucket" "old" { }'
        repaired = 'resource "aws_s3_bucket" "new" { versioning { enabled = true } }'
        
        prompt = builder.build_validation_prompt(policy, original, repaired)
        
        assert policy in prompt
        assert original in prompt
        assert repaired in prompt
        assert "Compare" in prompt or "compare" in prompt
        assert "Original Script" in prompt
        assert "Repaired Script" in prompt


class TestRepairChain:
    """Tests for RepairChain."""

    def test_initialization_ollama(self, sample_llm_config):
        """Test RepairChain initialization with Ollama."""
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
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
        
        with patch('src.chains.repair_chain.ChatOpenAI') as mock_openai:
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
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
            # Setup mock LLM
            mock_llm = Mock()
            mock_response = Mock()
            mock_response.content = 'resource "aws_s3_bucket" "test" {\n  versioning {\n    enabled = true\n  }\n}'
            mock_llm.invoke.return_value = mock_response
            mock_ollama.return_value = mock_llm
            
            chain = RepairChain(sample_llm_config)
            
            result = chain.repair(
                policy="policy",
                iac_script="script",
                violations=[sample_policy_violation]
            )
            
            assert "versioning" in result
            assert "enabled = true" in result
            mock_llm.invoke.assert_called_once()

    def test_repair_with_iteration(self, sample_llm_config, sample_policy_violation):
        """Test repair with iteration and previous attempt."""
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
            mock_llm = Mock()
            mock_response = Mock()
            mock_response.content = "repaired code"
            mock_llm.invoke.return_value = mock_response
            mock_ollama.return_value = mock_llm
            
            chain = RepairChain(sample_llm_config)
            
            result = chain.repair(
                policy="policy",
                iac_script="script",
                violations=[sample_policy_violation],
                iteration=2,
                previous_attempt="previous code"
            )
            
            assert result == "repaired code"

    def test_extract_code_with_terraform_markers(self, sample_llm_config):
        """Test _extract_code with terraform code markers."""
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)
            
            response = Mock()
            response.content = '''Here is the fixed code:

```terraform
resource "aws_s3_bucket" "test" {
  bucket = "test"
  versioning {
    enabled = true
  }
}
```

This fixes the issue.'''
            
            code = chain._extract_code(response)
            
            assert "resource" in code
            assert "versioning" in code
            assert "Here is the fixed code" not in code
            assert "This fixes the issue" not in code
            assert "```" not in code

    def test_extract_code_with_hcl_markers(self, sample_llm_config):
        """Test _extract_code with hcl code markers."""
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)
            
            response = Mock()
            response.content = '```hcl\nresource "aws_s3_bucket" "test" { }\n```'
            
            code = chain._extract_code(response)
            
            assert 'resource "aws_s3_bucket" "test" { }' in code
            assert "```" not in code

    def test_extract_code_without_markers(self, sample_llm_config):
        """Test _extract_code without code markers."""
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)
            
            response = Mock()
            response.content = 'resource "aws_s3_bucket" "test" { }'
            
            code = chain._extract_code(response)
            
            assert code == 'resource "aws_s3_bucket" "test" { }'

    def test_extract_code_from_string_response(self, sample_llm_config):
        """Test _extract_code with string response (not AIMessage)."""
        with patch('src.chains.repair_chain.ChatOllama') as mock_ollama:
            mock_ollama.return_value = Mock()
            chain = RepairChain(sample_llm_config)
            
            response = "plain string response"
            
            code = chain._extract_code(response)
            
            assert code == "plain string response"
