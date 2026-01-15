resource "aws_iam_user" "cosmic" {
	name = "cosmic"
}

resource "aws_iam_policy" "test_inline_policy" {
	name = "test_inline_policy"
	user = aws_iam_user.cosmic.name

	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["iam:SetDefaultPolicyVersion",]
			Effect   = "Deny"
			Resource = "*"
