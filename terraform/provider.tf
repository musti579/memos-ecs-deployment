provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "memos-ecs-deployment"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}