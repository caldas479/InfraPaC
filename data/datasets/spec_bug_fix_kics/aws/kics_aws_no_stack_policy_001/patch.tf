resource "aws_cloudformation_stack" "networking-stack" {
	name = "networking-stack"

	parameters = {
	VPCCidr = "10.0.0.0/16"
	}

	policy_body = <<EOF
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}
