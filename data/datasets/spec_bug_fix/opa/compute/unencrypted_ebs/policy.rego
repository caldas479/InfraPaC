package terraform

# EBS volumes must be encrypted at rest
deny contains msg if {
    instance := input.resource.aws_instance[_]
    instance.ebs_block_device
    ebs_block := instance.ebs_block_device
    not ebs_block.encrypted
    msg := sprintf("EC2 instance '%v' has unencrypted EBS volume on device '%v'", [instance.tags.Name, ebs_block.device_name])
}

# Also catch if encrypted field is explicitly set to false
deny contains msg if {
    instance := input.resource.aws_instance[_]
    instance.ebs_block_device
    ebs_block := instance.ebs_block_device
    ebs_block.encrypted == false
    msg := sprintf("EC2 instance '%v' has unencrypted EBS volume on device '%v'", [instance.tags.Name, ebs_block.device_name])
}
