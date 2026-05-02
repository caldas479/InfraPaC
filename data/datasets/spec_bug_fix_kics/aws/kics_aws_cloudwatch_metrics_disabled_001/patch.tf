resource "aws_api_gateway_method_settings" "positive1" {
rest_api_id = aws_api_gateway_rest_api.test.id
stage_name = aws_api_gateway_stage.test.stage_name
method_path = "${aws_api_gateway_resource.test.path_part}/${aws_api_gateway_method.test.http_method}"

settings {
metrics_enabled = true
logging_level = "INFO"
}
}

resource "aws_api_gateway_method_settings" "positive2" {
rest_api_id = aws_api_gateway_rest_api.test.id
stage_name = aws_api_gateway_stage.test.stage_name
method_path = "${aws_api_gateway_resource.test.path_part}/${aws_api_gateway_method.test.http_method}"

settings {
metrics_enabled = true
logging_level = "INFO"
}
}
