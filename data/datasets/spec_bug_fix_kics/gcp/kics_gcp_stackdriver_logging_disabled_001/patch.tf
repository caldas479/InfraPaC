resource "google_container_cluster" "positive1" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3
	logging_service = "logging.googleapis.com/kubernetes"
	timeouts {
		create = "30m"
		update = "40m"
	}
}

resource "google_container_cluster" "positive2" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3
	logging_service = "logging.googleapis.com/kubernetes"
	timeouts {
		create = "30m"
		update = "40m"
	}
}
