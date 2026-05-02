resource "aws_cloudtrail" "positive1" {
	# ... other configuration ...

	sns_topic_name = "my-sns-topic"
}

resource "aws_cloudtrail" "positive2" {
	# ... other configuration ...

	sns_topic_name = "my-sns-topic"
}
