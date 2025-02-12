variable "availability_zone" {
  description = "The availability zone where the EBS volume will be created"
  type        = string
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 5
}

variable "volume_type" {
  description = "The type of the EBS volume"
  type        = string
  default     = "gp2"
}

variable "volume_name" {
  description = "A tag to name the EBS volume"
  type        = string
}

variable "device_name" {
  description = "The device name to attach the volume"
  type        = string
  default     = "/dev/xvdf"
}

variable "instance_id" {
  description = "The ID of the instance to which the volume will be attached"
  type        = string
}

