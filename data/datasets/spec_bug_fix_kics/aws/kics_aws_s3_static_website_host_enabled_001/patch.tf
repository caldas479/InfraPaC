provider "aws" { region = "us-east-1" }

resource "aws_s3_bucket" "positive1" { bucket = "s3-website-test.hashicorp.com" acl = "public-read" }
