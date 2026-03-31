resource "kubernetes_pod" "test" {
	metadata {
	name = "terraform-example"
}

resource "kubernetes_cron_job" "test2" {
	metadata {
	name = "terraform-example"
	namespace = "my-namespace"
}

}
