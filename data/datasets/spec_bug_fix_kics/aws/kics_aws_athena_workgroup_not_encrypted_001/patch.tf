resource "aws_athena_workgroup" "example" {
	name = "example"

	configuration {
	enforce_workgroup_configuration    = true
	publish_cloudwatch_metrics_enabled = true

	result_configuration {
		encryption_configuration {
			encryption_option = "SSE_KMS"
			kms_key_arn = aws_kms_key.example.arn
		}
	}
	output_location = "s3://${aws_s3_bucket.example.bucket}/output/"
}

resource "aws_athena_workgroup" "example_2" {
	name = "example"

	configuration {
	enforce_workgroup_configuration    = true
	publish_cloudwatch_metrics_enabled = true

	result_configuration {
		encryption_configuration {
			encryption_option = "SSE_KMS"
			kms_key_arn = aws_kms_key.example.arn
		}
	}
	output_location = "s3://${aws_s3_bucket.example.bucket}/output/"
}

resource "aws_athena_workgroup" "example_3" {
	name = "example"

	configuration {
	enforce_workgroup_configuration    = true
	publish_cloudwatch_metrics_enabled = true

	result_configuration {
		encryption_configuration {
			encryption_option = "SSE_KMS"
			kms_key_arn = aws_kms_key.example.arn
		}
	}
	output_location = "s3://${aws_s3_bucket.example.bucket}/output/"
}
