resource "aws_cloudformation_stack" "networking-stack" {
	name = "networking-stack"

	parameters = {VPCCidr = "10.0.0.0/16"}

	template_body = <<EOF
{"Resources": {"VPC": {"Type": "AWS::EC2::VPC", "Properties": {"CidrBlock": "${VPCCidr}"}}}}
EOF
}
