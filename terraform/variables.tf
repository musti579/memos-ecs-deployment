variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "Domain for the app"
  type        = string
  default     = "memos.mustafaabukars.com"
}

variable "zone_name" {
  description = "Existing Route 53 hosted zone"
  type        = string
  default     = "mustafaabukars.com"
}