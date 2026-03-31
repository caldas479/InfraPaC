module "db" {
	 source = "terraform-aws-modules/rds/aws"
	 version = "~> 3.0"

	 identifier = "demodb"

	 engine = "mysql"
	 engine_version = "5.7.19"
	 instance_class = "db.t2.large"
	 allocated_storage = 5
	 auto_minor_version_upgrade = true
	 backup_retention_period =  0

	 name = "demodb"
	 username = "user"
	 password = "YourPwdShouldBeLongAndSecure!"
	 port = "3306"

	 iam_database_authentication_enabled = true

	 vpc_security_group_ids = ["sg-12345678"]

	 maintenance_window = "Mon:00:00-Mon:03:00"
	 backup_window = "03:00-06:00"

	 # Enhanced Monitoring - see example for details on how to create the role by yourself, in case you don't want to create it automatically
	 monitoring_interval = "30"
	 monitoring_role_name = "MyRDSMonitoringRole"
	 create_monitoring_role = true

	 tags = {
		 Owner = "user"
		 Environment = "dev"
	 }

	 # DB subnet group
	 subnet_ids = ["subnet-12345678", "subnet-87654321"]

	 # DB parameter group
	 family = "mysql5.7"

	 # DB option group
	 major_engine_version = "5.7"

	 # Database Deletion Protection
	 deletion_protection = true

	 parameters = [
		 {
			 name = "character_set_client"
			 value = "utf8mb4"
		 },
		 {
			 name = "character_set_server"
			 value = "utf8mb4"
		 }
	 ]

	 options = [
		 {
			 option_name = "MARIADB_AUDIT_PLUGIN"
			 option_settings = [
				 {
					 name  = "SERVER_AUDIT_EVENTS"
					 value = "CONNECT"
				 },
				 {
					 name  = "SERVER_AUDIT_FILE_ROTATIONS"
					 value = "37"
				 }
			 ]
		 },
	 ]

	 # DB subnet group
	 subnet_ids = ["subnet-12345678", "subnet-87654321"]

	 # DB parameter group
	 family = "mysql5.7"

	 # DB option group
	 major_engine_version = "5.7"

	 # Database Deletion Protection
	 deletion_protection = true

	 parameters = [
		 {
			 name = "character_set_client"
			 value = "utf8mb4"
		 },
		 {
			 name = "character_set_server"
			 value = "utf8mb4"
		 }
	 ]

	 options = [
		 {
			 option_name = "MARIADB_AUDIT_PLUGIN"
			 option_settings = [
				 {
					 name  = "SERVER_AUDIT_EVENTS"
					 value = "CONNECT"
				 },
				 {
					 name  = "SERVER_AUDIT_FILE_ROTATIONS"
					 value = "37"
				 }
			 ]
		 },
	 ]

	 # DB subnet group
	 subnet_ids = ["subnet-12345678", "subnet-87654321"]

	 # DB parameter group
	 family = "mysql5.7"

	 # DB option group
	 major_engine_version = "5.7"

	 # Database Deletion Protection
	 deletion_protection = true

	 parameters = [
		 {
			 name = "character_set_client"
			 value = "utf8mb4"
		 },
		 {
			 name = "character_set_server"
			 value = "utf8mb4"
		 }
	 ]

	 options = [
		 {
			 option_name = "MARIADB_AUDIT_PLUGIN"
			 option_settings = [
				 {
					 name  = "SERVER_AUDIT_EVENTS"
					 value = "CONNECT"
				 },
				 {
					 name  = "SERVER_AUDIT_FILE_ROTATIONS"
					 value = "37"
				 }
			 ]
		 },
	 ]

	 # DB subnet group
	 subnet_ids = ["subnet-12345678", "subnet-87654321"]

	 # DB parameter group
	 family = "mysql5.7"

	 # DB option group
	 major_engine_version = "5.7"

	 # Database Deletion Protection
	 deletion_protection = true

	 parameters = [
		 {
			 name = "character_set_client"
			 value = "utf8mb4"
		 },
		 {
			 name = "character_set_server"
			 value = "utf8mb4"
		 }
	 ]

	 options = [
		 {
			 option_name = "MARIADB_AUDIT_PLUGIN"
			 option_settings = [
				 {
					 name  = "SERVER_AUDIT_EVENTS"
					 value = "CONNECT"
				 },
				 {
					 name  = "SERVER_AUDIT_FILE_ROTATIONS"
					 value = "37"
				 }
			 ]
		 },
	 ]

	 # DB subnet group
	 subnet_ids = ["subnet-12345678", "subnet-87654321"]

	 # DB parameter group
	 parameter_group_name = "default.mysql5.7"

	 # DB security group
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB subnet group
	 db_subnet_group_name = "default"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB instance class
	 db_instance_class = "db.t2.micro"

	 # DB allocated storage
	 allocated_storage = 20

	 # DB instance identifier
	 db_instance_identifier = "my-db-instance"

	 # DB username
	 db_username = "admin"

	 # DB password
	 db_password = "Str0ngP4ssw0rd"

	 # DB port
	 db_port = 3306

	 # DB subnet group name
	 db_subnet_group_name = "default"

	 # DB security group name
	 vpc_security_group_ids = ["sg-12345678"]

	 # DB parameter group name
	 parameter_group_name = "default.mysql5.7"

	 # DB engine
	 db_engine = "mysql"

	 # DB engine version
	 engine_version = "5.7.23"

	 # DB
