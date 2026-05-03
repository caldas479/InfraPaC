from abc import ABC, abstractmethod
from typing import Any, Dict, List

from src.models import PolicyViolation


class BasePaCEngine(ABC):
    """
    Abstract base class for Policy as Code engines.

    All PaC engine implementations (OPA, KICS, Sentinel) should inherit from
    this class and implement the evaluate and validate methods.
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize the PaC engine.

        Args:
            config: Configuration dictionary for the engine.
        """
        self.config = config
        self.binary_path = config.get("binary_path")
        self.timeout = config.get("timeout", 30)

    @abstractmethod
    def evaluate(self, policy: str, iac_script: str) -> List[PolicyViolation]:
        """
        Evaluate an IaC script against a policy and return violations.

        Args:
            policy: Policy code (Rego, Sentinel, or other engine-specific format).
            iac_script: Infrastructure as Code script in any supported format
                        (HCL, YAML, JSON, etc.).

        Returns:
            List of PolicyViolation objects describing each detected violation.
        """
        pass

    @abstractmethod
    def validate(self, policy: str, iac_script: str) -> bool:
        """
        Check whether an IaC script complies with a policy.

        Args:
            policy: Policy code (Rego, Sentinel, or other engine-specific format).
            iac_script: Infrastructure as Code script in any supported format.

        Returns:
            True if the script is compliant (no violations), False otherwise.
        """
        pass

    def get_engine_name(self) -> str:
        """Get the name of the engine."""
        return self.__class__.__name__
