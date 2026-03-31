resource "aws_iam_access_key" "positive1" {
 user = "root"
 status = "Inactive"
}

 resource "aws_iam_access_key" "positive2" {
 user = "user"
 status = "Active"
}
