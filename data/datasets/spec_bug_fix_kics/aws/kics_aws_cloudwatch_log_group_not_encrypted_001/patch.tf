resource "aws_cloudwatch_log_group" "negative1" {
	name = "Yada"
	tags = {
		Environment = "production"
		Application = "serviceA"
	}
	kms_key_id = "alias/aws/cloudwatch"
	retenion_in_days = 1
}
