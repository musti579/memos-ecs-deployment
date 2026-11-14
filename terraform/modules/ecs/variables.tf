variable "name" {
  description = "Prefix for resource names"
  type        = string
}

variable "region" {
  description = "AWS region, used for the CloudWatch log configuration"
  type        = string
}

variable "image" {
  description = "Full image URI including the tag"
  type        = string
}

variable "vpc_id" {
  description = "VPC for the task security group"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets to run the tasks in"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB security group allowed to reach the tasks"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group the service registers tasks with"
  type        = string
}

variable "app_port" {
  description = "Port the app listens on inside the container"
  type        = number
  default     = 8081
}

variable "cpu" {
  description = "Task CPU units (256 = 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task memory in MiB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of tasks to keep running"
  type        = number
  default     = 1
}