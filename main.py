"""
Main entry point for the IaC Automated Repair Framework.

This script orchestrates the end-to-end workflow:
1. Load policy and IaC script
2. Detect violations
3. Generate repair suggestions via LLM
4. Validate repairs with PaC engine
5. Iterate until compliance or max retries
"""

import argparse
import sys
from pathlib import Path

from src.agents.repair_agent import RepairAgent
from src.pac_engines.opa_engine import OPAEngine
from src.pac_engines.sentinel_engine import SentinelEngine
from src.utils.config_loader import load_config
from src.utils.env_loader import load_environment
from src.utils.llm_validator import LLMValidationError, validate_llm_config
from src.utils.logging_config import setup_logging


def parse_arguments() -> argparse.Namespace:
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description="Automated IaC Repair via Policy as Code"
    )
    parser.add_argument(
        "--config",
        type=str,
        default="src/config/default_config.yaml",
        help="Path to configuration file",
    )
    parser.add_argument(
        "--policy",
        type=str,
        help="Path to policy file (Rego or Sentinel)",
    )
    parser.add_argument(
        "--iac",
        type=str,
        help="Path to IaC script (Terraform)",
    )
    parser.add_argument(
        "--policy-engine",
        type=str,
        choices=["opa", "sentinel"],
        default="opa",
        help="Policy engine to use",
    )
    parser.add_argument(
        "--llm-provider",
        type=str,
        choices=["ollama", "openai"],
        help="Override LLM provider (ollama, openai)",
    )
    parser.add_argument(
        "--llm-model",
        type=str,
        help="Override LLM model (e.g., codellama, gpt-4)",
    )
    parser.add_argument(
        "--max-iterations",
        type=int,
        default=3,
        help="Maximum repair iterations",
    )
    parser.add_argument(
        "--output",
        type=str,
        help="Path to save repaired IaC script",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Enable verbose logging",
    )
    return parser.parse_args()


def main() -> int:
    """Main execution function."""
    # Parse arguments
    args = parse_arguments()

    # Setup logging
    log_level = "DEBUG" if args.verbose else "INFO"
    logger = setup_logging(level=log_level)

    logger.info("Starting IaC Automated Repair Framework")

    try:
        # Load environment variables
        load_environment()

        # Load configuration
        config = load_config(args.config)
        logger.info(f"Loaded configuration from {args.config}")

        # Override config with CLI arguments
        if args.max_iterations:
            config["repair"]["max_iterations"] = args.max_iterations
            logger.info(f"Overriding max iterations: {args.max_iterations}")

        if args.llm_provider:
            config["llm"]["provider"] = args.llm_provider
            logger.info(f"Overriding LLM provider: {args.llm_provider}")

        if args.llm_model:
            config["llm"]["model"] = args.llm_model
            logger.info(f"Overriding LLM model: {args.llm_model}")

        # Validate LLM configuration
        try:
            provider = config["llm"]["provider"]
            model = config["llm"]["model"]
            validate_llm_config(provider, model)
            logger.info(f"LLM configuration validated: {provider}/{model}")
        except LLMValidationError as e:
            logger.error(f"Invalid LLM configuration: {e}")
            return 1

        # Initialize policy engine
        logger.info(f"Initializing {args.policy_engine.upper()} engine")
        if args.policy_engine == "opa":
            pac_engine = OPAEngine(config=config.get("opa", {}))
        else:
            pac_engine = SentinelEngine(config=config.get("sentinel", {}))

        # Load policy and IaC script
        policy_path = Path(args.policy) if args.policy else None
        iac_path = Path(args.iac) if args.iac else None

        if not policy_path or not iac_path:
            logger.error("Both --policy and --iac arguments are required")
            return 1

        if not policy_path.exists():
            logger.error(f"Policy file not found: {policy_path}")
            return 1

        if not iac_path.exists():
            logger.error(f"IaC script not found: {iac_path}")
            return 1

        logger.info(f"Loading policy from {policy_path}")
        policy_content = policy_path.read_text()

        logger.info(f"Loading IaC script from {iac_path}")
        iac_content = iac_path.read_text()

        # Detect violations
        logger.info("Detecting policy violations...")
        violations = pac_engine.evaluate(policy_content, iac_content)

        if not violations:
            logger.info("✓ No policy violations detected. IaC script is compliant.")
            return 0

        logger.warning(f"✗ Found {len(violations)} policy violation(s)")
        for idx, violation in enumerate(violations, 1):
            logger.warning(f"  {idx}. {violation.message}")

        # Initialize repair agent
        logger.info("Initializing repair agent")
        repair_agent = RepairAgent(
            pac_engine=pac_engine,
            config=config.get("repair", {}),
            llm_config=config.get("llm", {}),
        )

        # Repair workflow
        logger.info("Starting repair workflow...")
        result = repair_agent.repair(
            policy=policy_content,
            iac_script=iac_content,
            violations=violations,
        )

        # Output results
        if result.success:
            logger.info(
                f"✓ Successfully repaired IaC script in {result.iterations} iteration(s)"
            )

            # Save repaired script
            if args.output:
                output_path = Path(args.output)
                output_path.write_text(result.repaired_script)
                logger.info(f"Saved repaired script to {output_path}")
            else:
                logger.info("Repaired script:")
                logger.info(f"{'-' * 80}\n{result.repaired_script}")
                logger.info("-" * 80)

            return 0
        else:
            logger.error(
                f"✗ Failed to repair IaC script after {result.iterations} iteration(s)"
            )
            logger.error(f"Reason: {result.reason or 'Unknown'}")
            return 1

    except KeyboardInterrupt:
        logger.warning("Operation cancelled by user")
        return 130
    except Exception as e:
        logger.exception(f"Unexpected error: {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
