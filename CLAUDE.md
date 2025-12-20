# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

InfraPaC is an automated Infrastructure as Code (IaC) repair framework that uses Large Language Models to fix policy violations in Terraform configurations. The system detects violations using Policy as Code engines (OPA/Sentinel), generates fixes via LLMs, and iteratively validates repairs until compliance is achieved.

## Development Commands

### Installation
```bash
# Install dependencies
pip install -e .

# Or using uv (recommended)
uv sync
```

### Running the Main Tool
```bash
# Basic usage with policy and IaC file
uv run python main.py --policy examples/s3_versioning.rego --iac examples/s3_bucket.tf

# With verbose output
uv run python main.py --policy <policy_file> --iac <iac_file> --verbose

# Override LLM settings
uv run python main.py --policy <policy_file> --iac <iac_file> --llm-provider openai --llm-model gpt-4

# Save repaired output
uv run python main.py --policy <policy_file> --iac <iac_file> --output repaired.tf
```

### Dataset Management
```bash
# Generate patches for all dataset entries
uv run python generate_patches.py

# Generate patch for specific entry
uv run python generate_patches.py --entry-id opa_storage_001

# Generate patches for category
uv run python generate_patches.py --category storage

# Skip existing patches
uv run python generate_patches.py --skip-existing --verbose
```

### Testing
```bash
# Run all tests
uv run pytest tests/

# Run specific test file
uv run pytest tests/test_agents.py

# Run specific test class or function
uv run pytest tests/test_agents.py::TestRepairAgent::test_repair_success_first_iteration

# Run with coverage report
uv run pytest tests/ --cov=src --cov-report=html

# Run tests matching pattern
uv run pytest tests/ -k "repair"
```

### Code Quality
```bash
# Format code with black
black src tests

# Sort imports
isort src tests

# Run pre-commit hooks manually
pre-commit run --all-files

# Install pre-commit hooks
pre-commit install
```

## Architecture

### Core Components

**1. Policy Engines (`src/pac_engines/`)**
- `BasePaCEngine`: Abstract base class defining the policy evaluation interface
- `OPAEngine`: Open Policy Agent implementation for evaluating Rego policies
- `SentinelEngine`: HashiCorp Sentinel implementation
- Each engine evaluates IaC scripts against policies and returns structured violations

**2. Repair Agent (`src/agents/repair_agent.py`)**
- Orchestrates the iterative repair workflow
- Coordinates between LLM-based repair generation and policy validation
- Tracks progress across iterations (default: max 3 iterations)
- Returns `RepairResult` with success status, iteration count, and repaired script

**3. Repair Chain (`src/chains/repair_chain.py`)**
- LangChain-based component that interfaces with LLMs
- Initializes LLM providers (Ollama, OpenAI)
- Generates repair suggestions based on policy violations
- Extracts Terraform code from LLM responses (handles markdown code blocks)

**4. Prompt Builder (`src/chains/prompt_builder.py`)**
- Constructs structured prompts for LLM repair requests
- Formats policy violations into readable text
- Uses `ChatPromptTemplate` from LangChain for consistent prompt structure
- Note: Contains TODO for evolve_prompt method (reflection-based prompt evolution)

**5. Models (`src/models.py`)**
- Pydantic models for type safety and validation:
  - `RepairOutput`: Structured LLM response format with repaired_script field (used with with_structured_output)
  - `PolicyViolation`: Represents a single policy violation with message, severity, resource info
  - `RepairResult`: Encapsulates repair attempt outcomes
  - `DatasetEntry`: Represents Spec-Bug-Fix dataset entries
  - `IaCScript`, `Policy`, `LLMResponse`: Supporting models

### Control Flow

1. **Detection**: Policy engine evaluates IaC script against policy → produces violations list
2. **Repair Generation**: RepairChain receives violations and current script → LLM generates structured fix via `RepairOutput` model
3. **Validation**: Policy engine re-evaluates repaired script → produces new violations (if any)
4. **Iteration**: If violations remain and iterations < max_iterations, repeat from step 2
5. **Result**: Return success (no violations) or failure (violations remain after max iterations)

### Structured Output

The repair chain uses LangChain's `with_structured_output()` to enforce type-safe responses from LLMs:
- `RepairOutput` Pydantic model defines the expected response structure
- LLM responses are automatically validated and parsed
- No fragile string parsing or regex needed
- If provider doesn't support structured output, initialization fails with clear error
- Both OpenAI and Ollama providers support structured output

### Configuration System

Configuration uses a layered approach (priority from highest to lowest):
1. Command-line arguments (`--llm-provider`, `--max-iterations`, etc.)
2. Configuration file (`src/config/default_config.yaml`)
3. Environment variables (loaded via `src/utils/env_loader.py`)

Key config sections:
- `llm`: Provider, model, temperature, max_tokens, timeout
- `repair`: max_iterations, validation_timeout
- `opa`/`sentinel`: binary_path, timeout
- `logging`: level, file, format

### Import Structure

The project uses absolute imports from the `src/` package root:
```python
from src.agents.repair_agent import RepairAgent
from src.pac_engines.opa_engine import OPAEngine
from src.models import PolicyViolation, RepairResult
from src.chains.repair_chain import RepairChain
```

## External Dependencies

**Critical Requirements:**
- OPA binary (`opa`) must be in PATH or specified in config
  - Install: `brew install opa` (macOS) or download from openpolicyagent.org
- For Ollama: Service must be running (`ollama serve`) with desired model pulled (`ollama pull codellama`)
- For OpenAI: `OPENAI_API_KEY` environment variable must be set

## Dataset Structure

The project uses the SpecBugFix dataset format:
```
data/datasets/spec_bug_fix/
├── dataset_index.json          # Metadata and entry index
└── <category>/
    └── <entry_id>/
        ├── policy.rego         # Policy specification
        ├── buggy.tf           # Violating IaC script
        ├── fixed.tf           # Reference fix
        └── patch.tf           # Generated repair (created by generate_patches.py)
```

Experiment logs are automatically saved to `results/<dataset_name>/<model_name>/execution_<timestamp>.log`

## Testing Strategy

- Tests use pytest with mocking (`pytest-mock`, `unittest.mock`) to isolate from external dependencies
- Shared fixtures defined in `tests/conftest.py`
- Mock subprocess calls to OPA/Sentinel binaries
- Mock LLM API calls to avoid actual API usage in tests
- Target coverage: 70%+ overall

## Known TODOs and Future Work

From codebase inspection:
- `src/agents/repair_agent.py:99-103`: Reflection chain not yet implemented (prompt evolution based on failed attempts)
- `src/chains/prompt_builder.py:86`: `evolve_prompt(prompt, reflection)` method not implemented
- `src/config/default_config.yaml:14`: `request_context` feature (asking developer for additional context) not yet implemented

## Pre-commit Hooks

The repository uses pre-commit hooks that run:
1. Standard checks (trailing whitespace, YAML validation, merge conflicts)
2. Black formatting (line-length=88)
3. isort import sorting (black profile)
4. pytest test suite (all tests must pass before commit)
