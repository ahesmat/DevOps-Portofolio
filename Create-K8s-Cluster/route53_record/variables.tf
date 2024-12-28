variable "domain_name" {
 description = "domin_name"
 type = string
}

variable "lb_dns_name" {
 description = "lb_dns_name"
 type = string
}

variable "lb_zone_id" {
 description = "lb_zone_id"
 type = string
}

variable "record_names" {
 description = "List of DNS record names for ACM validation"
 type = list(string)
}

variable "record_values" {
 description = "List of DNS record values for ACM validation"
 type = list(string)
}
