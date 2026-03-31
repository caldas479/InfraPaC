resource "aws_sns_topic" "positive1" {
	policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": "*",
"Principal": {
  "AWS": "arn:aws:iam::${var.account_id}:root"
},
"Effect": "Allow",
"Sid": ""
}
]
}
EOF
}
