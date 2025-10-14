package terraform

# S3 buckets must have server-side encryption enabled
deny contains msg if {
    bucket := input.resource.aws_s3_bucket[_]
    not bucket.server_side_encryption_configuration
    msg := sprintf("S3 bucket '%v' must have server-side encryption enabled", [bucket.bucket])
}
