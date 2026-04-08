resource "aws_cloudtrail" "positive1" {
	name = "npositive_1"
	s3_bucket_name = "bucketlog_1"
	kms_key_id = aws_kms_key.example.arn
}

resource "aws_kms_key" "example" {
	name = "my-key"
	deletion_window_in_days = 7
}
