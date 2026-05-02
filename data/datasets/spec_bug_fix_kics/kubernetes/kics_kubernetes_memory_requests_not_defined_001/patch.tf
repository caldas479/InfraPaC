resource "kubernetes_pod" "positive1" {
	metadata {
		name = "terraform-example"
	}
	spec {
		env {
			name  = "environment"
			value = "test"
		}
		container {
			image = "nginx:1.7.9"
			name  = "example22"
			resources {
				requests {
					cpu    = "250m"
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
	}
dns_policy = "None"
}

resource "kubernetes_pod" "positive2" {
	metadata {
		name = "terraform-example"
	}
	spec {
		env {
			name  = "environment"
			value = "test"
		}
		container {
			image = "nginx:1.7.9"
			name  = "example"
			resources {
				requests {
					cpu    = "0.5"
					memory = "512Mi"
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
		dns_config {
			nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
			searches = ["example.com"]
		}
dns_policy = "None"
}
}
