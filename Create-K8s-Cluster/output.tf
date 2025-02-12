output "Master1-a-private-IP" {

value= module.ec2-master-subnet1.instance_private_ip

}

output "Master1-b-private-IP" {

value= module.ec2-master-subnet2.instance_private_ip

}

output "Master1-c-private-IP" {

value= module.ec2-master-subnet3.instance_private_ip

}

output "Worker-1a-private-IP" {

value= module.ec2-worker-subnet1.instance_private_ip

}

output "Worker-1b-private-IP" {

value= module.ec2-worker-subnet2.instance_private_ip

}

output "Worker-1c-private-IP" {

value= module.ec2-worker-subnet3.instance_private_ip

}

output "JumpServer-public-IP" {

value= module.ec2-jumpbox.instance_public_ip

}

output "pem_file" {

value = module.key_pair.file_name

}

