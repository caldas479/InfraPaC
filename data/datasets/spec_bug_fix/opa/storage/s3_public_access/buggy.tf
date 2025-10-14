resource "aws_s3_bucket" "website_assets" {
  bucket = "company-website-assets"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Environment = "Production"
    Purpose     = "Static Website"
  }
}
