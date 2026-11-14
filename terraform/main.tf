module "vpc" {
  source = "./modules/vpc"

  name                 = "memos"
  region               = var.aws_region
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["eu-north-1a", "eu-north-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
}

module "ecr" {
  source = "./modules/ecr"

  name         = "memos"
  force_delete = true
}

module "alb" {
  source = "./modules/alb"

  name              = "memos"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = module.acm.certificate_arn 
  
}

module "ecs" {
  source = "./modules/ecs"

  name                  = "memos"
  region                = var.aws_region
  image                 = "${module.ecr.repository_url}:v1"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn

  depends_on = [module.alb]
}

module "acm" {
  source = "./modules/acm"

  domain_name  = var.domain_name
  zone_name    = var.zone_name
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  
}