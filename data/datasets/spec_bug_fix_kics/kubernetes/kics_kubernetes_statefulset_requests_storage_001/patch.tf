resource "kubernetes_stateful_set" "prometheus" {
	metadata {
		annotations = {
		SomeAnnotation = "foobar"
	}

	labels = {
		k8s-app = "prometheus"
		"kubernetes.io/cluster-service" = "true"
		"addonmanager.kubernetes.io/mode" = "Reconcile"
		version = "v2.2.1"
	}

	name = "prometheus"
	namespace = "monitoring"
	}

	volume_claim_template {
		metadata {
			name = "prometheus-data"
		}

		spec {
			access_modes = ["ReadWriteOnce"]
			storage_class_name = "standard"

			resources {
				requests = {
				storage = "16Gi"
			}
		}
	}

	update_strategy {
		type = "RollingUpdate"

		rolling_update {
			partition = 1
		}
	}

	volume {
		name = "config-volume"

		config_map {
			name = "prometheus-config"
		}
	}

	container {
		name = "prometheus-server"

		image = "prom/prometheus:v2.2.1"
		image_pull_policy = "IfNotPresent"

		args = ["--config.file=/etc/config/prometheus.yml", "--storage.tsdb.path=/data", "--web.console.libraries=/etc/prometheus/console_libraries", "--web.console.templates=/etc/prometheus/consoles", "--web.enable-lifecycle"]
		ports = [{
			container_port = 9090
		}]

		resources {
			limits = {
				cpu = "200m"
				memory = "1000Mi"
			}

			requests = {
				cpu = "200m"
				memory = "1000Mi"
			}
		}

		volume_mount {
			name = "config-volume"
			mount_path = "/etc/config"
		}

		volume_mount {
			name = "prometheus-data"
			mount_path = "/data"
			sub_path = ""
		}

		readiness_probe {
			http_get {
				path = "/-/ready"
				port = 9090
			}

			initial_delay_seconds = 30
			timeout_seconds = 30
		}

		liveness_probe {
			http_get {
				path = "/-/healthy"
				port = 9090
				scheme = "HTTPS"
			}

			initial_delay_seconds = 30
			timeout_seconds = 30
		}
	}

	termination_grace_period_seconds = 300
}
