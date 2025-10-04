resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"
  # Versioning is not enabled, which violates our policy
}
