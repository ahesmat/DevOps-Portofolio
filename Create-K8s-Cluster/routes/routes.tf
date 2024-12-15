# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "HA-K8s-Public-Route-Table"
  }
}

# Public Route: Route traffic to the Internet Gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}

# Route Table Associations for Public Subnets
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = var.public_subnet_1
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = var.public_subnet_2
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_3_association" {
  subnet_id      = var.public_subnet_3
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Tables
resource "aws_route_table" "private_route_table_1" {
  vpc_id = var.vpc_id

  tags = {
    Name = "HA-K8s-Private-Route-Table-1"
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = var.vpc_id

  tags = {
    Name = "HA-K8s-Private-Route-Table-2"
  }
}

resource "aws_route_table" "private_route_table_3" {
  vpc_id = var.vpc_id

  tags = {
    Name = "HA-K8s-Private-Route-Table-3"
  }
}

# Outputs for Route Tables
output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "private_route_table_1_id" {
  value = aws_route_table.private_route_table_1.id
}

output "private_route_table_2_id" {
  value = aws_route_table.private_route_table_2.id
}

output "private_route_table_3_id" {
  value = aws_route_table.private_route_table_3.id
}

