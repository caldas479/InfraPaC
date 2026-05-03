# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

InfraPaC is an automated Infrastructure as Code (IaC) repair framework that uses Large Language Models to fix policy violations across multiple IaC languages and cloud platforms. The system detects violations using Policy as Code engines (OPA and KICS), generates fixes via LLMs, and iteratively validates repairs until compliance is achieved.

Supported IaC formats: Terraform (HCL), Kubernetes (YAML), CloudFormation (YAML and JSON), Pulumi (YAML and JSON).

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
# Basic usage with policy and IaC file (default: OPA engine)
uv run python main.py --policy examples/kubernetes_no_resource_limits/policy.rego --iac examples/kubernetes_no_resource_limits/deployment.yaml

# Using KICS engine
uv run python main.py --policy-engine kics --policy <policy_file> --iac <iac_file>

# With verbose output
uv run python main.py --policy <policy_file> --iac <iac_file> --verbose

# Override LLM settings
uv run python main.py --policy <policy_file> --iac <iac_file> --llm-provider openai --llm-model gpt-4

# Save repaired output
uv run python main.py --policy <policy_file> --iac <iac_file> --output repaired.yaml
```

### Dataset Management
```bash
# SpecBugFix dataset (OPA-based, Terraform)
uv run python generate_patches.py

# Generate patch for specific entry
uv run python generate_patches.py --entry-id opa_storage_001

# Generate patches for category
uv run python generate_patches.py --category storage

# KICS Terraform dataset (700+ entries)
uv run python generate_patches_kics.py

# Generate patches for specific KICS category (aws, azure, gcp, kubernetes, github)
uv run python generate_patches_kics.py --category aws

# KICS Extended dataset (Kubernetes, Pulumi, CloudFormation — 591 entries)
PYTHONPATH=. uv run python experiments/run_rq2_extended.py

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

**1. Policy Engines (src/pac_engines/)**
- BasePaCEngine: Abstract base class defining the policy evaluation interface
- OPAEngine: Open Policy Agent implementation for evaluating Rego policies
  - Auto-detects IaC format (HCL, JSON, YAML) before parsing
  - Derives the OPA query from the policy package declaration
  - Supports Terraform, Kubernetes, CloudFormation, and Pulumi inputs
- KICSEngine: KICS (Keeping Infrastructure as Code Secure) implementation
  - Uses kics scan with custom queries and libraries
  - Automatically locates KICS helper libraries from multiple paths
  - Generates required metadata.json for query recognition
  - Platform and IaC filename are read from the metadata dict
  - Handles KICS exit codes (0-69) for various severity levels
  - Parses JSON output into PolicyViolation objects
- Each engine evaluates IaC scripts against policies and returns structured violations

**2. Repair Agent (src/agents/repair_agent.py)**
- Orchestrates the iterative repair workflow
- Coordinates between LLM-based repair generation and policy validation
- Tracks progress across iterations (default: max 3 iterations)
- Returns RepairResult with success status, iteration count, and repaired script

**3. Repair Chain (src/chains/repair_chain.py)**
- LangChain-based component that interfaces with LLMs
- Initializes LLM providers (Ollama, OpenAI, OpenRouter)
- Uses structured output (RepairOutput) for reliable response parsing
- Passes iac_language to PromptBuilder so prompts name the correct IaC format

**4. Prompt Builder (src/chains/prompt_builder.py)**
- Constructs structured prompts for LLM repair requests
- Accepts iac_language parameter (e.g. Terraform, CloudFormation, Kubernetes)
- Supports four styles: default, minimal, minimal_no_policy, costar
- Formats policy violations into readable text
- Note: Contains TODO for evolve_prompt method (reflection-based prompt evolution)

**5. Models (src/models.py)**
- Pydantic models for type safety and validation:
  - RepairOutput: Structured LLM response format with repaired_script field (used with with_structured_output)
  - PolicyViolation: Represents a single policy violation with message, severity, resource info
  - RepairResult: Encapsulates repair attempt outcomes
  - DatasetEntry: Represents Spec-Bug-Fix dataset entries
  - IaCScript, Policy, LLMResponse: Supporting models

### Control Flow

1. Detection: Policy engine evaluates IaC script against policy and produces a violations list
2. Repair Generation: RepairChain receives violations and current script; LLM generates a structured fix via RepairOutput
3. Validation: Policy engine re-evaluates the repaired script and produces new violations (if any)
4. Iteration: If violations remain and iterations < max_iterations, repeat from step 2
5. Result: Return success (no violations) or failure (violations remain after max iterations)

### IaC Format Detection (OPA engine)

The OPA engine auto-detects the format of an IaC script before parsing it:
- HCL: recognised by top-level Terraform block keywords (resource, variable, module, etc.)
- JSON: script starts with { or [
- YAML: contains a document separator (---) or key: value pairs
- Unknown: wrapped as {"iac_script": <raw text>} for raw-string policies

The OPA query string is derived from the policy package declaration:
- package kubernetes becomes data.kubernetes.deny
- package pulumi becomes data.pulumi.deny
- Falls back to data.terraform.deny when no package is found

### Structured Output

The repair chain uses LangChain's with_structured_output() to enforce type-safe responses:
- RepairOutput Pydantic model defines the expected response structure
- LLM responses are automatically validated and parsed
- No fragile string parsing or regex needed
- Both OpenAI and Ollama providers support structured output

### Configuration System

Configuration uses a layered approach (priority from highest to lowest):
1. Command-line arguments (--llm-provider, --max-iterations, etc.)
2. Configuration file (src/config/default_config.yaml)
3. Environment variables (loaded via src/utils/env_loader.py)

Key config sections:
- llm: provider, model, temperature, max_tokens, timeout, iac_language, prompt_style
- repair: max_iterations, validation_timeout
- opa/kics: binary_path, timeout
- logging: level, file, format

### Import Structure

The project uses absolute imports from the src/ package root:
```python
from src.agents.repair_agent import RepairAgent
from src.pac_engines.opa_engine import OPAEngine
from src.pac_engines.kics_engine import KICSEngine
from src.models import PolicyViolation, RepairResult
from src.chains.repair_chain import RepairChain
```

## External Dependencies

Critical Requirements:
- Policy Engine binary must be in PATH or specified in config:
  - OPA: brew install opa (macOS) or download from openpolicyagent.org
  - KICS: brew install kics (macOS) or download from github.com/Checkmarx/kics
- For Ollama: service must be running (ollama serve) with the desired model pulled (ollama pull codellama)
- For OpenAI: OPENAI_API_KEY environment variable must be set
- For OpenRouter: OPENROUTER_API_KEY environment variable must be set

## Dataset Structure

### SpecBugFix Dataset (OPA, Terraform)

```
data/datasets/spec_bug_fix/
├── dataset_index.json          # Metadata and entry index
└── <category>/
    └── <entry_id>/
        ├── policy.rego         # Policy specification
        ├── buggy.tf            # Violating IaC script
        ├── fixed.tf            # Reference fix
        └── patch.tf            # Generated repair (created by generate_patches.py)
```

### KICS Terraform Dataset (700+ entries)

```
data/datasets/spec_bug_fix_kics/
├── dataset_index.json          # Metadata and entry index
└── <category>/                 # aws, azure, gcp, kubernetes, github
    └── <entry_id>/
        ├── policy.rego         # KICS query
        ├── buggy.tf            # Violating IaC script
        ├── fixed.tf            # Reference fix (from KICS negative tests)
        ├── patch.tf            # Generated repair (created by generate_patches_kics.py)
        └── metadata.json       # Entry metadata
```

Dataset statistics: 453 AWS, 120 Azure, 60 GCP, 73 Kubernetes, 2 GitHub checks.

### KICS Extended Dataset (Kubernetes, Pulumi, CloudFormation — 591 entries)

```
data/datasets/spec_bug_fix_kics_extended/
├── dataset_index.json
└── <family>/<sub-category>/
    └── <entry_id>/
        ├── policy.rego
        ├── buggy.yaml          # Violating IaC script (YAML or JSON)
        ├── fixed.yaml          # Reference fix
        ├── patch.yaml          # Generated repair
        └── metadata.json
```

Category breakdown:
- kubernetes: 201 checks
- cloudformation/aws: 330, cloudformation/aws_bom: 18, cloudformation/aws_sam: 17
- pulumi/aws: 19, pulumi/azure: 2, pulumi/gcp: 2, pulumi/kubernetes: 2

Experiment logs are automatically saved to results/<dataset_name>/<model_name>/execution_<timestamp>.log.

## Testing Strategy

- Tests use pytest with mocking (pytest-mock, unittest.mock) to isolate from external dependencies
- Shared fixtures defined in tests/conftest.py
- Mock subprocess calls to OPA/KICS binaries
- Mock LLM API calls to avoid actual API usage in tests
- Target coverage: 70%+ overall

## Known TODOs and Future Work

From codebase inspection:
- src/agents/repair_agent.py: reflection chain not yet implemented (prompt evolution based on failed attempts)
- src/chains/prompt_builder.py: evolve_prompt(prompt, reflection) method not implemented
- src/config/default_config.yaml: request_context feature (asking developer for additional context) not yet implemented

## Pre-commit Hooks

The repository uses pre-commit hooks that run:
1. Standard checks (trailing whitespace, YAML validation excluding data/datasets/, merge conflicts)
2. Black formatting (line-length=88)
3. isort import sorting (black profile)
4. pytest test suite (all tests must pass before commit)
