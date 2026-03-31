resource "aws_cloudwatch_log_metric_filter" "cis_root_account_use_metric_filter" {
	name = "CIS-RootAccountUsage"
	pattern = "{ $.userIdentity.type = \
