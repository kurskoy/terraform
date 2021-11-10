variable "environment" {
  type = string
}

variable "vpc_cidr" {
  description = "Cidr block for VPC"
  default = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs in region"
  default     = "2"
}