package kubernetes

deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits.cpu
    msg := sprintf(
        "Container '%v' in Deployment '%v' must define a CPU limit",
        [container.name, input.metadata.name],
    )
}

deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits.memory
    msg := sprintf(
        "Container '%v' in Deployment '%v' must define a memory limit",
        [container.name, input.metadata.name],
    )
}
