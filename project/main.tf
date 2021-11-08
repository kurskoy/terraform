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
}

module "vpc" {
  source = "../modules/aws_network"
  environment = var.environment
}

module "ecr" {
    source = "../modules/aws_ecr"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    remote_state_bucket = var.bucket_name
    environment = var.environment
    app_name = var.app_name
}

module "ecs" {
    source = "../modules/aws_ecs"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    remote_state_bucket = var.bucket_name
    environment = var.environment
    app_name = var.app_name
    image_tag = var.image_tag
    ecr_repository_url = module.ecr.ecr_repository_url
    vpc_id = module.vpc.vpc_id
    public_subnets = concat(module.vpc.public_subnet_ids)
    private_subnets = concat(module.vpc.private_subnet_ids)
    taskdef_template = "${path.root}/../modules/aws_ecs/cb_app.json.tpl"
    app_count = var.app_count
}