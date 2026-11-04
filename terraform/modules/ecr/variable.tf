variable "name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "force_delete" {
  description = "Allow terraform destroy to delete the repo even if it contains images"
  type        = bool
  default     = false
}