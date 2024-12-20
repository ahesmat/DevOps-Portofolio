resource "aws_instance" "my_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_pair_name
  security_groups = [var.sg_name]
  subnet_id       = var.subnet_id

  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
value = aws_instance.my_instance.id
}

output "instance_public_ip" {
value = aws_instance.my_instance.public_ip
}

output "instance_private_ip" {
value = aws_instance.my_instance.private_ip
}
