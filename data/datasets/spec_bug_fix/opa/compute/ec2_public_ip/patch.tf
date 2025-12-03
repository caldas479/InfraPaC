resource "aws_instance" "app_server" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-12345678"
  associate_public_ip_address = false

  tags = {
    Name        = "app-server"
    Environment = "production"
  }
}
