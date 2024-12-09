resource "aws_security_group" "k8s_sg" {
  name        = "k8s-sg"
  description = "Security Group for Kubernetes Cluster"
  vpc_id      = aws_vpc.k8s_vpc.id

  # Allows SSH access (port 22) only from within the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows SSH access from within the VPC
  }

  # Allows Kubernetes API (port 6443) communication from within the VPC
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows Kubernetes API communication from within the VPC
  }

  # Allows Kubelet API (port 10250) communication from within the VPC
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows Kubelet API communication from within the VPC
  }

  # Allows communication for NodePort services (default range)
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows NodePort services
  }

  # Allows communication for Kubernetes etcd (port 2379-2380) and control plane services
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows etcd communication (for master nodes)
  }

  # Allows communication for Kubernetes scheduler (port 10251)
  ingress {
    from_port   = 10251
    to_port     = 10251
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows scheduler communication
  }

  # Allows communication for Kubernetes controller manager (port 10252)
  ingress {
    from_port   = 10252
    to_port     = 10252
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows controller manager communication
  }

  # Allows internal DNS communication (port 53, UDP)
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows DNS queries within the VPC
  }

  # Allows internal CNI communication for network plugins (port 4789, UDP - for Flannel)
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows Flannel network communication
  }

  # Allows communication for the Kubernetes Metrics Server (port 4443)
  ingress {
    from_port   = 4443
    to_port     = 4443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allows Metrics API communication within the VPC
  }

  # Allows all outbound traffic (default behavior)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

