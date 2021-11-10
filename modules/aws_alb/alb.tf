resource "aws_alb" "main" {
  name               = "${var.app_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = var.alb_security_groups
  enable_deletion_protection = false
  tags = {
    Name        = "${var.app_name}-${var.environment}-alb"
  }
}

resource "aws_alb_target_group" "main" {
  name        = "${var.app_name}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
  tags = {
    Name = "${var.app_name}-${var.environment}-tg"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }
}