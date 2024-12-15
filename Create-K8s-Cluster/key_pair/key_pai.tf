resource "tls_private_key" "cluster_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "generated_key_pair" {
  key_name   = "cluster_key"
  public_key = tls_private_key.cluster_private_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.cluster_private_key.private_key_pem
  filename = "cluster-key.pem"
}
