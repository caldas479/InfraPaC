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

    Runs an iterative detect-repair-validate loop: given a policy and a
    violating IaC script, it calls the LLM to generate a fix, re-evaluates
    the result with the Policy as Code engine, and repeats until no violations
    remain or the maximum number of iterations is exhausted.
    """

    def __init__(
        self,
        pac_engine: BasePaCEngine,
        config: Dict[str, Any],
        llm_config: Dict[str, Any],
    ) -> None:
        """
        Initialize the repair agent.

        Args:
            pac_engine: Policy as Code engine used for violation detection
                        and compliance validation.
            config: Repair configuration. Recognised key: max_iterations (int,
                    default 3).
            llm_config: LLM configuration passed through to RepairChain.
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
        Execute the iterative repair workflow.

        For each iteration, the LLM generates a candidate fix from the current
        script and violations, the PaC engine validates the candidate, and the
        loop continues until no violations remain or max_iterations is reached.

        Args:
            policy: Policy code used for validation.
            iac_script: Original IaC script containing violations.
            violations: Initial list of violations detected before repair.

        Returns:
            RepairResult with success status, iteration count, the final
            (possibly still violating) script, and any remaining violations.
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
