resource "aws_iam_group" "cosmic" {
	name = "cosmic"
}

resource "aws_iam_policy" "policy" {
	name = "test-policy"
	description = "A test policy"

	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [{
			Action = ["iam:PassRole", ]
			Effect   = "Allow"
			Resource = "*"
		},
		{
			Action = ["cloudformation:CreateStack", ]
			Effect   = "Deny"
			Resource = "*"
		}
	]
	})
}

resource "aws_iam_policy_attachment" "test-attach" {
	name       = "test-attachment"
	groups     = [aws_iam_group.cosmic.name]
	policy_arn = aws_iam_policy.policy.arn
}
