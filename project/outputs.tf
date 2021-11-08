output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_hostname" {
  value = module.ecs.alb_hostname
}