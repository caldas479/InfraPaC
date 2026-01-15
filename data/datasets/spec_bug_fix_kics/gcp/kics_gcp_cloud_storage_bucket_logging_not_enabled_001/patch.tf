resource "google_storage_bucket" "auto-expiring-bucket" {
  name          = "auto-expiring-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  logging {
    log_bucket = "logging-bucket"
  }
}
