resource "aws_instance" "positive1" {
	ami = data.aws_ami.ubuntu.id
	instance_type = "t3.micro"
	user_data = "${var.user_data}"
	tags = {
		Name = "HelloWorld"
	}
}
