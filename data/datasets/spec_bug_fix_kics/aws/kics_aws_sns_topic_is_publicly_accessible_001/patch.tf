resource "aws_sns_topic" "positive1" {
	policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": "*",
"Principal": { "AWS": ["arn:aws:iam::123456789012:root"] },
"Effect": "Allow",
"Sid": ""
}
]
}
EOF
}
