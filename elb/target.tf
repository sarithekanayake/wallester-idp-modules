resource "aws_lb_target_group" "app_tg" {
  name     = "${var.unique_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    "Name" : "${var.unique_name}-tg"
  }
}