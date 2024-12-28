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


resource "aws_route53_record" "acm_validation" {
 for_each = toset(var.record_names)

  zone_id = aws_route53_zone.mycluster.id
  name    = each.key
  type    = "CNAME"
  ttl     = 60
  records = [var.record_values[lookup(var.record_names,each.key)]]
}
