resource "aws_sqs_queue" "positive1" {
  name                              = "terraform-example-queue"
  kms_data_key_reuse_period_seconds = 300
  sqs_managed_sse_enabled          = true
}
