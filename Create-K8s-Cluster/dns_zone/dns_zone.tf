resource "aws_route53_zone" "mycluster" {
  name = var.domain_name
}

output "zone_id" {
  value = aws_route53_zone.mycluster.id
  description = "The id of the Route 53 hosted zone."
}

output "domain_name" {
  value = aws_route53_zone.mycluster.name
  description = "The name of the Route 53 hosted zone."
}
