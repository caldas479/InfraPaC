resource "aws_api_gateway_domain_name" "example2" {
 certificate_body = file("expiredCertificate.pem")
 domain_name     = "api.example.com"
 }
 resource "aws_iam_server_certificate" "example2" {
 certificate_body = file("expiredCertificate.pem")
 domain_name     = "api.example.com"
 }
 resource "aws_acm_certificate" "example2" {
 certificate_body = file("expiredCertificate.pem")
 domain_name     = "api.example.com"
 }
