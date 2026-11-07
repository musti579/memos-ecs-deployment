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
}