resource "aws_docdb_cluster" "docdb" {
 cluster_identifier = "my-docdb-cluster"
 engine = "docdb"
 master_username = "foo"
 master_password = "mustbeeightchars"
 backup_retention_period = 5
 preferred_backup_window = "07:00-09:00"
 skip_final_snapshot = true
 kms_key_id = aws_kms_key.docdb.key_id
}

resource "aws_kms_key" "docdb" {
 description = "DocDB KMS key"
 enable_key_rotation = true
 policy = jsonencode({
 "Version": "2012-10-17",
 "Id": "kms-tf-20190918",
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
