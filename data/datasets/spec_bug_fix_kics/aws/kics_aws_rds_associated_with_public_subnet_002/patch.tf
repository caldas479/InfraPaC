resource "aws_db_instance" "positive2" {
 allocated_storage = 10
 engine = "mysql"
 engine_version = "5.7"
 instance_class = "db.t3.micro"
 name = "mydb"
 username = "foo"
 password = "foobarbaz"
 parameter_group_name = "positive2.mysql5.7"
 skip_final_snapshot = true
 db_subnet_group_name = aws_db_subnet_group.subnetGroup2.name
}

 resource "aws_db_subnet_group" "subnetGroup2" {
 name = "main"
 subnet_ids = [aws_subnet.frontend2.id, aws_subnet.backend2.id]
 tags = {
 Name = "My DB subnet group"
 }
}

 resource "aws_subnet" "frontend2" {
 vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
 cidr_block = "172.2.0.0/24"
}

 resource "aws_subnet" "backend2" {
 vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
 cidr_block = "172.3.0.0/24"
}

 resource "aws_db_subnet_group" "subnetGroup2" {
 name = "main"
 subnet_ids = [aws_subnet.frontend2.id, aws_subnet.backend2.id]
 tags = {
 Name = "My DB subnet group"
 }
}

 resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
 vpc_id = aws_vpc.main.id
 cidr_block = "172.16.0.0/16"
}

 resource "aws_vpc" "main" {
 cidr_block = "172.16.0.0/16"
}

 output "public_subnets" {
 value = aws_subnet.frontend2.id
}

 output "private_subnets" {
 value = aws_subnet.backend2.id
}

 output "vpc_id" {
 value = aws_vpc.main.id
}
