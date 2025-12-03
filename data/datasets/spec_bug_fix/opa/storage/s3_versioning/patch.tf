resource "aws_s3_bucket" "backup_bucket" {
  bucket = "company-backup-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "Production"
    Purpose     = "Backups"
  }
}
