# InfraPaC Test Suite

This directory contains the test suite for InfraPaC using pytest.

## Test Organization

```
tests/
├── conftest.py              # Shared fixtures and test configuration
├── test_pac_engines.py      # Tests for OPA and Sentinel engines
├── test_chains.py           # Tests for LangChain components
└── test_agents.py           # Tests for repair agent
```

## Running Tests

### Run all tests
```bash
uv run pytest tests/
```

### Run tests with verbose output
```bash
uv run pytest tests/ -v
```

### Run tests with coverage report
```bash
uv run pytest tests/ --cov=src --cov-report=html
```

### Run specific test file
```bash
uv run pytest tests/test_pac_engines.py
```

### Run specific test class
```bash
uv run pytest tests/test_agents.py::TestRepairAgent
```

### Run specific test
```bash
uv run pytest tests/test_agents.py::TestRepairAgent::test_repair_success_first_iteration
```

### Run tests matching a pattern
```bash
uv run pytest tests/ -k "repair"
```

### Run tests with output capture disabled (see print statements)
```bash
uv run pytest tests/ -s
```

## Test Coverage

The test suite covers:

### PAC Engines (`test_pac_engines.py`)
- **OPAEngine**: 9 tests
  - Initialization and verification
  - Policy evaluation with violations
  - Validation methods
  - Timeout handling
  - Violation formatting

- **SentinelEngine**: 6 tests
  - Initialization and verification
  - Policy evaluation
  - Resource extraction

### Chains (`test_chains.py`)
- **PromptBuilder**: 6 tests
  - Prompt generation for repairs
  - Validation prompts
  - Multiple violations handling
  - Severity levels

- **RepairChain**: 9 tests
  - LLM provider initialization (Ollama, OpenAI)
  - Repair generation
  - Code extraction from responses
  - Iteration handling

### Agents (`test_agents.py`)
- **RepairAgent**: 8 tests
  - Successful repairs (first iteration, multiple iterations)
  - Failure scenarios (max iterations reached)
  - Progress tracking
  - Previous attempt handling
  - Custom configurations

## Fixtures

Shared fixtures are defined in `conftest.py`:

- `sample_opa_config`: OPA engine configuration
- `sample_llm_config`: LLM configuration
- `sample_repair_config`: Repair agent configuration
- `sample_policy_violation`: Sample PolicyViolation object
- `sample_terraform_script`: Sample Terraform code
- `sample_rego_policy`: Sample Rego policy
- `examples_dir`: Path to examples directory
- `test_data_dir`: Path to test data directory

## Mocking

Tests use `pytest-mock` and `unittest.mock` to:
- Mock subprocess calls to OPA/Sentinel binaries
- Mock LLM API calls
- Isolate unit tests from external dependencies

## Continuous Integration

These tests are designed to run in CI/CD pipelines:

```bash
# Install dependencies
uv sync

# Run tests with coverage
uv run pytest tests/ --cov=src --cov-report=xml --cov-report=term

# Check coverage threshold
uv run pytest tests/ --cov=src --cov-fail-under=70
```

## Adding New Tests

1. Create test file: `test_<module>.py`
2. Import required modules and fixtures
3. Organize tests in classes: `class Test<Component>`
4. Use descriptive test names: `test_<what>_<scenario>`
5. Use mocking to avoid external dependencies
6. Add docstrings explaining what each test validates

Example:
```python
class TestNewFeature:
    """Tests for new feature."""
    
    def test_feature_success(self, sample_config):
        """Test successful execution of feature."""
        # Arrange
        feature = NewFeature(sample_config)
        
        # Act
        result = feature.execute()
        
        # Assert
        assert result.success is True
```

## Current Coverage

- **Overall**: 74%
- **repair_agent.py**: 100%
- **prompt_builder.py**: 100%
- **models.py**: 100%
- **repair_chain.py**: 93%
- **opa_engine.py**: 88%
- **sentinel_engine.py**: 85%
- **base_engine.py**: 81%

Areas needing more coverage:
- `utils/config_loader.py`: 0% (not yet tested)
- `utils/env_loader.py`: 0% (not yet tested)
- `utils/logging_config.py`: 0% (not yet tested)
