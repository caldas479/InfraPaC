resource "aws_instance" "positive2" {
	ami = "ami-003634241a8fcdec0"
	instance_type = "t2.micro"
	vpc_security_group_ids = [aws_security_group.my_sg.id]
	# Add a new security group to the list of security groups for this instance
	security_groups = [aws_security_group.my_sg.id]
}

resource "aws_security_group" "my_sg" {
	name = "my-sg"
	description = "My security group"
}
