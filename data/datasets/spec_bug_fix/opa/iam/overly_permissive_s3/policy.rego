package terraform

# IAM policies should not allow full S3 access (s3:*)
deny contains msg if {
    policy := input.resource.aws_iam_policy[_]
    # Check if policy contains s3:* action (as a string in the HCL)
    contains(policy.policy, "s3:*")
    msg := sprintf("IAM policy '%v' grants overly permissive S3 access (s3:*). Use specific actions instead.", [policy.name])
}
