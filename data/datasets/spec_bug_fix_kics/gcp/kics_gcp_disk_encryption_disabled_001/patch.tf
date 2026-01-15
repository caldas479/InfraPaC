resource "google_compute_disk" "positive1" {
	name = "test-disk"
	type = "pd-ssd"
	zone = "us-central1-a"
	image = "debian-9-stretch-v20200805"
	labels = { environment = "dev" }
	physical_block_size_bytes = 4096
	disk_encryption_key {
		raw_key = "A"
	}
}

resource "google_compute_disk" "positive2" {
	name = "test-disk"
	type = "pd-ssd"
	zone = "us-central1-a"
	image = "debian-9-stretch-v20200805"
	labels = { environment = "dev" }
	physical_block_size_bytes = 4096
	disk_encryption_key {
		kms_key_self_link = "projects/my-project/locations/us-central1/keyRings/my-keyring/cryptoKeys/my-key"
	}
}
