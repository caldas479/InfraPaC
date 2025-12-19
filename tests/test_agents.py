"""Tests for repair agents."""

from unittest.mock import MagicMock, Mock, patch

import pytest

from src.agents.repair_agent import RepairAgent
from src.models import PolicyViolation, RepairResult


class TestRepairAgent:
    """Tests for RepairAgent."""

    def test_initialization(
        self, sample_opa_config, sample_repair_config, sample_llm_config
    ):
        """Test RepairAgent initialization."""
        mock_engine = Mock()

        with patch("src.agents.repair_agent.RepairChain"):
            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            assert agent.pac_engine == mock_engine
            assert agent.max_iterations == 3
            assert agent.config == sample_repair_config

    def test_repair_success_first_iteration(
        self, sample_repair_config, sample_llm_config
    ):
        """Test successful repair on first iteration."""
        mock_engine = Mock()
        mock_engine.evaluate.return_value = []  # No violations after repair

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.return_value = "fixed code"
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            violations = [PolicyViolation(message="Test violation", severity="error")]

            result = agent.repair(
                policy="test policy", iac_script="buggy code", violations=violations
            )

            assert isinstance(result, RepairResult)
            assert result.success is True
            assert result.iterations == 1
            assert result.repaired_script == "fixed code"
            assert len(result.remaining_violations) == 0

    def test_repair_success_multiple_iterations(
        self, sample_repair_config, sample_llm_config
    ):
        """Test successful repair after multiple iterations."""
        mock_engine = Mock()
        # First iteration: still has violations
        # Second iteration: no violations
        mock_engine.evaluate.side_effect = [
            [PolicyViolation(message="Still broken", severity="error")],
            [],
        ]

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.side_effect = ["attempt 1", "attempt 2"]
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            violations = [PolicyViolation(message="Test violation", severity="error")]

            result = agent.repair(
                policy="test policy", iac_script="buggy code", violations=violations
            )

            assert result.success is True
            assert result.iterations == 2
            assert result.repaired_script == "attempt 2"

    def test_repair_failure_max_iterations(
        self, sample_repair_config, sample_llm_config
    ):
        """Test repair failure after max iterations."""
        mock_engine = Mock()
        # Always return violations
        remaining_violation = PolicyViolation(
            message="Persistent issue", severity="error"
        )
        mock_engine.evaluate.return_value = [remaining_violation]

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.return_value = "attempted fix"
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            violations = [PolicyViolation(message="Test violation", severity="error")]

            result = agent.repair(
                policy="test policy", iac_script="buggy code", violations=violations
            )

            assert result.success is False
            assert result.iterations == 3  # max_iterations
            assert result.repaired_script == "attempted fix"
            assert len(result.remaining_violations) == 1
            assert result.reason is not None
            assert "Failed to fix" in result.reason

    def test_repair_progress_tracking(self, sample_repair_config, sample_llm_config):
        """Test that repair tracks progress (reducing violations)."""
        mock_engine = Mock()
        # Gradually reduce violations
        mock_engine.evaluate.side_effect = [
            [
                PolicyViolation(message="Issue 1", severity="error"),
                PolicyViolation(message="Issue 2", severity="error"),
            ],
            [PolicyViolation(message="Issue 1", severity="error")],
            [],
        ]

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.side_effect = ["attempt 1", "attempt 2", "attempt 3"]
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            violations = [
                PolicyViolation(message="Issue 1", severity="error"),
                PolicyViolation(message="Issue 2", severity="error"),
                PolicyViolation(message="Issue 3", severity="error"),
            ]

            result = agent.repair(
                policy="test policy", iac_script="buggy code", violations=violations
            )

            assert result.success is True
            assert result.iterations == 3

    def test_repair_no_progress(self, sample_repair_config, sample_llm_config, caplog):
        """Test repair when no progress is made."""
        mock_engine = Mock()
        # Same violations every time
        persistent_violations = [
            PolicyViolation(message="Issue 1", severity="error"),
            PolicyViolation(message="Issue 2", severity="error"),
        ]
        mock_engine.evaluate.return_value = persistent_violations

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.return_value = "no real fix"
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            violations = [
                PolicyViolation(message="Issue 1", severity="error"),
                PolicyViolation(message="Issue 2", severity="error"),
            ]

            result = agent.repair(
                policy="test policy", iac_script="buggy code", violations=violations
            )

            assert result.success is False
            assert result.iterations == 3

    def test_repair_uses_updated_script(self, sample_repair_config, sample_llm_config):
        """Test that repair uses the updated script in subsequent iterations."""
        mock_engine = Mock()
        mock_engine.evaluate.side_effect = [
            [PolicyViolation(message="Issue", severity="error")],
            [],
        ]

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.side_effect = ["attempt 1", "attempt 2"]
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=sample_repair_config,
                llm_config=sample_llm_config,
            )

            violations = [PolicyViolation(message="Test", severity="error")]

            result = agent.repair(
                policy="test policy", iac_script="buggy code", violations=violations
            )

            # Check that second call used the updated script from first attempt
            assert mock_chain.repair.call_count == 2
            first_call = mock_chain.repair.call_args_list[0]
            second_call = mock_chain.repair.call_args_list[1]

            # First call should use original script
            assert first_call[1]["iac_script"] == "buggy code"
            # Second call should use the result from first attempt
            assert second_call[1]["iac_script"] == "attempt 1"

    def test_repair_custom_max_iterations(self, sample_llm_config):
        """Test repair with custom max iterations."""
        custom_config = {"max_iterations": 5}
        mock_engine = Mock()
        mock_engine.evaluate.return_value = [
            PolicyViolation(message="Issue", severity="error")
        ]

        with patch("src.agents.repair_agent.RepairChain") as mock_chain_class:
            mock_chain = Mock()
            mock_chain.repair.return_value = "fix"
            mock_chain_class.return_value = mock_chain

            agent = RepairAgent(
                pac_engine=mock_engine,
                config=custom_config,
                llm_config=sample_llm_config,
            )

            assert agent.max_iterations == 5

            violations = [PolicyViolation(message="Test", severity="error")]
            result = agent.repair("policy", "code", violations)

            assert result.iterations == 5
