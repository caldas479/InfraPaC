resource "aws_iam_role" "positiverole1" {
	name = "positiveinlinepolicy1"
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [{
			Action = ["ec2:Describe*", "iam:*"]
			Effect   = "Allow"
			Resource = "*"
		}]
	})
}

resource "aws_iam_role" "positiverole2" {
	name = "positiveinlinepolicy1"
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [{
			Action = ["ec2:Describe*", "iam:*"]
			Effect   = "Allow"
			Resource = "*"
		}]
	})
}

resource "aws_iam_role_policy_attachment" "positiverolepolicyattachment1" {
	role       = aws_iam_role.positiverole1.name
	policy_arn = aws_iam_policy.positivecustomermanagedpolicy1.arn
}

resource "aws_iam_policy_attachment" "positivedirectpolicyattachment1" {
	roles       = [aws_iam_role.positiverole1.name]
	policy_arn = aws_iam_policy.positivecustomermanagedpolicy2.arn
}

resource "aws_iam_role_policy_attachment" "positiverolepolicyattachment2" {
	role       = aws_iam_role.positiverole2.name
	policy_arn = "arn:aws:iam::policy/positivepreexistingpolicyarn1"
}

resource "aws_iam_policy_attachment" "positivedirectpolicyattachment2" {
	roles       = [aws_iam_role.positiverole2.name]
	policy_arn = "arn:aws:iam::policy/AmazonPersonalizeFullAccess"
}
