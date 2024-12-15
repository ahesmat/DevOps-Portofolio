# Security Group for ELB
resource "aws_security_group" "elb_sg" {
  name        = "HA-K8s-ELB-SG"
  description = "Allow traffic to the ELB"
  vpc_id      = aws_vpc.ha_cluster_vpc.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HA-K8s-ELB-SG"
  }
}

# Security Group for Master Nodes
resource "aws_security_group" "master_sg" {
  name        = "HA-K8s-Master-SG"
  description = "Allow traffic to Kubernetes Master Nodes"
  vpc_id      = aws_vpc.ha_cluster_vpc.id

  ingress {
    description = "Allow communication from ELB to master nodes"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Allow communication within master nodes"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Allow communication from worker nodes"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Allow SSH access from nodes inside the VPC"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HA-K8s-Master-SG"
  }
}

# Security Group for Worker Nodes
resource "aws_security_group" "worker_sg" {
  name        = "HA-K8s-Worker-SG"
  description = "Allow traffic to Kubernetes Worker Nodes"
  vpc_id      = aws_vpc.ha_cluster_vpc.id

  ingress {
    description = "Allow communication from master nodes"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Allow communication within worker nodes"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Allow SSH access from nodes inside the VPC"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }


  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HA-K8s-Worker-SG"
  }
}

# Security Group for Jump Servers
resource "aws_security_group" "jump_sg" {
  name        = "HA-K8s-Jump-SG"
  description = "Allow traffic to Jump Server"
  vpc_id      = aws_vpc.ha_cluster_vpc.id

  ingress {
    description = "Allow communication from outside the cluster"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HA-K8s-Jump-SG"
  }
}
