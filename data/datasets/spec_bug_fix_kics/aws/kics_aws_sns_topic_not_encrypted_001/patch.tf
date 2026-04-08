resource "aws_sns_topic" "user-updates-topic" {
	name = "user-updates-topic"
	kms_master_key_id = "alias/aws/sns"
}
