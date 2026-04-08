resource "aws_cloudtrail" "positive1" {
  name                          = "positive"
  s3_bucket_name                = "bucketlog"
  enable_logging                = true
}
