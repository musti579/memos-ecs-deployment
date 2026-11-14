variable "domain_name" {
  description = "Full domain for the app and certificate, e.g. memos.example.com"
  type        = string
}

variable "zone_name" {
  description = "Existing Route 53 hosted zone, e.g. example.com"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name to point the record at"
  type        = string
}

variable "alb_zone_id" {
  description = "The ALB's own hosted zone ID (needed for alias records)"
  type        = string
}