resource "aws_s3_bucket" "example" {
  bucket = "my-secure-bucket"

  versioning {
    enabled = true
  }

  # Missing server_side_encryption_configuration
}
