resource "google_compute_instance" "positive1" {
	name = "test"
	machine_type = "e2-medium"
	zone = "us-central1-a"

	boot_disk {}

	network_interface {
		network = "default"
		access_config {}
	}

	service_account {
		scopes = ["userinfo-email", "compute-ro", "storage-ro"]
	}
}
