resource "aws_elasticsearch_domain" "positive1" {
 domain_name = "example"
 elasticsearch_version = "1.5"

 encrypt_at_rest {
 enabled = true
 kms_key_id = aws_kms_key.es-encryption.arn }

}

resource "aws_kms_key" "es-encryption" {
 description = "Elasticsearch encryption key"
 enable_key_rotation = true
 policy = jsonencode({
 "Version": "2012-10-17",
 "Id": "kms-tf-test",
 "Statement": [{
 "Sid": "Enable IAM User Permissions",
 "Effect": "Allow",
 "Principal": {"AWS": "arn:aws:iam::123456789012:root"},
 "Action": "kms:*",
 "Resource": "*"
 }]
})
}

}
