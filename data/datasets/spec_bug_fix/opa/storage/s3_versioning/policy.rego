package terraform

# S3 buckets must have versioning enabled for data protection
deny contains msg if {
    bucket := input.resource.aws_s3_bucket[_]
    not bucket.versioning.enabled
    msg := sprintf("S3 bucket '%v' must have versioning enabled", [bucket.bucket])
}

deny contains msg if {
    bucket := input.resource.aws_s3_bucket[_]
    not bucket.versioning
    msg := sprintf("S3 bucket '%v' must have versioning configuration", [bucket.bucket])
}
