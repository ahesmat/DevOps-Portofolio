variable "lb_arn" {
  description  = "arn of loadbalancer"
  type         =  string
}

variable "port" {
  description  = "listener port"
  type         = number
}

variable "cert_arn" {
  description  = "arn of certificate"
  type         = string
}


variable "tg_arn" {
  description  = "arn of target group"
  type         =  string
}
