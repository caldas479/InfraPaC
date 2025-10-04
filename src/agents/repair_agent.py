# ============================================================================
# src/agents/repair_agent.py
# ============================================================================

import logging
from typing import Any, Dict, List

from ..chains.repair_chain import RepairChain
from ..datasets.models import RepairResult
from ..pac_engines.base_engine import BasePaCEngine


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
        self.logger = logging.getLogger(__name__)
    
    def repair(
        self,
        policy: str,
        iac_script: str,
        violations: List[Dict[str, Any]],
    ) -> Dict[str, Any]:
        """
        Execute repair workflow.
        
        Args:
            policy: Policy code
            iac_script: Original IaC script
            violations: Initial violations
        
        Returns:
            RepairResult dictionary
        """
        current_script = iac_script
        current_violations = violations
        previous_attempt = None
        
        for iteration in range(1, self.max_iterations + 1):
            self.logger.info(f"Repair iteration {iteration}/{self.max_iterations}")
            
            # Generate repair
            self.logger.debug("Generating repair with LLM...")
            repaired_script = self.repair_chain.repair(
                policy=policy,
                iac_script=current_script,
                violations=current_violations,
                iteration=iteration,
                previous_attempt=previous_attempt,
            )
            
            # Validate repair
            self.logger.debug("Validating repaired script...")
            new_violations = self.pac_engine.evaluate(policy, repaired_script)
            
            if not new_violations:
                # Success!
                self.logger.info(f"✓ Repair successful in {iteration} iteration(s)")
                return {
                    "success": True,
                    "iterations": iteration,
                    "repaired_script": repaired_script,
                    "remaining_violations": [],
                }
            
            # Check if we made progress
            if len(new_violations) < len(current_violations):
                self.logger.info(
                    f"Progress: {len(current_violations)} → {len(new_violations)} violations"
                )
            else:
                self.logger.warning(
                    f"No progress: still {len(new_violations)} violation(s)"
                )
            
            # Update for next iteration
            current_script = repaired_script
            current_violations = new_violations
            previous_attempt = repaired_script
        
        # Failed to fix all violations
        self.logger.warning(
            f"✗ Failed to fix all violations after {self.max_iterations} iterations"
        )
        return {
            "success": False,
            "iterations": self.max_iterations,
            "repaired_script": current_script,
            "remaining_violations": current_violations,
        }
