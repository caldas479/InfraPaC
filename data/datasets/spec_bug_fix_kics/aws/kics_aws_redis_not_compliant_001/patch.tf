resource "aws_elasticache_cluster" "positive1" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  engine_version       = "4.0.10"
  port                 = 6379
}
