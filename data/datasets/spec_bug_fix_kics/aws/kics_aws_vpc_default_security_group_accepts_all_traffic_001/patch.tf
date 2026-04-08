resource "aws_vpc" "mainvpc" {
 cidr_block = "10.1.0.0/16"
}

 resource "aws_default_security_group" "default" {
 vpc_id = aws_vpc.mainvpc.id
}
