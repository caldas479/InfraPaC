resource "aws_kms_key" "positive1" {
	description = "KMS key 1"
	enable_key_rotation = true
}
