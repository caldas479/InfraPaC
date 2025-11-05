resource "aws_s3_bucket" "data_bucket" {
  bucket = "company-data-bucket-2024"

  tags = {
    Environment = "Production"
    Purpose     = "Data Storage"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
