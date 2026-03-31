resource "google_container_cluster" "my-gke-cluster" {
  name                  = "my-gke-cluster"
  location              = "us-central1"
  enable_shielded_nodes = true
}
