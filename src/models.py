from typing import List, Optional

from pydantic import BaseModel, Field


class PolicyViolation(BaseModel):
    """Model for a policy violation."""

    message: str = Field(..., description="Violation message")
    severity: str = Field(default="error", description="Violation severity")
    line: Optional[int] = Field(None, description="Line number in IaC script")
    resource: Optional[str] = Field(None, description="Affected resource")
    details: Optional[dict] = Field(None, description="Additional violation details")


class RepairResult(BaseModel):
    """Model for a repair attempt result."""

    success: bool = Field(..., description="Whether repair was successful")
    iterations: int = Field(..., description="Number of iterations used")
    repaired_script: Optional[str] = Field(None, description="Repaired IaC script")
    remaining_violations: List[PolicyViolation] = Field(
        default_factory=list, description="Violations remaining after repair"
    )
    reason: Optional[str] = Field(None, description="Failure reason if not successful")
    metadata: Optional[dict] = Field(None, description="Additional metadata")


class RepairOutput(BaseModel):
    """Model for structured LLM repair output."""

    repaired_script: str = Field(
        ...,
        description="The corrected Terraform script that fixes all policy violations",
    )
