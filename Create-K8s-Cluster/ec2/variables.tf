variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance generated"
  type        = string
}

variable "key_pair_name" {
  description = "The name of the key_pair"
  type        = string
}

variable "sg_name" {
  description = "Security_Group_Id"
  type        = string
}

variable "subnet_id" {
  description = "Subnet_Id"
  type        = string
}
