provider "aws" { region = "us-east-1" }

data "aws_kms_key" "by_alias" { key_id = "alias/aws/s3" }

# No policy attached to this role because it is for testing purposes
resource "aws_iam_role" "codebuild" { name = "codebuild-cloudrail-test"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_codebuild_project" "project-cloudrail-test" { name = "project-cloudrail-test" description = "project-cloudrail-test" build_timeout = "5" queued_timeout = "5" service_role = aws_iam_role.codebuild.arn

environment {
  compute_type = "BUILD_GENERAL1_SMALL"
  image = "aws/codebuild/standard:1.0"
  type = "LINUX_CONTAINER"
  image_pull_credentials_type = "CODEBUILD"

environment_variable {
  name = "SOME_KEY1"
  value = "SOME_VALUE1"
}
}

source {
  type = "GITHUB"
  location = "https://github.com/foo/bar.git"
  git_clone_depth = 1
}

# Use the KMS key that is not managed by AWS
encryption_key = data.aws_kms_key.by_alias.arn

# Artifacts are stored in S3, so we need to allow access to the bucket
artifacts {
  type = "S3"
  location = aws_s3_bucket.codebuild-project-cloudrail-test.id
}

# Cache is stored locally, so we need to allow access to the cache directory
cache {
  type = "LOCAL"
  modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
}

# Allow CodeBuild to use the KMS key for encryption
resource "aws_kms_key" "codebuild-project-cloudrail-test" { name = "codebuild-project-cloudrail-test" description = "KMS key used by CodeBuild project" policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "kms:Decrypt",
      "Resource": "*"
    }
  ]
}
EOF
}

# Allow CodeBuild to use the KMS key for encryption
resource "aws_s3_bucket" "codebuild-project-cloudrail-test" { bucket = "codebuild-project-cloudrail-test" acl = "private" versioning { enabled = true } }
