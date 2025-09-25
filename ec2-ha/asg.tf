resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = [var.tg_arn]
  name = "${var.unique_name}-asg"

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.unique_name}-webserver"
    propagate_at_launch = true
  }
}