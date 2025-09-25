resource "aws_lb" "load_balancer" {
  name               = "${var.unique_name}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]
}