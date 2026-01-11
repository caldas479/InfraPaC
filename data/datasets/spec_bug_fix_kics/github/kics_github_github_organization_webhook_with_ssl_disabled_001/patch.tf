resource "github_organization_webhook" "positive1" {
	name = "web"

	configuration {
		url = "https://google.de/"
		type = "form"
		insecure_ssl = false
	}

	active = false

	events = ["issues"]
}
