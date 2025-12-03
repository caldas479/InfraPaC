resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security group for web servers"
  vpc_id      = "vpc-12345678"

  ingress {
    description = "SSH from specific IP addresses"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.0.2.0/24", "198.51.100.0/24"] # Replace with your specific IP addresses
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}