output "certificate_arn" {
  # Comes from the validation resource, so anything using it waits for a valid certificate
  value = aws_acm_certificate_validation.main.certificate_arn
}

output "fqdn" {
  value = aws_route53_record.app.fqdn
}