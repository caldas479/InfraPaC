resource "aws_secretsmanager_secret" "example" {
  name = "example"
  kms_key_id = "your-kms-key-id"
}
