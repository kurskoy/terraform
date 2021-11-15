resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-${var.environment}-cluster"
}

data "template_file" "app" {
  template          = file("../modules/aws_ecs/image.json")
  vars = {
    container_image = local.container_image
    container_port  = var.container_port
    fargate_cpu     = var.fargate_cpu
    fargate_memory  = var.fargate_memory
    aws_region      = var.aws_region
    environment     = var.environment
    app_name        = var.app_name
    image_tag       = var.image_tag
  }
}

resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = var.security_group
    subnets          = var.private_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.aws_alb_target_group
    container_name   = "${var.app_name}-${var.environment}-app"
    container_port   = var.container_port
  }
  depends_on = [var.aws_alb_listener, aws_iam_role.ecs_task_execution_role]
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.app_name}-${var.environment}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.app.rendered
}