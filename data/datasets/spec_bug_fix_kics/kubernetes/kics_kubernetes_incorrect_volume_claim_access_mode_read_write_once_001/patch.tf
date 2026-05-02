resource "aws_instance" "example" {
	ami = "ami-12345678"
	zones = ["us-east-1a", "us-east-1b"]
	vpc_security_group_ids = ["sg-12345678"]
	instance_type = "t2.micro"
	associate_public_ip_address = true
	key_name = "my-key"
	user_data = <<EOF
	#!/bin/bash
	yum install -y nginx
	echo '<html><body><h1>Hello from Instance 1</h1></body></html>' > /usr/share/nginx/html/index.html
	EOF
	tags = {
	"Name" = "example"
	}
}

resource "aws_instance" "example2" {
	ami = "ami-12345678"
	zones = ["us-east-1a", "us-east-1b"]
	vpc_security_group_ids = ["sg-12345678"]
	instance_type = "t2.micro"
	associate_public_ip_address = true
	key_name = "my-key"
	user_data = <<EOF
	#!/bin/bash
	yum install -y nginx
	echo '<html><body><h1>Hello from Instance 2</h1></body></html>' > /usr/share/nginx/html/index.html
	EOF
	tags = {
	"Name" = "example2"
	}
}
