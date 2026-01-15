resource "aws_cloudwatch_log_metric_filter" "cis_unauthorized_api_calls_metric_filter" {
	name = "CIS-UnauthorizedAPICalls"
	pattern = "{ ($.errorCode = "*UnauthorizedOperation") || ($.errorCode = "AccessDenied*") }"
	log_group_name = aws_cloudwatch_log_group.CIS_CloudWatch_LogsGroup.name

	metric_transformation {
		name = "CIS-UnauthorizedAPICalls"
		namespace = "CIS_Metric_Alarm_Namespace"
		value = "1"
	}
}
