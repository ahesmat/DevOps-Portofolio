variable "subnet_1" {
 description = "The ID of  Subnet 1"
 type        = string
}

variable "subnet_2" {
 description = "The ID of  Subnet 2"
 type        = string
}

variable "subnet_3" {
 description = "The ID of Subnet 3"
 type        = string
}

variable "elb_sg" {
 description = "The ID of elb_sg"
 type        = string
}

variable "vpc_id" {
 description = "The ID of vpc"
 type        = string
}


variable "lb_name" {
 description = "The ID of vpc"
 type        = string
}


variable "tg_name" {
 description = "The ID of vpc"
 type        = string
}

variable "port" {
 description = "port number"
 type        = number
}

variable "protocol" {
 description = "protocol"
 type        = string
}

variable "path" {
 description = "healthcheck path"
 type        = string
}

