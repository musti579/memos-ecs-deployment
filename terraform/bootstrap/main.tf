terraform {
  required_version = "~> 1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.71"
    }
  }
}

provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Project   = "memos-ecs-deployment"
      ManagedBy = "terraform"
    }
  }
}

# S3 bucket that stores the Terraform state for the main config
resource "aws_s3_bucket" "tf_state" {
  bucket = "memos-ecs-tfstate-musti579"

  lifecycle {
    prevent_destroy = true
  }
}

# Keep old versions of the state file so a corrupted state can be rolled back
resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}