provider "aws" { region = "us-east-1" }

resource "aws_iam_user" "positive1" { name = "aws-foundations-benchmark-1-4-0-terraform-user" path = "/" }

resource "aws_iam_user_login_profile" "positive2" { user = aws_iam_user.positive2.name pgp_key = "gpgkeybase64gpgkeybase64gpgkeybase64gpgkeybase64" }

resource "aws_iam_user_policy" "positive2" { name = "aws-foundations-benchmark-1-4-0-terraform-user" user = aws_iam_user.positive2.name policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Resource": "${aws_iam_user.positive2.arn}",
       "Action": "sts:AssumeRole"
     }
   ]
}
EOF

}

resource "aws_iam_policy" "allow-mfa" { name = "AllowMFA" path = "/" description = "Allows users to use MFA" policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Action": "sts:AssumeRole",
       "Resource": "${aws_iam_user.positive2.arn}",
       "Condition": {
         "Bool": {
           "aws:MultiFactorAuthPresent": true
         }
       }
     }
   ]
}
EOF

}

resource "aws_iam_user_policy_attachment" "allow-mfa" { user = aws_iam_user.positive2.name policy_arn = aws_iam_policy.allow-mfa.arn }
