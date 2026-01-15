resource "aws_iam_role" "cosmic" {
	name = "cosmic"
}

resource "aws_iam_policy" "test-policy" {
	name = "test-policy"
	description = "A test policy"

	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
		{
			Action = ["iam:PassRole"]
			Effect   = "Allow"
			Resource = "*"
		}
		]
	})
}

resource "aws_iam_policy_attachment" "test-attach" {
	name       = "test-attachment"
	roles      = [aws_iam_role.cosmic.name]
	policy_arn = aws_iam_policy.policy.arn
}
