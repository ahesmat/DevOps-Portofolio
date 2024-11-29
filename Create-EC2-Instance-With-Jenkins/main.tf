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

resource "local_file" "private_key" {
  content  = tls_private_key.jenkins_private_key.private_key_pem
  filename = "jenkins-key.pem"
}
           
resource "aws_instance" "jenkins_server" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name = "jenkins_key"
  security_groups=[aws_security_group.jenkins_sg.name]

  tags = {
    Name = "Jenkins Server"
  }
provisioner "remote-exec" {
  inline=[
  " echo '###############Installing Java###############################'",
  "sudo apt update -y",
  "sudo apt install openjdk-21-jdk -y",
  " echo '###############Installing Jenkins#############################'",
  "sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key",
  "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]' https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
  "sudo apt update -y",
  "sudo apt install jenkins -y",
  "sudo systemctl start jenkins && sudo systemctl enable jenkins",
  "echo '###############Printing Adminstrator Password##########################'",
  "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
  "echo '#######################################################################'"
  ]
}
 connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/cloud_user/DevOps-Basics/main/Create-EC2-Instance-With-Jenkins/jenkins-key.pem")
      timeout     = "4m"
   }
}
resource "local_file" "login_script" {
  filename = "login-to-created-instance.sh"
  content = <<EOT
chmod 400 jenkins-key.pem
ssh -o StrictHostKeyChecking=no -i ${local_file.private_key.filename} ubuntu@${aws_instance.jenkins_server.public_ip}
EOT
}
output "Jenkins-URL" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}
