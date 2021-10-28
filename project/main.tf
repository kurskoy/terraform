provider "aws" {
  region = "eu-central-1"
  profile = "default"
}

module "vpc" {
  source = "../modules/aws_network"
}

module "ecr" {
  source = "../modules/aws_ecr"
}