resource "aws_acm_certificate" "my_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]
}
resource "aws_route53_zone" "mycluster" {
  name = var.domain_name
}

resource "aws_route53_record" "mycluster" {
  zone_id = aws_route53_zone.mycluster.id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.my_cert.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      value = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.mycluster.id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

resource "aws_acm_certificate_validation" "my_cert_validation" {
  certificate_arn         = aws_acm_certificate.my_cert.arn
  validation_record_fqdns = [for dvo in aws_acm_certificate.my_cert.domain_validation_options : dvo.resource_record_name]
}

resource "null_resource" "wait_for_cert_validation" {
  provisioner "local-exec" {
    command = <<EOT
      CERT_ARN="${aws_acm_certificate.my_cert.arn}"
      STATUS=""

      while true; do
        STATUS=$(aws acm describe-certificate --certificate-arn "$CERT_ARN" --query "Certificate.Status" --output text)
        echo "Current status: $STATUS"
        if [ "$STATUS" = "ISSUED" ]; then
          echo "Certificate validated and issued."
          break
        fi
        echo "Waiting for certificate to be validated..."
        sleep 30  # Wait 30 seconds before re-checking
      done
    EOT
  }

  depends_on = [aws_acm_certificate.my_cert]  # Ensure this runs after certificate creation
}




output "certificate_arn" {
  value                   = aws_acm_certificate.my_cert.arn
}
