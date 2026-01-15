resource "aws_efs_file_system" "positive1" {
	creation_token = "my-product"
	encrypted = true

	tags = {
		Name = "MyProduct"
	}

	kms_key_id = aws_kms_key.efs_encryption_key.arn
}

resource "aws_kms_key" "efs_encryption_key" {
	description = "EFS encryption key"
	enabled = true

	policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "kms-tf-20190918",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {"AWS": "arn:aws:iam::123456789012:root"},
      "Action": "*",
      "Resource": "*"
    }
  ]
}
POLICY
}
