resource "aws_efs_file_system" "positive1" {
	creation_token = "my-product"
	tags = { Name = "MyProduct" }
	encrypted = true
}

resource "aws_efs_file_system" "positive2" {
	creation_token = "my-product"
	tags = { Name = "MyProduct" }
	encrypted = true
}
