resource "aws_kinesis_stream" "positive1" {
 name = "terraform-kinesis-test"
 shard_count = 1
 retention_period = 48
 shard_level_metrics = ["IncomingBytes", "OutgoingBytes"]
 tags = { Environment = "test" }
 encryption_type = "KMS"
 kms_key_id = "your-kms-key-id"
}

 resource "aws_kinesis_stream" "positive2" {
 name = "terraform-kinesis-test"
 shard_count = 1
 retention_period = 48
 shard_level_metrics = ["IncomingBytes", "OutgoingBytes"]
 tags = { Environment = "test" }
 encryption_type = "KMS"
 kms_key_id = "your-kms-key-id"
}

 resource "aws_kinesis_stream" "positive3" {
 name = "terraform-kinesis-test"
 shard_count = 1
 retention_period = 48
 shard_level_metrics = ["IncomingBytes", "OutgoingBytes"]
 tags = { Environment = "test" }
 encryption_type = "KMS"
 kms_key_id = "your-kms-key-id"
}
