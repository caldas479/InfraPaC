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
			port {
				container_port = 8080
			}
			livenessProbe {
				exec {
					command = ["cat", "/tmp/healthy"]
				}
				initialDelaySeconds = 5
				durationSeconds = 2
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
