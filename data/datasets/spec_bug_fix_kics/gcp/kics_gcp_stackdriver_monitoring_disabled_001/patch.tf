resource "google_container_cluster" "positive1" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3
	monitoring_service = "monitoring.googleapis.com/kubernetes"
	timeouts {
		create = "30m"
		update = "40m"
	}
}

resource "google_container_cluster" "positive2" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3
	monitoring_service = "monitoring.googleapis.com/kubernetes"
	timeouts {
		create = "30m"
		update = "40m"
	}
}
