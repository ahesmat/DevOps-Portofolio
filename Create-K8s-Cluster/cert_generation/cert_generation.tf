resource "aws_acm_certificate" "my_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]
}



output "record_name" {
  value = [for option in aws_acm_certificate.my_cert.domain_validation_options : option.resource_record_name]
}

output "record_value" {
  value = [for option in aws_acm_certificate.my_cert.domain_validation_options : option.resource_record_value]
}

output "domain_name" {
 value = aws_acm_certificate.my_cert.domain_name
}
