resource "aws_db_instance" "analytics_db" {
  identifier             = "analytics-database"
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = "db.r5.large"
  allocated_storage      = 500
  db_name                = "analytics"
  username               = "admin"
  password               = "SecurePassword123!"
  publicly_accessible    = false
  vpc_security_group_ids = ["sg-87654321"]
  db_subnet_group_name   = "analytics-subnet-group"
  skip_final_snapshot    = true

  tags = {
    Environment = "Production"
    Service     = "Analytics"
  }
}
