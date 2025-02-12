resource "aws_instance" "jumpbox_server" {
  ami             = "ami-0866a3c8686eaeeba"
  instance_type   = "t2.micro"
  key_name        = "cluster_key"
  security_groups = [aws_security_group.jump_sg.name]
  subnet_id       = aws_subnet.public_subnet_1.id

  tags = {
    Name = "Jump Server"
  }
  provisioner "remote-exec" {
    inline = [
      " echo '###############Installing ANSIBLE###############################'",
      "sudo apt update -y",
      "sudo apt install software-properties-common -y ",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "echo '#######################################################################'"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/cloud_user/DevOps-Portofolio/Create-K8s-Cluster/cluster-key.pem")
    timeout     = "4m"
  }
}
resource "local_file" "login_script" {
  filename = "login-to-created-instance.sh"
  content  = <<EOT
chmod 400 cluster-key.pem
ssh -o StrictHostKeyChecking=no -i ${local_file.private_key.filename} ubuntu@${aws_instance.jumpbox_server.public_ip}
EOT
}


