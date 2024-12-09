resource "tls_private_key" "master_keys" {
  count    = var.node_count_masters
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_private_key" "worker_keys" {
  count    = var.node_count_workers
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "master_keys" {
  count      = var.node_count_masters
  key_name   = "k8s-master-${count.index + 1}"
  public_key = tls_private_key.master_keys[count.index].public_key_openssh
}

resource "aws_key_pair" "worker_keys" {
  count      = var.node_count_workers
  key_name   = "k8s-worker-${count.index + 1}"
  public_key = tls_private_key.worker_keys[count.index].public_key_openssh
}

