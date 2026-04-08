resource "aws_route53_zone" "example" {
	name = "example.com"
}

resource "aws_shield_protection" "example" {
	name = "example"
	resource_arn = aws_route53_zone.example.arn

	tags = {
		Environment = "Dev"
	}
}
