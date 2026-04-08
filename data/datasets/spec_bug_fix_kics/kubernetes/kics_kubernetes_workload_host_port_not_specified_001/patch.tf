resource "kubernetes_pod" "test" {
	metadata {
		name = "terraform-example"
	}
	spec {
		container {
			image = "nginx:1.7.9"
			name  = "example"
			env {
				name  = "environment"
				value = "test"
			}
			host_port = 8080
			liveness_probe {
				http_get {
					path = "/nginx_status"
					port = 80
				}
				initial_delay_seconds = 3
				period_seconds = 3
			}
		dns_config {
			nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
			searches = ["example.com"]
		}
	dns_policy = "None"
	}
}
