module "ec2_instance" {
 source = "terraform-aws-modules/ec2-instance/aws"
 version = "~> 3.0"

 name = "single-instance"

 ami = "ami-ebd02392"
 instance_type = "t2.micro"
 key_name = "user1"
 monitoring = true
 vpc_security_group_ids = ["sg-12345678"]
 subnet_id = "subnet-eddcdzz4"
 user_data = "${file("user_data.sh")}"

 tags = {
 Terraform = "true"
 Environment = "dev"
 }
}

 file "user_data.sh" {
 content = <<EOF
 #!/bin/bash
 echo "Hello, World!"
 EOF
}
