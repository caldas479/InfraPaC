resource "aws_sagemaker_notebook_instance" "ni" {
  name          = "my-notebook-instance"
  role_arn      = aws_iam_role.role.arn
  instance_type = "ml.t2.medium"

  kms_key_id   = aws_kms_key.key.arn

  tags = {
    Name = "foo"
  }
}

resource "aws_kms_key" "key" {
  description             = "My KMS key"
  deletion_window_in_days = 10
}

resource "aws_iam_role" "role" {
  name        = "my-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "sagemaker.amazonaws.com"
      },
      Effect = "Allow",
      Sid     = ""
    }]
  })
}
