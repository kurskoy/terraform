variable "environment" {
  type = string
}

variable "app_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "container_port" {
  type = string
}

variable "app_count" {
  type = string
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  default = "TaskRole"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "private_subnets" {
  type = list
}

variable "aws_alb_target_group" {
  type = string
}

variable "security_group" {
  type = list
}

variable "aws_alb_listener" {
  type = string
}

locals {
  container_image = format("%s:%s", var.ecr_repository_url, var.image_tag)
}