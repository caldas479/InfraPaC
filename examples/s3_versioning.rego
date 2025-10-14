package terraform

deny contains msg if {
    resource := input.resource.aws_s3_bucket[_]
    not resource.versioning.enabled
    msg := sprintf("S3 bucket '%v' must have versioning enabled", [resource.bucket])
}
