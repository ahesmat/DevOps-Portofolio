resource "aws_instance" "k8s_masters" {
  count = var.master_count

  ami           = var.master_ami
  instance_type = var.master_instance_type
  key_name      = "k8s-master-${count.index + 1}"

  vpc_security_group_ids = [aws_security_group.k8s_sg.id]  # Corrected attribute
  subnet_id              = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "k8s-master-${count.index + 1}"
  }
}

resource "aws_instance" "k8s_workers" {
  count = var.worker_count

  ami           = var.worker_ami
  instance_type = var.worker_instance_type
  key_name      = "k8s-worker-${count.index + 1}"

  vpc_security_group_ids = [aws_security_group.k8s_sg.id]  # Corrected attribute
  subnet_id              = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "k8s-worker-${count.index + 1}"
  }
}

