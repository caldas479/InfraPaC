resource "aws_instance" "positive1" {
	ami = "ami-003634241a8fcdec0"

	vpc_security_group_ids = ["sg-005e9ec7f365c07b1"]

	instance_type = "t2.micro"
}
