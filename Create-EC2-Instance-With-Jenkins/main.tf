terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_security_group" "jenkins_sg" {
  name_prefix = "jenkins_sg"
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "tls_private_key" "jenkins_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "generated_key_pair" {
  key_name   = "jenkins_key"
  public_key = tls_private_key.jenkins_private_key.public_key_openssh
}
           
resource "aws_instance" "jenkins_server" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name = "jenkins_key"
  security_groups=[aws_security_group.jenkins_sg.name]

  tags = {
    Name = "Jenkins Server"
  }
}
output "login_string" {
  value = "ssh -i jenkins-key.pem ubuntu@${aws_instance.jenkins_server.public_ip}"
}
output "public_key" {
  value = tls_private_key.jenkins_private_key.public_key_openssh
}
resource "local_file" "private_key" {
  content  = tls_private_key.jenkins_private_key.private_key_pem
  filename = "jenkins-key.pem"
}
resource "local_file" "login_script" {
  filename = "login-to-created-instance.sh"
  content = <<EOT
chmod 400 jenkins-key.pem
ssh -o StrictHostKeyChecking=no -i jenkins-key.pem ubuntu@${aws_instance.jenkins_server.public_ip}
EOT
}
