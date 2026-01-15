provider "aws" { region = "us-east-1" }

 resource "aws_secretsmanager_secret" "test" { name = "test-cloudrail-1" kms_key_id = "alias/aws/secretsmanager" }
