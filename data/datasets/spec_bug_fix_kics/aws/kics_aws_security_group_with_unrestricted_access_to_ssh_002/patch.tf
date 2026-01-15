resource "aws_security_group" "positive2" {
	name = "allow_tls"
	description = "Allow TLS inbound traffic"
	vpc_id = aws_vpc.main.id

	# Add a new ingress rule to allow SSH access from the VPC CIDR blocks only
	ingress {
		description = "SSH from VPC"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = [aws_vpc.main.cidr_block]
	}

	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
	Name = "allow_tls"
	}
}
