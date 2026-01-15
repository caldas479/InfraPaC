resource "aws_api_gateway_domain_name" "example" {
  certificate_body = file("./rsa2048.pem")
  domain_name     = "api.example.com"
}
