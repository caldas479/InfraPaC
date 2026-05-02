resource "aws_elasticsearch_domain" "positive1" {
	log_publishing_options {
		enabled = true
	}
}
