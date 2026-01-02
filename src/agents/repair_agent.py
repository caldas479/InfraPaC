# ============================================================================
# src/agents/repair_agent.py
# ============================================================================

import logging
from typing import Any, Dict, List

from src.chains.repair_chain import RepairChain
from src.models import PolicyViolation, RepairResult
from src.pac_engines.base_engine import BasePaCEngine

logger = logging.getLogger(__name__)


class RepairAgent:
    """
    Agent that orchestrates the IaC repair workflow.

    Coordinates between LLM-based repair and policy validation.
    """

    def __init__(
        self,
        pac_engine: BasePaCEngine,
        config: Dict[str, Any],
        llm_config: Dict[str, Any],
    ) -> None:
        """
        Initialize repair agent.

        Args:
            pac_engine: Policy as Code engine
            config: Repair configuration
            llm_config: LLM configuration
        """
        self.pac_engine = pac_engine
        self.config = config
        self.max_iterations = config.get("max_iterations", 3)
        self.repair_chain = RepairChain(llm_config)

    def repair(
        self,
        policy: str,
        iac_script: str,
        violations: List[PolicyViolation],
    ) -> RepairResult:
        """
        Execute repair workflow.

        Args:
            policy: Policy code
            iac_script: Original IaC script
            violations: Initial violations

        Returns:
            RepairResult object with repair script and success status
        """
        current_script = iac_script
        current_violations = violations

        for iteration in range(1, self.max_iterations + 1):
            logger.info(f"Repair iteration {iteration}/{self.max_iterations}")

            # Generate iac repair based on current script and policy violations
            logger.debug("Generating repair with LLM...")
            repaired_script = self.repair_chain.repair(
                policy=policy,
                iac_script=current_script,
                violations=current_violations,
            )

            # Validate repair
            logger.debug("Validating repaired script...")
            new_violations = self.pac_engine.evaluate(policy, repaired_script)

            if not new_violations:
                # Success!
                logger.info(f"✓ Repair successful in {iteration} iteration(s)")
                return RepairResult(
                    success=True,
                    iterations=iteration,
                    repaired_script=repaired_script,
                    remaining_violations=[],
                )

            # Check if we made progress
            if len(new_violations) < len(current_violations):
                logger.info(
                    f"Progress: {len(current_violations)} → {len(new_violations)} violations"
                )
            else:
                logger.warning(f"No progress: still {len(new_violations)} violation(s)")

            # Update for next iteration
            current_script = repaired_script
            current_violations = new_violations

            # TODO :
            # Call reflection chain here to update prompt
            # reflection = self.reflection_chain.reflect(policy, repaired_script, violations)
            # build new prompt based on the last prompt and new reflection
            # prompt = self.prompt_builder.evolve_prompt(prompt, reflection)

        # Failed to fix all violations
        logger.warning(
            f"✗ Failed to fix all violations after {self.max_iterations} iterations"
        )
        return RepairResult(
            success=False,
            iterations=self.max_iterations,
            repaired_script=current_script,
            remaining_violations=current_violations,
            reason=f"Failed to fix {len(current_violations)} violation(s) after {self.max_iterations} iterations",
        )
