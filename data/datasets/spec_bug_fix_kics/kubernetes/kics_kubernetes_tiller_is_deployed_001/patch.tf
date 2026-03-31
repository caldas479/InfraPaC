resource "kubernetes_pod" "example" {
 metadata {
 name = "terraform-example"
 }
 spec {
 container {
 image = "tiller-image"
 name  = "example"
 resources {
 limits {
 cpu    = "0.5"
 memory = "512Mi"
 }
 requests {
 cpu    = "250m"
 memory = "50Mi"
 }
 }
 dns_config {
 nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
 searches    = ["example.com"]
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
resource "kubernetes_pod" "example2" {
 metadata {
 name = "terraform-example"
 }
 spec {
 container {
 image = "tiller-image"
 name  = "example"
 resources {
 limits {
 cpu    = "0.5"
 memory = "512Mi"
 }
 requests {
 cpu    = "250m"
 memory = "50Mi"
 }
 }
 dns_config {
 nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
 searches    = ["example.com"]
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
resource "kubernetes_deployment" "example" {
 metadata {
 name = "terraform-example"
 labels = {
 test = "MyExampleApp"
 }
 }
 spec {
 replicas = 3
 selector {
 match_labels = {
 test = "MyExampleApp"
 }
 }
 template {
 metadata {
 labels = {
 app = "helm"
 }
 }
 spec {
 volume = [
 {
 host_path = {
 path = "/var/run/docker.sock"
 type = "Directory"
 }
 },
 {
 host_path = {
 path = "/var/run/docker.sock"
 type = "Directory"
 }
 }
 ]
 container {
 image = "tiller-image"
 name  = "example"
 resources {
 limits {
 cpu    = "0.5"
 memory = "512Mi"
 }
 requests {
 cpu    = "250m"
 memory = "50Mi"
 }
 }
 liveness_probe {
 http_get {
 path = "/nginx_status"
 port = 80
 http_header {
 name  = "X-Custom-Header"
 value = "Awesome"
 }
 }
 initial_delay_seconds = 3
 period_seconds        = 3
 }
 }
 }
}
}
