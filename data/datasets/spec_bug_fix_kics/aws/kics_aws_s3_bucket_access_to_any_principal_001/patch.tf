resource "aws_s3_bucket_policy" "positive1" {
 bucket = aws_s3_bucket.b.id

 policy = <<POLICY
 {
 "Version": "2012-10-17",
 "Id": "MYBUCKETPOLICY",
 "Statement": [
 {
 "Sid": "IPAllow",
 "Effect": "Allow",
 "Principal": {
 "AWS": "${aws_iam_user.test_user.arn}"
 },
 "Action": "s3:*",
 "Resource": "arn:aws:s3:::my_tf_test_bucket/*",
 "Condition": {
  "IpAddress": {
 "aws:SourceIp": "8.8.8.8/32"
 }
 }
 }
 ]
}
POLICY
}
