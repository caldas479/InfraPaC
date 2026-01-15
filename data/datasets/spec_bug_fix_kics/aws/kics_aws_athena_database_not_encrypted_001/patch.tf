resource "aws_s3_bucket" "hoge" {
 bucket = "hoge"
}

resource "aws_athena_database" "hoge" {
 name = "database_name"
 encryption_configuration {
 kms_key_arn = aws_kms_key.hoge.arn
}
 bucket = aws_s3_bucket.hoge.bucket
}
