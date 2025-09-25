output "sg_elb_id" {
  value = aws_security_group.alb_sg.id
}

output "dns" {
  value = aws_lb.load_balancer.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}