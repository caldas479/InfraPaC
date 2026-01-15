resource "google_sql_database_instance" "master-instance" {
  name = "master-instance"
  database_version = "POSTGRES_11"
  region = "us-central1"

  settings {
    tier = "db-f1-micro"
    backup_configuration {
      enabled = true
    }
  }
}
