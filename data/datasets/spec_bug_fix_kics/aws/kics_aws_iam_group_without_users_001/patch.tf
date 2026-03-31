resource "aws_iam_group" "test-group" {
	name = "test-group"
}

resource "aws_iam_user" "user_one2" {
	name = "test-user"
}

resource "aws_iam_user" "user_two2" {
	name = "test-user-two"
}

resource "aws_iam_group_membership" "team2" {
	name = "tf-testing-group-membership"

	users = [aws_iam_user.user_one2.name, aws_iam_user.user_two2.name]

	group = aws_iam_group.test-group.name
}

resource "aws_iam_group_membership" "team3" {
	name = "tf-testing-group-membership"

	users = [aws_iam_user.user_one2.name, aws_iam_user.user_two2.name]

	group = aws_iam_group.test-group.name
}
