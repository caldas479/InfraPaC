resource "aws_security_group" "positive1" {
	name = "allow_tls_1"
	description = "Allow TLS inbound traffic"
	vpc_id = aws_vpc.main.id

	# Add a new ingress rule to allow traffic on port 2383
	ingress {
		description = "TLS from VPC"
		from_port = 2383
		to_port = 2383
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_security_group" "positive2" {
	name = "allow_tls_2"
	description = "Allow TLS inbound traffic"
	vpc_id = aws_vpc.main.id

	# Add a new ingress rule to allow traffic on port 2383
	ingress {
		description = "TLS from VPC"
		from_port = 2383
		to_port = 2383
		protocol = "tcp"
		cidr_blocks = ["0.1.0.0/0"]
	}

	# Add a new ingress rule to allow traffic on port 2390
	ingress {
		description = "TLS from VPC"
		from_port = 2390
		to_port = 2390
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
