provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "python-server"
    region  = "eu-central-1"
    key     = "terraform.tfstate"
  }
}

module "vpc" {
  source = "../modules/aws_network"
  environment = var.environment
}

module "security_groups" {
  source         = "../modules/aws_security"
  app_name       = var.app_name
  vpc_id         = module.vpc.vpc_id
  environment    = var.environment
  container_port = var.container_port
}

module "alb" {
  source              = "../modules/aws_alb"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnet_ids
  environment         = var.environment
  alb_security_groups = module.security_groups.alb
  health_check_path   = var.health_check_path
}

module "ecr" {
  source = "../modules/aws_ecr"
  environment = var.environment
  app_name = var.app_name
}

module "ecs" {
  source                      = "../modules/aws_ecs"
  aws_region                  = var.aws_region
  environment                 = var.environment
  app_name                    = var.app_name
  private_subnets             = module.vpc.private_subnet_ids
  app_count                   = var.app_count
  aws_alb_target_group        = module.alb.aws_alb_target_group_arn
  security_group              = module.security_groups.ecs_tasks
  aws_alb_listener            = module.alb.aws_alb_listener
  container_port              = var.container_port
  ecr_repository_url          = module.ecr.ecr_repository_url
  image_tag                   = var.image_tag
}