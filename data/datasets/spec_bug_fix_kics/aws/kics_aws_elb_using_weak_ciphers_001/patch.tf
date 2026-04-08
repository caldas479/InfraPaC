resource "aws_elb" "wu-tang" {
	name = "wu-tang"
	vpc_id = aws_vpc.main.id
	subnets = [for s in aws_subnet.public: s.id]
	zones = [for s in aws_subnet.public: s.availability_zone]
}

resource "aws_elb_backend_server_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	instance_port = 443
	policy_names = [aws_load_balancer_policy.wu-tang-root-ca-backend-auth-policy.policy_name]
}

resource "aws_elb_listener_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	load_balancer_port = 443
	policy_names = [aws_load_balancer_policy.wu-tang-ssl.policy_name]
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-pubkey-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-pubkey-policy"
	type_name = "PublicKeyPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-ssl"
	type_name = "SSLNegotiationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-root-ca-backend-auth-policy" {
	load_balancer_name = aws_elb.wu-tang.name
	policy_name = "wu-tang-root-ca-backend-auth-policy"
	type_name = "BackendServerAuthenticationPolicyType"
}

resource "aws_load_balancer_policy" "wu-tang-ssl" {
	load_balancer
