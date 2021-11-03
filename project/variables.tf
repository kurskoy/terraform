variable "bucket_name" {
  type        = string
  description = "S3 Bucket name"
  default     = "python-server"
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_profile" {
    default = "default"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "app_name" {
    type = string
    default = "python-server"
}