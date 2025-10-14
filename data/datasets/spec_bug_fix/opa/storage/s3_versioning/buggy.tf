resource "aws_s3_bucket" "backup_bucket" {
  bucket = "company-backup-bucket"
  acl    = "private"

  tags = {
    Environment = "Production"
    Purpose     = "Backups"
  }
}
