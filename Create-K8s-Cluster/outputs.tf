output "ansible_inventory" {
  value = <<EOT
[masters]
%{ for i, instance in aws_instance.k8s_masters }
${instance.public_ip} ansible_ssh_private_key_file=k8s-master-${i + 1}.pem
%{ endfor }

[workers]
%{ for i, instance in aws_instance.k8s_workers }
${instance.public_ip} ansible_ssh_private_key_file=k8s-worker-${i + 1}.pem
%{ endfor }
EOT
}

