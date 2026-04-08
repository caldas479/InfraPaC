resource "aws_iam_role" "test_role" {\n  name = "test_role"\n\n  assume_role_policy = <<EOF\n{ \"Version\": \"2012-10-17\", \"Statement\": [ { \"Action\": \"sts:AssumeRole\", \"Principal\": { \"Service\": \"ec2.amazonaws.com\" }, \"Effect\": \"Allow\", \"Sid\": \"\" } ] } EOF\n}

resource "aws_iam_instance_profile" "test_profile" {\n  name = "test_profile"\n  role = aws_iam_role.test_role.name\n}

resource "aws_iam_role_policy" "test_policy" {\n  name = "test_policy"\n  role = aws_iam_role.test_role.id\n
  policy = <<EOF\n{ \"Version\": \"2012-10-17\", \"Statement\": [ { \"Action\": [ \"s3:*\" ], \"Effect\": \"Allow\", \"Resource\": \"*\" } ] } EOF\n}

resource "aws_instance" "pub_ins" {\n  ami = data.aws_ami.ubuntu.id\n  instance_type = "t2.micro"\n  subnet_id = module.vpc.public_subnets[0]\n  iam_instance_profile = aws_iam_instance_profile.test_profile.name\n}

resource "aws_instance" "priv_ins" {\n  ami = data.aws_ami.ubuntu.id\n  instance_type = "t2.micro"\n  subnet_id = module.vpc.private_subnets[0]\n  iam_instance_profile = aws_iam_instance_profile.test_profile.name\n}
