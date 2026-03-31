module "s3_bucket" {
 source = "terraform-aws-modules/s3-bucket/aws"
 version = "3.7.0"

 bucket = "my-s3-bucket"
 acl = "private"

 logging {
 target_bucket = "my-log-bucket"
 target_prefix = "logs/"
 }

 versioning {
 enabled = true
 }
 }
