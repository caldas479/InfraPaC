package terraform

# S3 buckets should not allow public access
deny contains msg if {
    bucket := input.resource.aws_s3_bucket[_]
    bucket.acl == "public-read"
    msg := sprintf("S3 bucket '%v' has public-read ACL. This allows anyone to read bucket contents.", [bucket.bucket])
}

deny contains msg if {
    bucket := input.resource.aws_s3_bucket[_]
    bucket.acl == "public-read-write"
    msg := sprintf("S3 bucket '%v' has public-read-write ACL. This is extremely insecure.", [bucket.bucket])
}
