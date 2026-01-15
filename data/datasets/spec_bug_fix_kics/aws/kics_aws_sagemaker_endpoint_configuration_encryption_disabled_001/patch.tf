resource "aws_sagemaker_endpoint_configuration" "positive" {
  name = "my-endpoint-config"

  production_variants {
    variant_name           = "variant-1"
    model_name             = aws_sagemaker_model.m.name
    initial_instance_count = 1
    instance_type          = "ml.t2.medium"
  }

  tags = {
    Name = "foo"
  }

  kms_key_arn = aws_kms_key.my-key.arn
}

resource "aws_kms_key" "my-key" {
  description             = "My KMS key"
  deletion_window_in_days = 10
}
