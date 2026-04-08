resource "aws_mq_broker" "positive1" {
	broker_name = "no-logging"

	logs {
		general = true
		audit = true
	}
}

resource "aws_mq_broker" "positive2" {
	broker_name = "partial-logging"

	logs {
		general = true
		audit = true
	}
}

resource "aws_mq_broker" "positive3" {
	broker_name = "disabled-logging"

	logs {
		general = true
		audit = true
	}
}
