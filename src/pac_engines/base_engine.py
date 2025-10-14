from abc import ABC, abstractmethod
from typing import Any, Dict, List


class BasePaCEngine(ABC):
    """
    Abstract base class for Policy as Code engines.

    All PaC engine implementations (OPA, Sentinel) should inherit from this class.
    """

    def __init__(self, config: Dict[str, Any]) -> None:
        """
        Initialize the PaC engine.

        Args:
            config: Configuration dictionary for the engine
        """
        self.config = config
        self.binary_path = config.get("binary_path")
        self.timeout = config.get("timeout", 30)

    @abstractmethod
    def evaluate(self, policy: str, iac_script: str) -> List[Dict[str, Any]]:
        """
        Evaluate IaC script against policy and return violations.

        Args:
            policy: Policy code (Rego or Sentinel)
            iac_script: Infrastructure as Code script (e.g., Terraform)

        Returns:
            List of violation dictionaries with structure:
            {
                "message": str,
                "severity": str,
                "line": int (optional),
                "resource": str (optional),
                "details": Dict[str, Any] (optional)
            }
        """
        pass

    @abstractmethod
    def validate(self, policy: str, iac_script: str) -> bool:
        """
        Validate if IaC script complies with policy.

        Args:
            policy: Policy code
            iac_script: Infrastructure as Code script

        Returns:
            True if compliant, False otherwise
        """
        pass

    def get_engine_name(self) -> str:
        """Get the name of the engine."""
        return self.__class__.__name__
