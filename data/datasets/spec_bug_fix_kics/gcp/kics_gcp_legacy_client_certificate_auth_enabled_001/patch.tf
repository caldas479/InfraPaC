resource "google_container_cluster" "positive1" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3

	master_auth {
		client_certificate_config {
			renew_usages = ["signing", "voting"]
		}
	}

	timeouts {
		create = "30m"
		update = "40m"
	}
}

resource "google_container_cluster" "positive2" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3

	master_auth {
		client_certificate_config {
			renew_usages = ["signing", "voting"]
			issue_client_certificate = false
		}
	}

	timeouts {
		create = "30m"
		update = "40m"
	}
}
