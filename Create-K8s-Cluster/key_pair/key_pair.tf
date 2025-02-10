resource "tls_private_key" "cluster_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "generated_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.cluster_private_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.cluster_private_key.private_key_pem
  filename = var.file_name

  lifecycle {
    ignore_changes = [content] # Prevent overwriting if file already exists
  }
}

output "key_name" {
  value = aws_key_pair.generated_key_pair.key_name
}

output "file_name" {
  value = local_file.private_key.filename
    }
