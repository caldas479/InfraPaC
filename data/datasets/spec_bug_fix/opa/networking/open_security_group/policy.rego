package terraform

# Security groups should not allow unrestricted ingress (0.0.0.0/0) on sensitive ports
deny contains msg if {
    sg := input.resource.aws_security_group[_]
    ingress := sg.ingress[_]
    ingress.cidr_blocks[_] == "0.0.0.0/0"
    sensitive_ports := [22, 3389, 3306, 5432, 1433, 27017]
    port := ingress.from_port
    port == sensitive_ports[_]
    msg := sprintf("Security group '%v' allows unrestricted access (0.0.0.0/0) on sensitive port %v", [sg.name, port])
}
