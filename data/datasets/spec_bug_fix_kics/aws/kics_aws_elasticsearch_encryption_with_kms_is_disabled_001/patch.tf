resource "aws_elasticsearch_domain" "positive1" {
  domain_name           = "example"
  elasticsearch_version = "1.5"

  encrypt_at_rest {
    enabled = true
    kms_key_id = "<YOUR KMS KEY ID>"
  }
}
