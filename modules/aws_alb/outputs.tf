output "aws_alb_target_group_arn" {
  value = aws_alb_target_group.main.arn
}

output "app_url" {
  value = aws_alb.main.dns_name
}

output "aws_alb_listener" {
  value = aws_alb_listener.http.id
}