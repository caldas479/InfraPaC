resource "aws_efs_file_system" "positive1" {
	creation_token = "my-product"
	encrypted = true

	tags = {
		Name = "MyProduct"
	}

	kms_key_id = aws_kms_key.positive1.arn
}

resource "aws_kms_key" "positive1" {
	encryption_algorithm = "AES_256"
}
