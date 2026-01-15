resource "google_container_cluster" "positive1" {
 name = "marcellus-wallace"
 location = "us-central1-a"
 initial_node_count = 3

 ip_allocation_policy {
 cluster_ipv4_cidr_block = "10.2.0.0/16"
 services_ipv4_cidr_block = "10.3.0.0/24"
 }

 networking_mode = "VPC_NATIVE"

 timeouts {
 create = "30m"
 update = "40m"
 }
 }

 resource "google_container_cluster" "positive2" {
 name = "marcellus-wallace"
 location = "us-central1-a"
 initial_node_count = 3

 ip_allocation_policy {
 cluster_ipv4_cidr_block = "10.2.0.0/16"
 services_ipv4_cidr_block = "10.3.0.0/24"
 }

 networking_mode = "VPC_NATIVE"

 timeouts {
 create = "30m"
 update = "40m"
 }
 }

 resource "google_container_cluster" "positive3" {
 name = "marcellus-wallace"
 location = "us-central1-a"
 initial_node_count = 3

 ip_allocation_policy {
 cluster_ipv4_cidr_block = "10.2.0.0/16"
 services_ipv4_cidr_block = "10.3.0.0/24"
 }

 networking_mode = "VPC_NATIVE"

 timeouts {
 create = "30m"
 update = "40m"
 }
 }
