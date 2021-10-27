variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs in region"
  default     = "2"
}

variable "public_subnet_cidr" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidr" {
  default = [
    "10.0.11.0/24",
    "10.0.22.0/24"
  ]
}