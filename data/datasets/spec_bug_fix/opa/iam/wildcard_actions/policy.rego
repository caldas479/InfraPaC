package terraform

# IAM policies should not use wildcard actions on all resources
deny contains msg if {
    policy := input.resource.aws_iam_role_policy[_]
    # Check if policy contains wildcard action and resource
    contains(policy.policy, "\"Action\"")
    contains(policy.policy, "\"*\"")
    contains(policy.policy, "\"Resource\"")
    msg := sprintf("IAM role policy '%v' uses wildcard action (*) on all resources (*). This is overly permissive.", [policy.name])
}
