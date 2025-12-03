resource "aws_instance" "database_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.large"
  subnet_id     = "subnet-87654321"

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 100
    volume_type = "gp3"
    encrypted   = true # <-- add this line to ensure the EBS volume is encrypted
  }

  tags = {
    Name        = "database-server"
    Environment = "production"
  }
}