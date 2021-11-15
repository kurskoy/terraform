variable "environment" {
  type = string
}

variable "app_name" {
  type = string
}

variable "public_subnets" {
  description = "Public Subnets"
}

variable "alb_security_groups" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  description = "Path to check if the service is healthy"
}