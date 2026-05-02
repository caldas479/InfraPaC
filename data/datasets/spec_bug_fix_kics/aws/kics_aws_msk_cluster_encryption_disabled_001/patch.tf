resource "aws_msk_cluster" "example" {
 cluster_name = "example"
 kafka_version = "2.4.1"
 number_of_broker_nodes = 3

 encryption_info {
 encryption_in_transit {
 client_broker = "TLS"
 in_cluster = true
 }
 }
 }
