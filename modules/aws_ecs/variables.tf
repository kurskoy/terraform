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

variable "aws_alb_target_group_arn" {
  description = "ARN of the alb target group"
}

variable "app_count" {
  type = string
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "container_image" {
  description = "Docker image to be launched"
}

variable "health_check_path" {
  default = "/"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "private_subnets" {
  description = "Private Subnets"
}

variable "ecs_service_security_groups" {
  description = "Security Groups"
}