resource "aws_cloudwatch_log_group" "negative1" {
	name = "Yada"
	tags = {
		environment = "production"
		application = "serviceA"
	}
	kms_key_id = "alias/aws/cloudwatch"
	retention_in_days = 1
}
