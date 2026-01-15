resource "aws_sns_topic" "user-updates-topic" {
	name = "user-updates-topic"
	encryption_enabled = false
}
