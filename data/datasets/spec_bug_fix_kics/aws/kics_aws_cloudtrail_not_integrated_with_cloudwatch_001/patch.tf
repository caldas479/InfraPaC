resource "aws_cloudtrail" "positive1" {
 name = "tf-trail-foobar"
 s3_bucket_name = aws_s3_bucket.foo.id
 s3_key_prefix = "prefix"
 include_global_service_events = false
 cloud_watch_logs_role_arn = aws_iam_role.cloudtrail-role.arn
 cloud_watch_logs_group_arn = aws_cloudwatch_log_group.tf-test-trail.arn
}

resource "aws_s3_bucket" "positive4" {
 bucket = "tf-test-trail"
 force_destroy = true
 policy = <<POLICY
 {
 "Version": "2012-10-17",
 "Statement": [
 {
 "Sid": "AWSCloudTrailAclCheck",
 "Effect": "Allow",
 "Principal": {
 "Service": "cloudtrail.amazonaws.com"
 },
 "Action": "s3:GetBucketAcl",
 "Resource": "arn:aws:s3:::tf-test-trail"
 },
 {
 "Sid": "AWSCloudTrailWrite",
 "Effect": "Allow",
 "Principal": {
 "Service": "cloudtrail.amazonaws.com"
 },
 "Action": "s3:PutObject",
 "Resource": "arn:aws:s3:::tf-test-trail/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
 "Condition": {
 "StringEquals": {
 "s3:x-amz-acl": "bucket-owner-full-control"
 }
 }
 }
 ]
}
POLICY
}

resource "aws_cloudwatch_log_group" "tf-test-trail" {
 name = "tf-test-trail"
 retention_in_days = 30
}

resource "aws_iam_role" "cloudtrail-role" {
 name = "cloudtrail-role"
 assume_role_policy = <<EOF
 {
 "Version": "2012-10-17",
 "Statement": [
 {
 "Sid": "",
 "Effect": "Allow",
 "Principal": {
 "Service": "cloudtrail.amazonaws.com"
 },
 "Action": "sts:AssumeRole"
}
]
}
EOF
}
