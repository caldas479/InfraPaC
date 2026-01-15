resource "aws_kms_key" "positive1" {
	description = "KMS key 1"
	deletion_window_in_days = 10
	policy = jsonencode({
		"Version": "2012-10-17",
		"Statement": [
		{
			"Sid": "AddCannedAcl",
			"Effect": "Allow",
			"Principal": {"AWS": "arn:aws:iam::123456789012:root"},
			"Action": ["kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey*"],
			"Resource": "*"
		}
	]
})
}
