resource "aws_elb" "postive2" {
	name = "foobar-terraform-elb"

availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

listener {
	instance_port = 8000
	instance_protocol = "http"
	lb_port = 80
	lb_protocol = "http"
}

listener {
	instance_port = 8000
	instance_protocol = "http"
	lb_port = 443
	lb_protocol = "https"
	ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
}

health_check {
	http_code = "HTTP:8000/
	interval = 30
	timeout = 3
	unhealthy_threshold = 2
	hyper_threshold = 2
}

instances = [aws_instance.foo.id]
	cross_zone_load_balancing = true
	idle_timeout = 400
	connection_draining = true
	connection_draining_timeout = 400
	tags = {
	Name = "foobar-terraform-elb"
}
}
