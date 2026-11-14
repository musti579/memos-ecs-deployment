output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "app_url" {
  value = "https://${module.acm.fqdn}"
}