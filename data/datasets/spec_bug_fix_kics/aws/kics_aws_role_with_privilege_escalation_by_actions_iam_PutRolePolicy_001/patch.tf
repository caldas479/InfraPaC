resource "aws_iam_role" "cosmic" {
  name = "cosmic"
}

resource "aws_iam_role_policy" "test_inline_policy" {
  name = "test_inline_policy"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy2" {
  name = "test_inline_policy2"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy3" {
  name = "test_inline_policy3"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy4" {
  name = "test_inline_policy4"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy5" {
  name = "test_inline_policy5"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy6" {
  name = "test_inline_policy6"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy7" {
  name = "test_inline_policy7"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy8" {
  name = "test_inline_policy8"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy9" {
  name = "test_inline_policy9"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy10" {
  name = "test_inline_policy10"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy11" {
  name = "test_inline_policy11"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy12" {
  name = "test_inline_policy12"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy13" {
  name = "test_inline_policy13"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy14" {
  name = "test_inline_policy14"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy15" {
  name = "test_inline_policy15"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy16" {
  name = "test_inline_policy16"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy17" {
  name = "test_inline_policy17"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy18" {
  name = "test_inline_policy18"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy19" {
  name = "test_inline_policy19"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy20" {
  name = "test_inline_policy20"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy21" {
  name = "test_inline_policy21"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy22" {
  name = "test_inline_policy22"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy23" {
  name = "test_inline_policy23"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy24" {
  name = "test_inline_policy24"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy25" {
  name = "test_inline_policy25"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy26" {
  name = "test_inline_policy26"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy27" {
  name = "test_inline_policy27"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy28" {
  name = "test_inline_policy28"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy29" {
  name = "test_inline_policy29"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy30" {
  name = "test_inline_policy30"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy31" {
  name = "test_inline_policy31"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy32" {
  name = "test_inline_policy32"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy33" {
  name = "test_inline_policy33"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy34" {
  name = "test_inline_policy34"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy35" {
  name = "test_inline_policy35"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy36" {
  name = "test_inline_policy36"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy37" {
  name = "test_inline_policy37"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy38" {
  name = "test_inline_policy38"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy39" {
  name = "test_inline_policy39"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy40" {
  name = "test_inline_policy40"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy41" {
  name = "test_inline_policy41"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy42" {
  name = "test_inline_policy42"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy43" {
  name = "test_inline_policy43"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy44" {
  name = "test_inline_policy44"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy45" {
  name = "test_inline_policy45"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy46" {
  name = "test_inline_policy46"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy47" {
  name = "test_inline_policy47"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy48" {
  name = "test_inline_policy48"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy49" {
  name = "test_inline_policy49"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy50" {
  name = "test_inline_policy50"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy51" {
  name = "test_inline_policy51"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy52" {
  name = "test_inline_policy52"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy53" {
  name = "test_inline_policy53"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy54" {
  name = "test_inline_policy54"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy55" {
  name = "test_inline_policy55"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy56" {
  name = "test_inline_policy56"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy57" {
  name = "test_inline_policy57"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy58" {
  name = "test_inline_policy58"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy59" {
  name = "test_inline_policy59"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy60" {
  name = "test_inline_policy60"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy61" {
  name = "test_inline_policy61"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy62" {
  name = "test_inline_policy62"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy63" {
  name = "test_inline_policy63"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy64" {
  name = "test_inline_policy64"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy65" {
  name = "test_inline_policy65"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy66" {
  name = "test_inline_policy66"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy67" {
  name = "test_inline_policy67"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy68" {
  name = "test_inline_policy68"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy69" {
  name = "test_inline_policy69"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy70" {
  name = "test_inline_policy70"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy71" {
  name = "test_inline_policy71"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy72" {
  name = "test_inline_policy72"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy73" {
  name = "test_inline_policy73"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy74" {
  name = "test_inline_policy74"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy75" {
  name = "test_inline_policy75"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy76" {
  name = "test_inline_policy76"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy77" {
  name = "test_inline_policy77"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy78" {
  name = "test_inline_policy78"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy79" {
  name = "test_inline_policy79"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy80" {
  name = "test_inline_policy80"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy81" {
  name = "test_inline_policy81"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy82" {
  name = "test_inline_policy82"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy83" {
  name = "test_inline_policy83"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy84" {
  name = "test_inline_policy84"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy85" {
  name = "test_inline_policy85"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy86" {
  name = "test_inline_policy86"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy87" {
  name = "test_inline_policy87"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy88" {
  name = "test_inline_policy88"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy89" {
  name = "test_inline_policy89"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy90" {
  name = "test_inline_policy90"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy91" {
  name = "test_inline_policy91"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy92" {
  name = "test_inline_policy92"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy93" {
  name = "test_inline_policy93"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy94" {
  name = "test_inline_policy94"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy95" {
  name = "test_inline_policy95"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy96" {
  name = "test_inline_policy96"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy97" {
  name = "test_inline_policy97"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy98" {
  name = "test_inline_policy98"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy99" {
  name = "test_inline_policy99"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy100" {
  name = "test_inline_policy100"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy101" {
  name = "test_inline_policy101"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy102" {
  name = "test_inline_policy102"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy103" {
  name = "test_inline_policy103"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy104" {
  name = "test_inline_policy104"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy105" {
  name = "test_inline_policy105"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy106" {
  name = "test_inline_policy106"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy107" {
  name = "test_inline_policy107"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy108" {
  name = "test_inline_policy108"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy109" {
  name = "test_inline_policy109"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy110" {
  name = "test_inline_policy110"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy111" {
  name = "test_inline_policy111"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy112" {
  name = "test_inline_policy112"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy113" {
  name = "test_inline_policy113"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy114" {
  name = "test_inline_policy114"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy115" {
  name = "test_inline_policy115"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy116" {
  name = "test_inline_policy116"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy117" {
  name = "test_inline_policy117"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy118" {
  name = "test_inline_policy118"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy119" {
  name = "test_inline_policy119"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy120" {
  name = "test_inline_policy120"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy121" {
  name = "test_inline_policy121"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy122" {
  name = "test_inline_policy122"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy123" {
  name = "test_inline_policy123"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy124" {
  name = "test_inline_policy124"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy125" {
  name = "test_inline_policy125"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy126" {
  name = "test_inline_policy126"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy127" {
  name = "test_inline_policy127"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy128" {
  name = "test_inline_policy128"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy129" {
  name = "test_inline_policy129"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy130" {
  name = "test_inline_policy130"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy131" {
  name = "test_inline_policy131"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy132" {
  name = "test_inline_policy132"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy133" {
  name = "test_inline_policy133"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy134" {
  name = "test_inline_policy134"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy135" {
  name = "test_inline_policy135"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
    },]
  })
}

resource "aws_iam_role_policy" "test_inline_policy136" {
  name = "test_inline_policy136"
  role = aws_iam_role.cosmic.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "iam:PutRolePolicy",
      ]
      Effect   = "Allow"
      Resource = "*"
