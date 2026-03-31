resource "kubernetes_pod" "positive1" {
 metadata {
 name = "terraform-example"
 }
 spec {
 container {
 image = "nginx:1.19.2"
 name  = "example"
 resources {
 limits {
 cpu = "0.5"
 memory = "256Mi"
 }
 }
 env {
 name  = "environment"
 value = "test"
 }
 port {
 container_port = 8080
 }
 liveness_probe {
 http_get {
 path = "/nginx_status"
 port = 80
 }
 initial_delay_seconds = 3
 period_seconds = 3
 }
 }
 dns_config {
 nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
 searches = ["example.com"]
 option {
 name  = "ndots"
 value = 1
 }
 option {
 name = "use-vc"
 }
 }
 dns_policy = "None"
 }
}
resource "kubernetes_pod" "positive2" {
 metadata {
 name = "terraform-example"
 }
 spec {
 container {
 image = "nginx:1.19.2"
 name  = "example"
 resources {
 limits {
 cpu = "0.5"
 memory = "256Mi"
 }
 }
 env {
 name  = "environment"
 value = "test"
 }
 port {
 container_port = 8080
 }
 liveness_probe {
 http_get {
 path = "/nginx_status"
 port = 80
 }
 initial_delay_seconds = 3
 period_seconds = 3
 }
 }
 dns_config {
 nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
 searches = ["example.com"]
 option {
 name  = "ndots"
 value = 1
 }
 option {
 name = "use-vc"
 }
 }
 dns_policy = "None"
 }
}
