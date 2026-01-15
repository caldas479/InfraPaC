resource "aws_instance" "positive1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  user_data = <<EOF
#!/bin/bash
echo "Hello, World!"
EOF

  tags = {
    Name = "HelloWorld"
  }
}
