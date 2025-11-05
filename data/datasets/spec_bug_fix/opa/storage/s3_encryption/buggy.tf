resource "aws_s3_bucket" "data_bucket" {
  bucket = "company-data-bucket-2024"

  tags = {
    Environment = "Production"
    Purpose     = "Data Storage"
  }
}
