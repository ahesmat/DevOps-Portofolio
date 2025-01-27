terraform init
terraform apply --auto-approve
terraform apply -target module.worker-alb-listener --auto-approve 
terraform apply -target module.master-alb-listener --auto-approve
generate_ansible_inventory.sh
ansible-playbook -i ansible_inventory.ini install_docker.yml
ansible-playbook -i ansible_inventory.ini install_k8s.yml
