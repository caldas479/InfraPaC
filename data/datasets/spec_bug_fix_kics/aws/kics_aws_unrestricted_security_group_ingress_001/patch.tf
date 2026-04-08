resource "aws_security_group_rule" "positive1" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["192.168.0.0/16"]
  security_group_id = aws_security_group.default.id
}
