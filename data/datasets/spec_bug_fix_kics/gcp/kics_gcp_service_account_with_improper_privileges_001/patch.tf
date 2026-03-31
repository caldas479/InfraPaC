data "google_iam_policy" "admin" {
	binding {
		role = "roles/editor"
	}
	member = "serviceAccount:jane@example.com"
}
