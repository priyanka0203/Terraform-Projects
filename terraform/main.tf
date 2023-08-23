########creating VPC #############
resource "aws_vpc" "demovpc-terraform" {
   cidr_block       = "${var.vpc_cidr}"
   instance_tenancy = "default"
tags = {
   Name = "Demo VPC"
 }
}

#### Creating internet gateway###########
resource "aws_internet_gateway" "demogateway-terraform" {
  vpc_id = "${aws_vpc.demovpc-terraform.id}"
}

######creating subnet#################

# Creating 1st subnet 
resource "aws_subnet" "demosubnet-terraform" {
  vpc_id                  = "${aws_vpc.demovpc-terraform.id}"
  cidr_block             = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Demo subnet"
  }
}
# Creating 2nd subnet 
resource "aws_subnet" "demosubnet1-terraform" {
  vpc_id                  = "${aws_vpc.demovpc-terraform.id}"
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    Name = "Demo subnet 1"
  }
}


########creating routetable############

resource "aws_route_table" "route-terraform" {
  vpc_id = "${aws_vpc.demovpc-terraform.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.demogateway-terraform.id}"
    }
  tags = {
      Name = "Route to internet"
    } 
}
resource "aws_route_table_association" "rt1-terraform" {
  subnet_id = "${aws_subnet.demosubnet-terraform.id}"
  route_table_id = "${aws_route_table.route-terraform.id}"
}
resource "aws_route_table_association" "rt2" {
  subnet_id = "${aws_subnet.demosubnet1-terraform.id}"
  route_table_id = "${aws_route_table.route-terraform.id}"
}


####creating sg for load balancer ###############

resource "aws_security_group" "demosg1-terraform" {
  name        = "Demo Security Group"
  description = "Demo Module"
  vpc_id      = "${aws_vpc.demovpc-terraform.id}"

# Inbound Rules
# HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
# HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
# SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
# Outbound Rules
# Internet access to anywhere
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

###########creating load balancer##########

resource "aws_elb" "web_elb-terraform" {
name = "web-elb"
security_groups = [
  "${aws_security_group.demosg1-terraform.id}"
]
subnets = [
  "${aws_subnet.demosubnet-terraform.id}",
  "${aws_subnet.demosubnet1-terraform.id}"
]
cross_zone_load_balancing   = true
health_check {
  healthy_threshold = 2
  unhealthy_threshold = 2
  timeout = 3
  interval = 30
  target = "HTTP:80/"
}
listener {
  lb_port = 80
  lb_protocol = "http"
  instance_port = "80"
  instance_protocol = "http"
}
}

#######creating launch configuration##########
resource "aws_launch_configuration" "web-terraform" {
  name_prefix = "web-terraform-"
  image_id = "ami-0f5ee92e2d63afc18" 
  instance_type = "t2.micro"
  key_name = "Medstick_be_prod"
  security_groups = [ "${aws_security_group.demosg1-terraform.id}" ]
  associate_public_ip_address = true

lifecycle {
  create_before_destroy = true
}
}



#######create aws autoscalin group #############

resource "aws_autoscaling_group" "web-terraform" {
  name = "${aws_launch_configuration.web-terraform.name}-asg"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 2

  health_check_type    = "ELB"
  load_balancers = [
    "${aws_elb.web_elb-terraform.id}"
  ]
launch_configuration = "${aws_launch_configuration.web-terraform.name}"
enabled_metrics = [
  "GroupMinSize",
  "GroupMaxSize",
  "GroupDesiredCapacity",
  "GroupInServiceInstances",
  "GroupTotalInstances"
]
metrics_granularity = "1Minute"
vpc_zone_identifier  = [
  "${aws_subnet.demosubnet-terraform.id}",
  "${aws_subnet.demosubnet1-terraform.id}"
]
# Required to redeploy without an outage.
lifecycle {
  create_before_destroy = true
}
tag {
  key                 = "Name"
  value               = "web"
  propagate_at_launch = true
}
}


