provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "python-server"
    region  = "eu-central-1"
    key     = "state"
  }
  required_providers {
    aws = {
      version = "~> 3.35"
    }
  }
}

module "s3_terraform_state" {
  source = "../modules/aws_s3"
  bucket_name = var.bucket_name
}

module "ecr" {
    source = "../modules/aws_ecr"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    remote_state_bucket = var.bucket_name
    environment = var.environment
    app_name = var.app_name
}

module "vpc" {
  source = "../modules/aws_network"
  env = var.environment
}