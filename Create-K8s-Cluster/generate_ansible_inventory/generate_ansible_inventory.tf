resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      # Fetch Terraform outputs
      JUMP_SERVER_PUBLIC_IP=$(terraform output -raw JumpServer-public-IP)
      MASTER1_A_PRIVATE_IP=$(terraform output -raw Master1-a-private-IP)
      MASTER1_B_PRIVATE_IP=$(terraform output -raw Master1-b-private-IP)
      MASTER1_C_PRIVATE_IP=$(terraform output -raw Master1-c-private-IP)
      WORKER_1A_PRIVATE_IP=$(terraform output -raw Worker-1a-private-IP)
      WORKER_1B_PRIVATE_IP=$(terraform output -raw Worker-1b-private-IP)
      WORKER_1C_PRIVATE_IP=$(terraform output -raw Worker-1c-private-IP)
      PEM_FILE=$(terraform output -raw pem_file)

      # Debugging outputs to ensure variables are fetched correctly
      echo "JUMP_SERVER_PUBLIC_IP: $JUMP_SERVER_PUBLIC_IP"
      echo "MASTER1_A_PRIVATE_IP: $MASTER1_A_PRIVATE_IP"
      echo "MASTER1_B_PRIVATE_IP: $MASTER1_B_PRIVATE_IP"
      echo "MASTER1_C_PRIVATE_IP: $MASTER1_C_PRIVATE_IP"
      echo "WORKER_1A_PRIVATE_IP: $WORKER_1A_PRIVATE_IP"
      echo "WORKER_1B_PRIVATE_IP: $WORKER_1B_PRIVATE_IP"
      echo "WORKER_1C_PRIVATE_IP: $WORKER_1C_PRIVATE_IP"
      echo "PEM_FILE: $PEM_FILE"

      # Set permissions on the PEM file to 400
      chmod 400 $PEM_FILE

      # Define the inventory file
      INVENTORY_FILE="ansible_inventory.ini"

      # Create the inventory file
      echo "[all]" > $INVENTORY_FILE
      echo "ansible_ssh_common_args='-o ProxyCommand=\"ssh -W %h:%p -q ubuntu@$JUMP_SERVER_PUBLIC_IP -i $PEM_FILE\"'" >> $INVENTORY_FILE
      echo "ansible_user=ubuntu" >> $INVENTORY_FILE
      echo "ansible_ssh_private_key_file=$PEM_FILE" >> $INVENTORY_FILE
      echo "" >> $INVENTORY_FILE

      echo "[masters]" >> $INVENTORY_FILE
      echo "master1-a ansible_host=$MASTER1_A_PRIVATE_IP" >> $INVENTORY_FILE
      echo "master1-b ansible_host=$MASTER1_B_PRIVATE_IP" >> $INVENTORY_FILE
      echo "master1-c ansible_host=$MASTER1_C_PRIVATE_IP" >> $INVENTORY_FILE
      echo "" >> $INVENTORY_FILE

      echo "[workers]" >> $INVENTORY_FILE
      echo "worker-1a ansible_host=$WORKER_1A_PRIVATE_IP" >> $INVENTORY_FILE
      echo "worker-1b ansible_host=$WORKER_1B_PRIVATE_IP" >> $INVENTORY_FILE
      echo "worker-1c ansible_host=$WORKER_1C_PRIVATE_IP" >> $INVENTORY_FILE

      echo "Inventory file generated: $INVENTORY_FILE"
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ansible_inventory.ini && echo 'Inventory file destroyed.'"
  }
}

