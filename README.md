# InfraPaC: Automated Infrastructure as Code Repair via Policy as Code

InfraPaC is an automated Infrastructure as Code (IaC) repair framework that uses Large Language Models to fix policy violations in IaC configurations. The system detects violations using Policy as Code engines (OPA/Sentinel), generates fixes via LLMs, and iteratively validates repairs until compliance is achieved.

## Overview

InfraPaC is a framework that:

1. Detects policy violations in IaC scripts using Policy as Code engines (OPA/Sentinel)
2. Automatically generates fixes using LLMs
3. Validates the repairs to ensure policy compliance
4. Iterates until all violations are resolved or max retries are reached

## Features

- 🔍 Policy Violation Detection using Open Policy Agent (OPA)
- 🤖 LLM-based Repair Generation (supports OpenAI, Ollama models)
- ✅ Automated Fix Validation
- 🔄 Iterative Repair Process
- 📊 Evaluation Metrics (Fix Rate, Retry Rate)
- 🎯 Modular Design for Multiple PaC Engines

## Prerequisites

- Python 3.12+
- Open Policy Agent (OPA) CLI
- Ollama (for local LLMs) or OpenAI API key

## Installation

1. Clone the repository:

```bash
git clone https://github.com/caldas479/InfraPaC.git
cd InfraPaC
```

2. Create and activate a Python virtual environment:

```bash
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
# or
.venv\\Scripts\\activate  # Windows
```

3. Install dependencies:

```bash
pip install -e .
```

4. Install OPA:

**macOS (Homebrew - Recommended):**
```bash
brew install opa
```

**Linux:**
```bash
curl -L -o opa https://openpolicyagent.org/downloads/v0.57.1/opa_linux_amd64_static
chmod 755 opa
sudo mv opa /usr/local/bin
```


5. Install and start Ollama (optional, for local LLMs):

```bash
# Install Ollama
curl https://ollama.ai/install.sh | sh
# Start Ollama service
ollama serve
# Pull the CodeLlama model
ollama pull codellama
```

## Usage

Basic example repairing an S3 bucket configuration to enable versioning:

1. Create a policy file (e.g., `s3_versioning.rego`):

```rego
package terraform

deny[msg] {
    resource := input.resource.aws_s3_bucket[_]
    not resource.versioning.enabled
    msg := sprintf("S3 bucket '%v' must have versioning enabled", [resource.bucket])
}
```

2. Create a Terraform configuration (e.g., `s3_bucket.tf`):

```hcl
resource "aws_s3_bucket" "example" {
    bucket = "my-example-bucket"
    # Versioning is not enabled, violating the policy
}
```

3. Run the repair tool:

```bash
uv run python main.py --policy examples/s3_versioning.rego --iac examples/s3_bucket.tf --verbose
```

The tool will:

- Detect the missing versioning configuration
- Generate a fix using the LLM
- Validate the fix against the policy
- Output the repaired configuration

## Dataset Management

### Generate Patches

Generate patches for dataset entries using the repair framework:

```bash
# Generate patches for all entries
uv run python generate_patches.py

# Generate patch for a specific entry
uv run python generate_patches.py --entry-id opa_storage_001

# Generate patches for a specific category (iam, storage, compute, etc.)
uv run python generate_patches.py --category storage

# Skip entries that already have patches
uv run python generate_patches.py --skip-existing

# Enable verbose logging
uv run python generate_patches.py --verbose

# Combine options
uv run python generate_patches.py --category iam --verbose
```

The patch generator:
1. Loads each dataset entry
2. Uses the repair agent to fix the buggy code
3. Validates the fix against the policy
4. Saves the repaired code to `patch.tf`

### Experiment Logs

All experiment runs are automatically logged to the `results/` directory with the following structure:

```
results/
└── dataset-name/
    └── model-name/
        ├── execution_YYYYMMDD_HHMMSS.log
        ├── execution_YYYYMMDD_HHMMSS.log
        └── ...
```

For example, when running `generate_patches.py`:
- Dataset name is extracted from `dataset_index.json` (e.g., "spec_bug_fix")
- Model name is extracted from the config file (e.g., "codellama", "gpt-4")
- Logs are saved to: `results/spec_bug_fix/codellama/execution_20251203_143022.log`

This makes it easy to:
- Track different experiment runs
- Compare results across models
- Organize logs by dataset
- Keep historical records of all executions

## Configuration

The framework can be configured via:

- Command line arguments
- Configuration file (`src/config/default_config.yaml`)
- Environment variables

Key configuration options:

- LLM provider and settings
- Policy engine settings
- Maximum repair iterations
- Logging level and format

## Project Structure

```
infrapac/
├── src/
│   ├── agents/        # LangChain agents for repair
│   ├── chains/        # Chain logic and prompts
│   ├── pac_engines/   # OPA/Sentinel wrappers
│   ├── datasets/      # Dataset handling
│   ├── utils/         # Helpers and config
│   └── config/        # YAML configurations
├── tests/             # Pytest test suite
├── notebooks/         # Analysis notebooks
├── experiments/       # Evaluation scripts
└── examples/          # Example policies & IaC
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under MIT - see the LICENSE file for details.
