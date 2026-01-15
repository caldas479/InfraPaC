resource "aws_ecs_task_definition" "service" {
family = "service"
container_definitions = file("task-definitions/service.json")
volume {
name = "service-storage"
efs_volume_configuration {
file_system_id = aws_efs_file_system.fs.id
root_directory = "/opt/data"
transit_encryption = "ENABLED"
authorization_config {
iam = "ENABLED"
}
}
}
}
