resource "google_container_cluster" "marcellus-wallace" {
	name = "marcellus-wallace"
	location = "us-central1-a"
	initial_node_count = 3

	master_auth {
		username = ""
		password = ""

		client_certificate_config {
			issue_client_certificate = false
		}
	}

	timeouts {
		create = "30m"
		update = "40m"
	}

	min_master_version = "1.25"
	node_version = "1.25"
}
