# InfraPaC: Automated Infrastructure as Code Repair via Policy as Code

InfraPaC is an automated Infrastructure as Code (IaC) repair framework that uses Large Language Models to fix policy violations in Terraform configurations. The system detects violations using Policy as Code engines (OPA/KICS), generates fixes via LLMs, and iteratively validates repairs until compliance is achieved.

<p align="center">
  <img width="615" height="906" alt="image" src="https://github.com/user-attachments/assets/2ff75cb4-d435-4c95-b92d-718cd0057f79" />
</p>

## Overview

InfraPaC works in three steps:

1. **Detect** — evaluate a Terraform script against a policy using OPA or KICS
2. **Repair** — send violations to an LLM and generate a compliant replacement script
3. **Validate** — re-evaluate the repaired script; iterate until all violations are resolved or the maximum number of attempts is reached

## Features

- 🔍 Policy violation detection via OPA or KICS
- 🤖 LLM-based repair generation (OpenAI, OpenRouter, Ollama)
- ✅ Automated fix validation with iterative repair loop
- 🎨 Multiple prompt styles (default, minimal, CO-STAR, no-policy)
- 📦 Large-scale dataset support (700+ KICS security checks)
- 🎯 Modular design — swap engines and LLM providers independently

## Prerequisites

- Python 3.12+
- At least one Policy Engine: OPA CLI or KICS
- An LLM backend: Ollama (local) **or** an OpenAI / OpenRouter API key

## Installation

1. Clone the repository:

```bash
git clone https://github.com/caldas479/InfraPaC.git
cd InfraPaC
```

2. Install dependencies (using [uv](https://github.com/astral-sh/uv), recommended):

```bash
uv sync
```

Or with pip:

```bash
pip install -e .
```

3. Install a Policy Engine:

**KICS** (recommended for comprehensive security scanning):
```bash
# macOS
brew install kics

# Linux
curl -L https://github.com/Checkmarx/kics/releases/latest/download/kics_linux_amd64.tar.gz | tar -xz
sudo mv kics /usr/local/bin
```

**OPA** (Open Policy Agent):
```bash
# macOS
brew install opa

# Linux
curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64_static
chmod 755 opa && sudo mv opa /usr/local/bin
```

4. Configure your LLM backend (choose one):

**Ollama** (local, free):
```bash
curl https://ollama.ai/install.sh | sh
ollama serve
ollama pull codellama
```

**OpenAI**:
```bash
export OPENAI_API_KEY=sk-...
```

**OpenRouter** (access to many models via one API):
```bash
export OPENROUTER_API_KEY=sk-or-...
```

## Usage

### Basic usage

```bash
# KICS engine (recommended)
uv run python main.py \
  --policy-engine kics \
  --policy data/datasets/spec_bug_fix_kics/aws/kics_aws_elasticsearch_without_slow_logs_001/policy.rego \
  --iac data/datasets/spec_bug_fix_kics/aws/kics_aws_elasticsearch_without_slow_logs_001/buggy.tf \
  --verbose

# OPA engine
uv run python main.py \
  --policy examples/s3_versioning.rego \
  --iac examples/s3_bucket.tf \
  --verbose

# Save repaired output to a file
uv run python main.py \
  --policy examples/s3_versioning.rego \
  --iac examples/s3_bucket.tf \
  --output repaired.tf
```

### Choosing an LLM provider

```bash
# OpenAI
uv run python main.py --policy ... --iac ... --llm-provider openai --llm-model gpt-4o

# OpenRouter
uv run python main.py --policy ... --iac ... --llm-provider openrouter --llm-model meta-llama/llama-3.3-70b-instruct

# Ollama (default)
uv run python main.py --policy ... --iac ... --llm-provider ollama --llm-model codellama
```

### Prompt styles

InfraPaC supports four prompt styles that control how the repair request is framed:

| Style | Description |
|---|---|
| `default` | Detailed prompt with full instructions and formatting guidance |
| `minimal` | Compact prompt with policy, violations, and script only |
| `costar` | Structured CO-STAR prompt (Context / Objective / Style / Tone / Audience / Response) |
| `minimal_no_policy` | Like `minimal` but omits the policy text — violations only |

Configure via `src/config/default_config.yaml` or pass `prompt_style` in the LLM config.

## Dataset Management

### KICS Dataset (700+ security checks)

```bash
# All entries
uv run python generate_patches_kics.py

# Specific entry
uv run python generate_patches_kics.py --entry-id kics_aws_elasticsearch_without_slow_logs_001

# By cloud provider (aws, azure, gcp, kubernetes, github)
uv run python generate_patches_kics.py --category aws

# Skip already-patched entries
uv run python generate_patches_kics.py --skip-existing --verbose
```

Dataset breakdown:
- 453 AWS security checks
- 120 Azure security checks
- 60 GCP security checks
- 73 Kubernetes security checks
- 2 GitHub security checks

### SpecBugFix Dataset (OPA-based)

```bash
# All entries
uv run python generate_patches.py

# Specific entry or category
uv run python generate_patches.py --entry-id opa_storage_001
uv run python generate_patches.py --category storage --skip-existing --verbose
```

## Configuration

Configuration is layered (highest priority first):

1. Command-line arguments
2. `src/config/default_config.yaml`
3. Environment variables

Key options:

| Option | Description |
|---|---|
| `--llm-provider` | `ollama`, `openai`, or `openrouter` |
| `--llm-model` | Model name (e.g. `codellama`, `gpt-4o`) |
| `--max-iterations` | Maximum repair attempts (default: 3) |
| `--policy-engine` | `opa` or `kics` |
| `--verbose` | Enable debug logging |

## Project Structure

```
InfraPaC/
├── src/
│   ├── agents/         # Repair agent orchestration
│   ├── chains/         # LangChain repair chain and prompt builder
│   ├── pac_engines/    # OPA and KICS engine wrappers
│   ├── datasets/       # Dataset loading and handling
│   ├── utils/          # Config loader, env loader, logging
│   └── config/         # default_config.yaml
├── data/
│   ├── datasets/
│   │   ├── spec_bug_fix/          # OPA-based dataset
│   │   └── spec_bug_fix_kics/     # KICS dataset (700+ entries)
│   └── examples/
├── tests/              # Pytest test suite
├── examples/           # Example policies and Terraform files
├── main.py             # CLI entry point
├── generate_patches.py
└── generate_patches_kics.py
```

## Testing

```bash
# Run all tests
uv run pytest tests/

# With coverage report
uv run pytest tests/ --cov=src --cov-report=html

# Run a specific test
uv run pytest tests/test_agents.py::TestRepairAgent::test_repair_success_first_iteration
```

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
