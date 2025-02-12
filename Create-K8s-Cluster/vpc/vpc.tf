resource "aws_vpc" "ha_cluster_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "HA-K8s-VPC"
  }
}

resource "aws_internet_gateway" "ha_cluster_igw" {
  vpc_id = aws_vpc.ha_cluster_vpc.id

  tags = {
    Name = "HA-K8s-Internet-Gateway"
  }
}

output "vpc_id" {
  value = aws_vpc.ha_cluster_vpc.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.ha_cluster_igw.id
}

