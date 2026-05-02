resource "aws_iam_group" "cosmic" {
  name = "cosmic"
}

resource "aws_iam_group_policy" "test_inline_policy" {
  name = "test_inline_policy"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_2" {
  name = "test_inline_policy_2"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_3" {
  name = "test_inline_policy_3"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_4" {
  name = "test_inline_policy_4"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_5" {
  name = "test_inline_policy_5"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_6" {
  name = "test_inline_policy_6"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_7" {
  name = "test_inline_policy_7"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_8" {
  name = "test_inline_policy_8"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_9" {
  name = "test_inline_policy_9"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_10" {
  name = "test_inline_policy_10"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_11" {
  name = "test_inline_policy_11"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_12" {
  name = "test_inline_policy_12"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_13" {
  name = "test_inline_policy_13"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_14" {
  name = "test_inline_policy_14"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_15" {
  name = "test_inline_policy_15"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_16" {
  name = "test_inline_policy_16"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_17" {
  name = "test_inline_policy_17"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_18" {
  name = "test_inline_policy_18"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_19" {
  name = "test_inline_policy_19"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_20" {
  name = "test_inline_policy_20"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_21" {
  name = "test_inline_policy_21"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_22" {
  name = "test_inline_policy_22"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_23" {
  name = "test_inline_policy_23"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_24" {
  name = "test_inline_policy_24"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_25" {
  name = "test_inline_policy_25"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_26" {
  name = "test_inline_policy_26"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_27" {
  name = "test_inline_policy_27"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_28" {
  name = "test_inline_policy_28"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_29" {
  name = "test_inline_policy_29"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_30" {
  name = "test_inline_policy_30"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_31" {
  name = "test_inline_policy_31"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_32" {
  name = "test_inline_policy_32"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_33" {
  name = "test_inline_policy_33"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_34" {
  name = "test_inline_policy_34"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_35" {
  name = "test_inline_policy_35"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_36" {
  name = "test_inline_policy_36"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_37" {
  name = "test_inline_policy_37"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_38" {
  name = "test_inline_policy_38"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_39" {
  name = "test_inline_policy_39"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_40" {
  name = "test_inline_policy_40"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_41" {
  name = "test_inline_policy_41"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_42" {
  name = "test_inline_policy_42"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_43" {
  name = "test_inline_policy_43"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_44" {
  name = "test_inline_policy_44"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_45" {
  name = "test_inline_policy_45"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_46" {
  name = "test_inline_policy_46"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_47" {
  name = "test_inline_policy_47"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_48" {
  name = "test_inline_policy_48"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_49" {
  name = "test_inline_policy_49"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_50" {
  name = "test_inline_policy_50"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_51" {
  name = "test_inline_policy_51"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_52" {
  name = "test_inline_policy_52"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_53" {
  name = "test_inline_policy_53"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_54" {
  name = "test_inline_policy_54"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_55" {
  name = "test_inline_policy_55"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_56" {
  name = "test_inline_policy_56"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_57" {
  name = "test_inline_policy_57"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_58" {
  name = "test_inline_policy_58"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_59" {
  name = "test_inline_policy_59"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_60" {
  name = "test_inline_policy_60"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_61" {
  name = "test_inline_policy_61"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_62" {
  name = "test_inline_policy_62"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_63" {
  name = "test_inline_policy_63"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_64" {
  name = "test_inline_policy_64"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_65" {
  name = "test_inline_policy_65"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_66" {
  name = "test_inline_policy_66"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_67" {
  name = "test_inline_policy_67"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_68" {
  name = "test_inline_policy_68"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_69" {
  name = "test_inline_policy_69"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_70" {
  name = "test_inline_policy_70"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_71" {
  name = "test_inline_policy_71"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_72" {
  name = "test_inline_policy_72"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_73" {
  name = "test_inline_policy_73"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_74" {
  name = "test_inline_policy_74"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_75" {
  name = "test_inline_policy_75"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_76" {
  name = "test_inline_policy_76"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_77" {
  name = "test_inline_policy_77"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_78" {
  name = "test_inline_policy_78"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_79" {
  name = "test_inline_policy_79"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_80" {
  name = "test_inline_policy_80"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_81" {
  name = "test_inline_policy_81"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_82" {
  name = "test_inline_policy_82"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_83" {
  name = "test_inline_policy_83"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_84" {
  name = "test_inline_policy_84"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_85" {
  name = "test_inline_policy_85"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_86" {
  name = "test_inline_policy_86"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_87" {
  name = "test_inline_policy_87"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_88" {
  name = "test_inline_policy_88"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_89" {
  name = "test_inline_policy_89"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_90" {
  name = "test_inline_policy_90"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_91" {
  name = "test_inline_policy_91"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_92" {
  name = "test_inline_policy_92"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_93" {
  name = "test_inline_policy_93"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_94" {
  name = "test_inline_policy_94"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_95" {
  name = "test_inline_policy_95"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_96" {
  name = "test_inline_policy_96"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_97" {
  name = "test_inline_policy_97"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_98" {
  name = "test_inline_policy_98"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_99" {
  name = "test_inline_policy_99"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_100" {
  name = "test_inline_policy_100"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_101" {
  name = "test_inline_policy_101"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_102" {
  name = "test_inline_policy_102"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_103" {
  name = "test_inline_policy_103"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_104" {
  name = "test_inline_policy_104"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_105" {
  name = "test_inline_policy_105"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_106" {
  name = "test_inline_policy_106"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_107" {
  name = "test_inline_policy_107"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_108" {
  name = "test_inline_policy_108"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_109" {
  name = "test_inline_policy_109"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_110" {
  name = "test_inline_policy_110"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_111" {
  name = "test_inline_policy_111"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_112" {
  name = "test_inline_policy_112"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_113" {
  name = "test_inline_policy_113"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_114" {
  name = "test_inline_policy_114"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_115" {
  name = "test_inline_policy_115"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_116" {
  name = "test_inline_policy_116"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_117" {
  name = "test_inline_policy_117"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_118" {
  name = "test_inline_policy_118"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_119" {
  name = "test_inline_policy_119"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_120" {
  name = "test_inline_policy_120"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_121" {
  name = "test_inline_policy_121"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_122" {
  name = "test_inline_policy_122"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_123" {
  name = "test_inline_policy_123"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_124" {
  name = "test_inline_policy_124"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_125" {
  name = "test_inline_policy_125"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_126" {
  name = "test_inline_policy_126"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_127" {
  name = "test_inline_policy_127"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_128" {
  name = "test_inline_policy_128"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_129" {
  name = "test_inline_policy_129"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_130" {
  name = "test_inline_policy_130"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_131" {
  name = "test_inline_policy_131"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_132" {
  name = "test_inline_policy_132"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_133" {
  name = "test_inline_policy_133"
  group = aws_iam_group.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "glue:UpdateDevEndpoint",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_group_policy" "test_inline_policy_134" {
  name = "test_inline_policy_134"
