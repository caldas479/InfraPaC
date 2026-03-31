resource "aws_elasticsearch_domain" "example2" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_elasticsearch_domain_policy" "main2" {
 domain_name = aws_elasticsearch_domain.example2.domain_name

 access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
            },
            "Resource": "${aws_elasticsearch_domain.example2.arn}/*"
        }
    ]
}
POLICIES
}

 resource "aws_iam_policy" "main3" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example2.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main4" {
 role = aws_iam_role.example3.name
 policy_arn = aws_iam_policy.main3.arn
}

 resource "aws_elasticsearch_domain" "example3" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example3" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main5" {
 domain_name = aws_elasticsearch_domain.example3.domain_name
 access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
            },
            "Resource": "${aws_elasticsearch_domain.example3.arn}/*"
        }
    ]
}
POLICIES
}

 resource "aws_iam_policy" "main6" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example3.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main7" {
 role = aws_iam_role.example4.name
 policy_arn = aws_iam_policy.main6.arn
}

 resource "aws_elasticsearch_domain" "example4" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example4" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main8" {
 domain_name = aws_elasticsearch_domain.example4.domain_name
 access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
            },
            "Resource": "${aws_elasticsearch_domain.example4.arn}/*"
        }
    ]
}
POLICIES
}

 resource "aws_iam_policy" "main9" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example4.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main10" {
 role = aws_iam_role.example5.name
 policy_arn = aws_iam_policy.main9.arn
}

 resource "aws_elasticsearch_domain" "example5" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example5" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main11" {
 domain_name = aws_elasticsearch_domain.example5.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example5.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main12" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example5.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main13" {
 role = aws_iam_role.example6.name
 policy_arn = aws_iam_policy.main12.arn
}

 resource "aws_elasticsearch_domain" "example6" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example6" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main14" {
 domain_name = aws_elasticsearch_domain.example6.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example6.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main15" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example6.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main16" {
 role = aws_iam_role.example7.name
 policy_arn = aws_iam_policy.main15.arn
}

 resource "aws_elasticsearch_domain" "example7" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example7" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main17" {
 domain_name = aws_elasticsearch_domain.example7.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example7.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main18" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example7.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main19" {
 role = aws_iam_role.example8.name
 policy_arn = aws_iam_policy.main18.arn
}

 resource "aws_elasticsearch_domain" "example8" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example8" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main20" {
 domain_name = aws_elasticsearch_domain.example8.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example8.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main21" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example8.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main22" {
 role = aws_iam_role.example9.name
 policy_arn = aws_iam_policy.main21.arn
}

 resource "aws_elasticsearch_domain" "example9" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example9" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main23" {
 domain_name = aws_elasticsearch_domain.example9.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example9.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main24" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example9.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main25" {
 role = aws_iam_role.example10.name
 policy_arn = aws_iam_policy.main24.arn
}

 resource "aws_elasticsearch_domain" "example10" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example10" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main26" {
 domain_name = aws_elasticsearch_domain.example10.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example10.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main27" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example10.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main28" {
 role = aws_iam_role.example11.name
 policy_arn = aws_iam_policy.main27.arn
}

 resource "aws_elasticsearch_domain" "example11" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example11" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main29" {
 domain_name = aws_elasticsearch_domain.example11.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example11.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main30" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example11.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main31" {
 role = aws_iam_role.example12.name
 policy_arn = aws_iam_policy.main30.arn
}

 resource "aws_elasticsearch_domain" "example12" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example12" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main32" {
 domain_name = aws_elasticsearch_domain.example12.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example12.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main33" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example12.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main34" {
 role = aws_iam_role.example13.name
 policy_arn = aws_iam_policy.main33.arn
}

 resource "aws_elasticsearch_domain" "example13" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example13" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main35" {
 domain_name = aws_elasticsearch_domain.example13.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example13.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main36" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example13.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main37" {
 role = aws_iam_role.example14.name
 policy_arn = aws_iam_policy.main36.arn
}

 resource "aws_elasticsearch_domain" "example14" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example14" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main38" {
 domain_name = aws_elasticsearch_domain.example14.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example14.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main39" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example14.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main40" {
 role = aws_iam_role.example15.name
 policy_arn = aws_iam_policy.main39.arn
}

 resource "aws_elasticsearch_domain" "example15" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example15" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main41" {
 domain_name = aws_elasticsearch_domain.example15.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example15.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main42" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example15.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main43" {
 role = aws_iam_role.example16.name
 policy_arn = aws_iam_policy.main42.arn
}

 resource "aws_elasticsearch_domain" "example16" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example16" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main44" {
 domain_name = aws_elasticsearch_domain.example16.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example16.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main45" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example16.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main46" {
 role = aws_iam_role.example17.name
 policy_arn = aws_iam_policy.main45.arn
}

 resource "aws_elasticsearch_domain" "example17" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example17" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main47" {
 domain_name = aws_elasticsearch_domain.example17.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example17.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main48" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example17.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main49" {
 role = aws_iam_role.example18.name
 policy_arn = aws_iam_policy.main48.arn
}

 resource "aws_elasticsearch_domain" "example18" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example18" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main50" {
 domain_name = aws_elasticsearch_domain.example18.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example18.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main51" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example18.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main52" {
 role = aws_iam_role.example19.name
 policy_arn = aws_iam_policy.main51.arn
}

 resource "aws_elasticsearch_domain" "example19" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example19" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main53" {
 domain_name = aws_elasticsearch_domain.example19.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example19.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main54" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example19.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main55" {
 role = aws_iam_role.example20.name
 policy_arn = aws_iam_policy.main54.arn
}

 resource "aws_elasticsearch_domain" "example20" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example20" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main56" {
 domain_name = aws_elasticsearch_domain.example20.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example20.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main57" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example20.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main58" {
 role = aws_iam_role.example21.name
 policy_arn = aws_iam_policy.main57.arn
}

 resource "aws_elasticsearch_domain" "example21" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example21" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main59" {
 domain_name = aws_elasticsearch_domain.example21.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example21.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main60" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example21.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main61" {
 role = aws_iam_role.example22.name
 policy_arn = aws_iam_policy.main60.arn
}

 resource "aws_elasticsearch_domain" "example22" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example22" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main62" {
 domain_name = aws_elasticsearch_domain.example22.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example22.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main63" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example22.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main64" {
 role = aws_iam_role.example23.name
 policy_arn = aws_iam_policy.main63.arn
}

 resource "aws_elasticsearch_domain" "example23" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example23" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main65" {
 domain_name = aws_elasticsearch_domain.example23.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example23.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main66" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example23.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main67" {
 role = aws_iam_role.example24.name
 policy_arn = aws_iam_policy.main66.arn
}

 resource "aws_elasticsearch_domain" "example24" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example24" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main68" {
 domain_name = aws_elasticsearch_domain.example24.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example24.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main69" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example24.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main70" {
 role = aws_iam_role.example25.name
 policy_arn = aws_iam_policy.main69.arn
}

 resource "aws_elasticsearch_domain" "example25" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example25" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main71" {
 domain_name = aws_elasticsearch_domain.example25.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example25.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main72" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example25.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main73" {
 role = aws_iam_role.example26.name
 policy_arn = aws_iam_policy.main72.arn
}

 resource "aws_elasticsearch_domain" "example26" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example26" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main74" {
 domain_name = aws_elasticsearch_domain.example26.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example26.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main75" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example26.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main76" {
 role = aws_iam_role.example27.name
 policy_arn = aws_iam_policy.main75.arn
}

 resource "aws_elasticsearch_domain" "example27" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example27" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main77" {
 domain_name = aws_elasticsearch_domain.example27.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example27.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main78" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example27.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main79" {
 role = aws_iam_role.example80.name
 policy_arn = aws_iam_policy.main78.arn
}

 resource "aws_elasticsearch_domain" "example80" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example80" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main81" {
 domain_name = aws_elasticsearch_domain.example80.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example80.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main82" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example80.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main83" {
 role = aws_iam_role.example84.name
 policy_arn = aws_iam_policy.main82.arn
}

 resource "aws_elasticsearch_domain" "example84" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example84" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main85" {
 domain_name = aws_elasticsearch_domain.example84.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example84.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main86" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example84.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main87" {
 role = aws_iam_role.example88.name
 policy_arn = aws_iam_policy.main86.arn
}

 resource "aws_elasticsearch_domain" "example88" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example88" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main89" {
 domain_name = aws_elasticsearch_domain.example88.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example88.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main90" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example88.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main91" {
 role = aws_iam_role.example92.name
 policy_arn = aws_iam_policy.main90.arn
}

 resource "aws_elasticsearch_domain" "example92" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example92" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main93" {
 domain_name = aws_elasticsearch_domain.example92.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example92.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main94" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example92.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main95" {
 role = aws_iam_role.example96.name
 policy_arn = aws_iam_policy.main94.arn
}

 resource "aws_elasticsearch_domain" "example96" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example96" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main97" {
 domain_name = aws_elasticsearch_domain.example96.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example96.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main98" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example96.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main99" {
 role = aws_iam_role.example100.name
 policy_arn = aws_iam_policy.main98.arn
}

 resource "aws_elasticsearch_domain" "example100" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example101" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main102" {
 domain_name = aws_elasticsearch_domain.example101.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example101.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_policy" "main103" {
 name = "tf-test"
 policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example101.arn}/*"
     }
   ]
 })
}

 resource "aws_iam_role_policy_attachment" "main104" {
 role = aws_iam_role.example105.name
 policy_arn = aws_iam_policy.main103.arn
}

 resource "aws_elasticsearch_domain" "example105" {
 domain_name = "tf-test"
 elasticsearch_version = "2.3"
}

 resource "aws_iam_role" "example106" {
 name = "tf-test"
 assume_role_policy = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {"Service": "es.amazonaws.com"},
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 })
}

 resource "aws_elasticsearch_domain_policy" "main107" {
 domain_name = aws_elasticsearch_domain.example106.domain_name
 access_policies = jsonencode({
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "es:*",
       "Effect": "Allow",
       "Condition": {
         "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
       },
       "Resource": "${aws_elasticsearch_domain.example106.arn}/*"
     }
   ]
 })
}

 resource "aws
