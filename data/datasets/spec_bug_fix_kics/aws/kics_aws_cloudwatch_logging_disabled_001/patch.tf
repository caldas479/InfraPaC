resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

resource "aws_route53_query_log" "log_group_mismatch" {
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.aws_route53_log_mismatch.arn
}

resource "aws_route53_zone" "example_com" {
  name = "example.com"
  query_log = aws_route53_query_log.log_group_mismatch.id
}
