provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "positive1" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"

  tags = {
    Name = "test"
  }

  iam_instance_profile { name = "my-iam-role" }

  credit_specification {
    cpu_credits = "unlimited"
  }
}
