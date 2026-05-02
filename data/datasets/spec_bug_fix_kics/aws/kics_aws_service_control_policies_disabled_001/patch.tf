resource "aws_organizations_organization" "positive1" {
	feature_set = "ALL"
	aws_service_access_principals = [
		"cloudtrail.amazonaws.com",
		"config.amazonaws.com",
	]
}
