resource "aws_route53_record" "example" {
	allow_overwrite = true
	name            = "test.example.com"
	ttl             = 30
	type            = "NS"
	zone_id         = aws_route53_zone.example.zone_id

	records = ["ns-1234.awsdns-12.com.", "ns-5678.awsdns-90.com."]
}
