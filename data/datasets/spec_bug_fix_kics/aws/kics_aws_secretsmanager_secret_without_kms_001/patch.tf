resource "aws_secretsmanager_secret" "example" {
  name = "example"
  kms_key_id = "my-kms-key"
}
