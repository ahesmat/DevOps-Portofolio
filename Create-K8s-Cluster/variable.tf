variable "node_count_masters" {
  description = "Number of master nodes"
  type        = number
  default     = 3
}

variable "node_count_workers" {
  description = "Number of worker nodes"
  type        = number
  default     = 8
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 3
}

variable "master_ami" {
  description = "AMI ID for master nodes"
  type        = string
  default     = "ami-0866a3c8686eaeeba"
}

variable "master_instance_type" {
  description = "Instance type for master nodes"
  type        = string
  default     = "t3.medium"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 8
}

variable "worker_ami" {
  description = "AMI ID for worker nodes"
  type        = string
  default     = "ami-0866a3c8686eaeeba"
}

variable "worker_instance_type" {
  description = "Instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "region" {
  description = "AWS region to deploy the infrastructure"
  type        = string
  default     = "us-west-2"
}

variable "key_pair_name" {
  description = "Name of the key pair to use for EC2 instances"
  type        = string
  default     = "k8s-keypair"
}

variable "availability_zones" {
  description = "List of Availability Zones for the cluster"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

