resource "aws_iam_policy" "s3-permission" {
	name = "s3-permission"
	policy = jsonencode({
		"Version": "2012-10-17",
		"Statement": [
		{
			"Action": ["s3:*"],
			"Effect": "Allow",
			"Resource": "arn:aws:s3:::*"
		}
	]
})
}
