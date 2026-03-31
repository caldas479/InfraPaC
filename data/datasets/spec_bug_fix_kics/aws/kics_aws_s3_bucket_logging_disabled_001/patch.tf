provider "aws" { region = "us-east-1" }

t terraform {
 required_providers {
 aws = { source = "hashicorp/aws", version = "~> 3.0" } }
 }

 resource "aws_s3_bucket" "positive1" { bucket = "my-tf-test-bucket" acl = "private"
 tags = { Name = "My bucket", Environment = "Dev" }
 versioning { mfa_delete = true }
 logging { target_bucket = aws_s3_bucket.log_bucket }
}

 resource "aws_s3_bucket" "log_bucket" { bucket = "my-tf-test-log-bucket" acl = "private"
 tags = { Name = "My log bucket", Environment = "Dev" }
 versioning { mfa_delete = true }
}
