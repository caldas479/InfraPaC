resource "aws_db_instance" "main_db" {
  identifier             = "production-db"
  engine                 = "postgres"
  engine_version         = "14.7"
  instance_class         = "db.t3.medium"
  allocated_storage      = 100
  db_name                = "myapp"
  username               = "admin"
  password               = "change-me-later"
  publicly_accessible    = false
  vpc_security_group_ids = ["sg-12345678"]
  db_subnet_group_name   = "main-subnet-group"
  skip_final_snapshot    = true

  tags = {
    Environment = "Production"
  }
}