######## Creating Security Group for Load Balancer ########

resource "aws_security_group" "medstick_prodlbsg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ######## Inbound Rules ########
  ######## HTTP access from anywhere ########
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ######## HTTPS access from anywhere ########
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ######## SSH access from anywhere ########
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ######## Outbound Rules ########
  ######## Internet access to anywhere ########
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.terratag_added_main
}

######## Creating Load Balancer ########
resource "aws_elb" "medstick_prodelb" {
  name = var.lb_name
  security_groups = [
    "${aws_security_group.medstick_prodlbsg.id}"
  ]
  subnets                   = var.subnets
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    target              = "HTTP:80/"
  }
  listener {
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
  }
  tags = local.terratag_added_main
}


locals {
  terratag_added_main = { "Project" = "Medstick", "Project_Manager" = "Vrusha", "Purpose" = "Prod", "created_by" = "priyanka.pradhan@nineleaps.com", "environment_id" = "prod" }
}

