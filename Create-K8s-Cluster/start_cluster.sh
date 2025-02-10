terraform init
terraform apply --auto-approve
terraform apply -target module.worker-alb-listener --auto-approve 
terraform apply -target module.master-alb-listener --auto-approve
generate_ansible_inventory.sh
cd ansible-playbooks
ansible-playbook -i ansible_inventory.ini mount-ebs-volume-idenpodant.yaml
ansible-playbook -i ansible_inventory.ini install_docker.yml
ansible-playbook -i ansible_inventory.ini install_k8s.yml
ansible-playbook -i ansible_inventory.ini change-hostname.yaml
ansible-playbook -i ansible_inventory.ini init-master-a.yaml
ansible-playbook -i ansible_inventory.ini join-masters.yaml
ansible-playbook -i ansible_inventory.ini join-workers.yaml
ansible-playbook -i ansible_inventory.ini deploy-nginx.yaml

