resource "aws_security_group" "alb" {
  name        = "${var.app_name}-${var.environment}-alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.app_name}-${var.environment}-alb-sg"
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${var.app_name}-${var.environment}-tasks-sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.app_name}-${var.environment}-tasks-sg"
  }
}