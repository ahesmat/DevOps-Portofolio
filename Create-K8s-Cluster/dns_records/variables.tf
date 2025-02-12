variable "zone_id" {
 description = "The dns zone id"
 type        = string
}

variable "name" {
 description = "The FQDN that needs to be resolved"
 type        = string
}

variable "lb_dns_name" {
 description = "The loadbalancer dns name" 
 type        = string
}

variable "lb_zone_id" {
 description = "The load balancer zone id"
 type        = string
}




