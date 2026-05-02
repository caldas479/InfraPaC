resource "google_compute_project_metadata" "positive1" {
  metadata = {
    enable-oslogin = true
  }
}

resource "google_compute_project_metadata" "positive2" {
  metadata = {
    foo = "bar"
    enable-oslogin = true
  }
}
