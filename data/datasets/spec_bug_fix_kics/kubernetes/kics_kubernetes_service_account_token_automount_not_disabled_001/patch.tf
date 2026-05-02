resource "kubernetes_cron_job" "demo3" {
	metadata {
		name = "demo"
	}
	spec {
		concurrency_policy = "Replace"
		failure_jobs_history_limit = 5
		schedule = "1 0 * * *"
		starting_deadline_seconds = 10
		successful_jobs_history_limit = 10
		job_template {
			metadata {}
			spec {
				backoff_limit = 2
				ttl_seconds_after_finished = 10
				template {
					metadata {}
					spec {
						automount_service_account_token = false
						container {
							name = "hello"
							image = "busybox"
							command = ["/bin/sh", "-c", "date; echo Hello from the Kubernetes cluster"]
						}
					}
			}
		}
	}
}

resource "kubernetes_pod" "test6" {
	metadata {
		name = "terraform-example"
	}
	spec {
		automount_service_account_token = false
		container {
			image = "nginx:1.7.9"
			name = "example"
		env {
			name = "environment"
			value = "test"
		}
		port {
			container_port = 8080
		}
		liveness_probe {
			http_get {
				path = "/nginx_status"
				port = 80
				header {
					name = "X-Custom-Header"
					value = "Awesome"
				}
			}
			initial_delay_seconds = 3
			period_seconds = 3
		}
	dns_config {
		nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
		searches = ["example.com"]
		option {
			name = "ndots"
			value = 1
		}
		option {
			name = "use-vc"
		}
	}
	dns_policy = "None"
	}
}
