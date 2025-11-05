from typing import List, Optional

from pydantic import BaseModel, Field

class PolicyViolation(BaseModel):
    """Model for a policy violation."""

    message: str = Field(..., description="Violation message")
    severity: str = Field(default="error", description="Violation severity")
    line: Optional[int] = Field(None, description="Line number in IaC script")
    resource: Optional[str] = Field(None, description="Affected resource")
    details: Optional[dict] = Field(None, description="Additional violation details")


class IaCScript(BaseModel):
    """Model for an Infrastructure as Code script."""

    content: str = Field(..., description="IaC script content")
    language: str = Field(default="", description="IaC language")
    path: Optional[str] = Field(None, description="File path")


class Policy(BaseModel):
    """Model for a policy."""

    content: str = Field(..., description="Policy code")
    engine: str = Field(..., description="Policy engine")
    path: Optional[str] = Field(None, description="File path")


class DatasetEntry(BaseModel):
    """
    Model for a Spec-Bug-Fix dataset entry.

    Represents a single example with:
    - Policy specification
    - Buggy (violating) IaC script
    - Fixed (compliant) IaC script
    """

    id: str = Field(..., description="Unique identifier")
    policy: Policy = Field(..., description="Policy specification")
    buggy_script: IaCScript = Field(..., description="Buggy IaC script")
    fixed_script: IaCScript = Field(..., description="Fixed IaC script")
    violations: List[PolicyViolation] = Field(
        default_factory=list, description="Known violations in buggy script"
    )
    metadata: Optional[dict] = Field(None, description="Additional metadata")


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


class LLMResponse(BaseModel):
    """Model for LLM response."""

    repaired_script: str = Field(..., description="Suggested repaired script")
    explanation: Optional[str] = Field(None, description="Explanation of changes")
    confidence: Optional[float] = Field(None, description="Confidence score (0-1)")
