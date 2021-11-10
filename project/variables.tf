variable "bucket_name" {
  default     = "python-server"
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
    default = "default"
}

variable "environment" {
    default = "dev"
}

variable "app_name" {
    default = "python-server"
}

variable "container_port" {
  default = 8000
}

variable "image_tag" {
    default = "latest"
}

variable "app_count" {
  default = 2
}

variable "health_check_path" {
  default     = "/"
}

