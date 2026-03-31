provider "aws" {
  region = "us-east-1"
}

training {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_s3_bucket" "my-tf-test-bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "positive2" {
  bucket = aws_s3_bucket.my-tf-test-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
