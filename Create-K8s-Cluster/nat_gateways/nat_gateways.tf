# NAT Gateway for Public Subnet 1
resource "aws_eip" "nat_1_eip" {
  vpc = true

  tags = {
    Name = "HA-K8s-NAT-EIP-1"
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_1_eip.id
  subnet_id     = var.public_subnet_1

  tags = {
    Name = "HA-K8s-NAT-Gateway-1"
  }
}

# NAT Gateway for Public Subnet 2
resource "aws_eip" "nat_2_eip" {
  vpc = true

  tags = {
    Name = "HA-K8s-NAT-EIP-2"
  }
}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.nat_2_eip.id
  subnet_id     = var.public_subnet_2

  tags = {
    Name = "HA-K8s-NAT-Gateway-2"
  }
}

# NAT Gateway for Public Subnet 3
resource "aws_eip" "nat_3_eip" {
  vpc = true

  tags = {
    Name = "HA-K8s-NAT-EIP-3"
  }
}

resource "aws_nat_gateway" "nat_gateway_3" {
  allocation_id = aws_eip.nat_3_eip.id
  subnet_id     = var.public_subnet_3

  tags = {
    Name = "HA-K8s-NAT-Gateway-3"
  }
}

# Associate NAT Gateways with Private Route Tables
resource "aws_route" "private_route_1" {
  route_table_id         = var.private_route_table_1
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id
}

resource "aws_route" "private_route_2" {
  route_table_id         = var.private_route_table_2
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_2.id
}

resource "aws_route" "private_route_3" {
  route_table_id         = var.private_route_table_3
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_3.id
}

# Outputs for NAT Gateways
output "nat_gateway_1_id" {
  value = aws_nat_gateway.nat_gateway_1.id
}

output "nat_gateway_2_id" {
  value = aws_nat_gateway.nat_gateway_2.id
}

output "nat_gateway_3_id" {
  value = aws_nat_gateway.nat_gateway_3.id
}

