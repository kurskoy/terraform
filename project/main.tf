provider "aws" {
  region = "eu-central-1"
  profile = "default"
}

module "vpc-dev" {
  source = "../modules/aws_network"
  env = "dev"
}

module "vpc-prod" {
  source = "../modules/aws_network"
  env = "prod"
}

#module "ecr" {
#  source = "../modules/aws_ecr"
#}