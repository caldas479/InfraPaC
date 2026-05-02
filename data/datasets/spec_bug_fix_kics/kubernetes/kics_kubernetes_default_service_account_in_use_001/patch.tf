resource "kubernetes_service_account" "example" {
	metadata {
		name = "default"
	}
	automount_service_account_token = false
}

resource "kubernetes_service_account" "example2" {
	metadata {
		name = "default"
	}
	automount_service_account_token = false
}
