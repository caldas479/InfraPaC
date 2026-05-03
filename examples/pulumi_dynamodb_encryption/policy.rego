package pulumi

deny contains msg if {
    table := input.resources["aws:dynamodb/table:Table"][name]
    not table.serverSideEncryption.enabled
    msg := sprintf(
        "DynamoDB table '%v' must have server-side encryption enabled",
        [name],
    )
}
