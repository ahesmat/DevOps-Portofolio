resource "aws_acm_certificate" "my_cert" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.my_cert.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      value = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

resource "aws_acm_certificate_validation" "my_cert_validation" {
  certificate_arn         = aws_acm_certificate.my_cert.arn
  validation_record_fqdns = [for dvo in aws_acm_certificate.my_cert.domain_validation_options : dvo.resource_record_name]
}

output "certificate_arn" {
  value                   = aws_acm_certificate.my_cert.arn
}
