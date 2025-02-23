#DNS Configuration
#Create a Route53 hosted zone with my domain name
resource "aws_route53_zone" "jenkins-hosted-zone" {
  provider = aws.region-master
  name     = var.dns-name
}

#Create record in hosted zone for ACM Certificate Domain Verification
resource "aws_route53_record" "cert_validation" {
  provider = aws.region-master
  for_each = {
    for val in aws_acm_certificate.jenkins-lb-https.domain_validation_options : val.domain_name => {
      name   = val.resource_record_name
      record = val.resource_record_value
      type   = val.resource_record_type
    }
  }
  name    = each.value.name
  records  = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = aws_route53_zone.jenkins-hosted-zone.id
}

#Create Alias record towards ALB from Route53
resource "aws_route53_record" "jenkins" {
  provider = aws.region-master
  zone_id  = aws_route53_zone.jenkins-hosted-zone.id
  name     = join(".", ["jenkins", var.dns-name])
  type     = "A"
  alias {
    name                   = aws_lb.application-lb.dns_name
    zone_id                = aws_lb.application-lb.zone_id
    evaluate_target_health = true
  }
}


