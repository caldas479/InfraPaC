package terraform

# RDS instances must have encryption at rest enabled
deny contains msg if {
    rds := input.resource.aws_db_instance[_]
    not rds.storage_encrypted
    msg := sprintf("RDS instance '%v' must have storage encryption enabled. Set storage_encrypted to true.", [rds.identifier])
}
