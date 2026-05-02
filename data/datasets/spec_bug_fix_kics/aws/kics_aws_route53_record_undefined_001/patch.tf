resource "aws_route53_record" "example" {
	allow_overwrite = true
	name            = "test.example.com"
	ttl             = 30
	type            = "NS"
	zone_id         = aws_route53_zone.example.zone_id

	records = [
		"ns-1234.awsdns-01.org",
		"ns-5678.awsdns-01.com",
		"ns-9012.awsdns-01.net",
		"ns-3456.awsdns-01.co.uk"
	]
}
