variable "name" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC to create the ALB and target group in"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets for the ALB (at least two AZs)"
  type        = list(string)
}

variable "app_port" {
  description = "Port the app listens on inside the container"
  type        = number
  default     = 8081
}

variable "health_check_path" {
  description = "Path the ALB checks to decide if a task is healthy"
  type        = string
  default     = "/"
}