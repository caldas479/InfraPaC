package terraform

# RDS instances should not be publicly accessible
deny contains msg if {
    rds := input.resource.aws_db_instance[_]
    rds.publicly_accessible == true
    msg := sprintf("RDS instance '%v' must not be publicly accessible. Set publicly_accessible to false.", [rds.identifier])
}
