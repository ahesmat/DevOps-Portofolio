      export JUMP_SERVER_PUBLIC_IP=$(terraform output -raw JumpServer-public-IP)
      export MASTER1_A_PRIVATE_IP=$(terraform output -raw Master1-a-private-IP)
      export MASTER1_B_PRIVATE_IP=$(terraform output -raw Master1-b-private-IP)
      export MASTER1_C_PRIVATE_IP=$(terraform output -raw Master1-c-private-IP)
      export WORKER_1A_PRIVATE_IP=$(terraform output -raw Worker-1a-private-IP)
      export WORKER_1B_PRIVATE_IP=$(terraform output -raw Worker-1b-private-IP)
      export WORKER_1C_PRIVATE_IP=$(terraform output -raw Worker-1c-private-IP)
      export PEM_FILE=$(terraform output -raw pem_file)

     # Set permissions on the PEM file to 400
      chmod 400 $PEM_FILE

      # Define the inventory file 
      INVENTORY_FILE="ansible_inventory.ini"

            # Create the inventory file
      echo "[all:vars]" > $INVENTORY_FILE
      echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -W %h:%p -q ubuntu@$JUMP_SERVER_PUBLIC_IP -i $PEM_FILE\"'" >> $INVENTORY_FILE
      echo "ansible_user=ubuntu" >> $INVENTORY_FILE
      echo "ansible_ssh_private_key_file=$PEM_FILE" >> $INVENTORY_FILE
      echo "" >> $INVENTORY_FILE

      echo "[master1]" >> $INVENTORY_FILE
      echo "master1-a ansible_host=$MASTER1_A_PRIVATE_IP" >> $INVENTORY_FILE      

      echo "[masters]" >> $INVENTORY_FILE
      echo "master1-b ansible_host=$MASTER1_B_PRIVATE_IP" >> $INVENTORY_FILE
      echo "master1-c ansible_host=$MASTER1_C_PRIVATE_IP" >> $INVENTORY_FILE
      echo "" >> $INVENTORY_FILE

      echo "[workers]" >> $INVENTORY_FILE
      echo "worker-1a ansible_host=$WORKER_1A_PRIVATE_IP" >> $INVENTORY_FILE
      echo "worker-1b ansible_host=$WORKER_1B_PRIVATE_IP" >> $INVENTORY_FILE
      echo "worker-1c ansible_host=$WORKER_1C_PRIVATE_IP" >> $INVENTORY_FILE

      echo "Inventory file generated: $INVENTORY_FILE"
