resource "aws_config_config_rule" "positive1" {
	name = "some_rule"
	source {
		owner = "AWS"
		source_identifier = "ENCRYPTED_VOLUMES"
	}
}

resource "aws_config_config_rule" "positive2" {
	name = "another_rule"
	source {
		owner = "AWS"
		source_identifier = "ENCRYPTED_VOLUMES"
	}
}
