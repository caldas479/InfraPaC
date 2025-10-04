# InfraPaC: Automated Infrastructure as Code Repair via Policy as Code

This project aims to automatically repair Infrastructure as Code (IaC) configurations that violate policy requirements, using Large Language Models (LLMs) and Policy as Code (PaC) engines.

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
python main.py --policy examples/s3_versioning.rego --iac examples/s3_bucket.tf --verbose
```

The tool will:
- Detect the missing versioning configuration
- Generate a fix using the LLM
- Validate the fix against the policy
- Output the repaired configuration

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