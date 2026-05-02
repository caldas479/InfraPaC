resource "aws_instance" "positive1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }

  security_groups = [ aws_security_group.positive1.id ]
}

resource "aws_security_group" "positive1" {
  name = "positive1"
  description = "Positive Security Group"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "positive2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }

  security_groups = [ aws_security_group.positive2.id ]
}

resource "aws_security_group" "positive2" {
  name = "positive2"
  description = "Positive Security Group"
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_vpc" "default" {
  default = true
  filter {
    name = "isDefault"
    values = [true]
  }
}
