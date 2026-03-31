resource "aws_s3_bucket" "hoge" {
 bucket = "hoge"
 }

 resource "aws_athena_database" "hoge" {
 name   = "database_name"
 encryption_configuration {
 kms_key_arn = aws_kms_key.hoge.arn
 }
 bucket = aws_s3_bucket.hoge.bucket
 }

 resource "aws_kms_key" "hoge" {
 description = "KMS key for Athena database encryption"
 enable_key_rotation = true
 policy = jsonencode({
 "Version": "2012-10-17",
 "Id": "kms-tf-test",
 "Statement": [{
 "Sid": "Enable IAM User Permissions",
 "Effect": "Allow",
 "Principal": {"AWS": "arn:aws:iam::123456789012:root"},
 "Action": "kms:*",
 "Resource": "*"
 }]
 })
 tags = {
 "Name": "tf-test-key"
 }
 })
