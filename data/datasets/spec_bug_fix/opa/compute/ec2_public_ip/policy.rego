package terraform

# EC2 instances should not have public IPs unless explicitly required
deny contains msg if {
    instance := input.resource.aws_instance[_]
    instance.associate_public_ip_address == true
    msg := sprintf("EC2 instance '%v' should not have a public IP address assigned. Use a bastion host or VPN instead.", [instance.tags.Name])
}
