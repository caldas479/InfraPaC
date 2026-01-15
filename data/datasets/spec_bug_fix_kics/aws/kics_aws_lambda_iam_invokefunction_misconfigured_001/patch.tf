resource "aws_iam_policy" "positive1policy" {
	name = "positive1policy"
	path = "/"
	description = "Positive1 Policy"

	# Terraform's "jsonencode" function converts a
	# Terraform expression result to valid JSON syntax.
	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
		{
			action = ["lambda:InvokeFunction", "lambda:*"],
		effect   = "Allow",
		resource = ["arn:aws:lambda:*:*:function:positive1*", "arn:aws:lambda:*:*:function:positive1*:*"],
		},
	]
	})
}
