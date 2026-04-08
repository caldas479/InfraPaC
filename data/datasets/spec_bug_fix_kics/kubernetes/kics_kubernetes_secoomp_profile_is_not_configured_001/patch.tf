resource "kubernetes_pod" "example" {
	metadata {
		name = "example"
	}
	spec {
		containers {
			name = "example"
			image = "nginx:1.7.8"
			resources {
				limits = {cpu = "0.5", memory = "512Mi"}
				requests = {cpu = "250m", memory = "50Mi"}
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
}
