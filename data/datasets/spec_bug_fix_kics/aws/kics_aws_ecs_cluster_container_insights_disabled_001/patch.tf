resource "aws_ecs_cluster" "white-hart" {
	name = "white-hart"

	setting {
		name  = "containerInsights"
		value = "enabled"
	}
}
