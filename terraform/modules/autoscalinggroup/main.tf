######## Creating Launch Configuration ########
resource "aws_launch_configuration" "medstick_prodlaunchconf" {
  name_prefix                 = var.name_prefix
  image_id                    = var.image_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = var.secgrpid
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}


######## Create Aws Autoscaling Group ########
resource "aws_autoscaling_group" "medstick_prodlaunchconf" {
  name             = "${aws_launch_configuration.medstick_prodlaunchconf.name}-asg"
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  health_check_type    = var.health_check_type
  load_balancers       = var.lbid
  launch_configuration = aws_launch_configuration.medstick_prodlaunchconf.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = var.subnetid
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}
