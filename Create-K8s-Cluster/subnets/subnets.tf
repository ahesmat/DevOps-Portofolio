# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "HA-K8s-Public-Subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "HA-K8s-Public-Subnet-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.32.0/20"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "HA-K8s-Public-Subnet-3"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.48.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "HA-K8s-Private-Subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.64.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "HA-K8s-Private-Subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.80.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "HA-K8s-Private-Subnet-3"
  }
}

# Outputs for Subnets
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "public_subnet_3_id" {
  value = aws_subnet.public_subnet_3.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "private_subnet_3_id" {
  value = aws_subnet.private_subnet_3.id
}

