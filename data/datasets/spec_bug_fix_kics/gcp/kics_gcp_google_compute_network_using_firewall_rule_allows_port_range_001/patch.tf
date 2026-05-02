resource "google_compute_firewall" "positive1" {
  name    = "test-firewall"
  network = google_compute_network.positive1.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "positive1" {
  name = "test-network"
}
