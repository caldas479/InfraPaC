resource "aws_ecr_repository" "foo" {
	name = "bar"
	image_tag_mutability = "IMMUTABLE"

	image_scanning_configuration {
		scan_on_push = true
	}

	encryption_configuration {
		encryption_type = "KMS"
		kms_key = "arn:aws:kms:us-west-2:123456789012:key/abcd-efgh-ijkl-mnop"
	}
}

resource "aws_ecr_repository" "fooX" {
	name = "barX"
	image_tag_mutability = "IMMUTABLE"

	image_scanning_configuration {
		scan_on_push = true
	}

	encryption_configuration {
		encryption_type = "KMS"
		kms_key = "arn:aws:kms:us-west-2:123456789012:key/abcd-efgh-ijkl-mnop"
	}
}
