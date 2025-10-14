package terraform

# Subnets should not automatically assign public IPs unless they are DMZ subnets
deny contains msg if {
    subnet := input.resource.aws_subnet[_]
    subnet.map_public_ip_on_launch == true
    not contains(subnet.tags.Name, "public")
    not contains(subnet.tags.Name, "dmz")
    msg := sprintf("Subnet '%v' automatically assigns public IPs but is not marked as public/DMZ subnet", [subnet.tags.Name])
}
