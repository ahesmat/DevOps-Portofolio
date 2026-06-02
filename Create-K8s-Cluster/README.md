# Kubernetes Cluster on AWS – Terraform + Ansible Reference Architecture

A reference implementation for provisioning a production-grade, highly available Kubernetes cluster on AWS. Infrastructure is defined entirely in Terraform, with Ansible handling Kubernetes installation and node configuration.

> **Note:** This project documents a real infrastructure design built and tested in AWS. It is intended as a reference architecture and learning resource — review and adapt to your environment before deploying.

---

## 🏗️ Architecture Overview

![HA Kubernetes Cluster Architecture](HA_K8s_Cluster_Final.jpg)

The cluster spans **3 Availability Zones** in `us-east-1`, with master and worker nodes isolated in private subnets behind an Elastic Load Balancer.

| Layer | Details |
|---|---|
| **VPC** | 10.0.0.0/16 across 3 AZs |
| **Public Subnets** | Internet-facing — NAT Gateways, Load Balancer |
| **Private Subnets** | Kubernetes master and worker nodes |
| **Master Nodes** | 3x `t3.medium` EC2 — one per AZ |
| **Worker Nodes** | 3x `t3.large` EC2 — scalable |
| **Load Balancer** | ELB distributing traffic to worker nodes |
| **Storage** | EBS volumes per node |
| **DNS** | Route 53 for domain management |
| **TLS** | ACM certificate with HTTPS on ALB |
| **Access** | Jumpbox in public subnet for SSH access |

---

## 🛠️ Tools & Technologies

- **Terraform** — all AWS infrastructure provisioned as code
- **Ansible** — Kubernetes installation and cluster configuration
- **AWS** — EC2, VPC, ELB, Route 53, ACM, EBS, IAM, NAT Gateway
- **Kubernetes** — kubeadm-based cluster setup
- **Bash** — automation scripts for cluster lifecycle

---

## 📂 Repository Structure

```
.
├── vpc/                        # VPC and networking
├── subnets/                    # Public and private subnets
├── routes/                     # Route tables and associations
├── nat_gateways/               # NAT Gateways for private subnet egress
├── security_groups/            # Security group rules
├── ec2/                        # Master and worker node instances
├── jumpbox/                    # Bastion host for SSH access
├── elastic_load_balancer/      # ELB configuration
├── alb_listeners/              # ALB listener rules
├── change_alb_to_https/        # HTTPS migration config
├── target_group_attachment/    # ELB target group bindings
├── cert_generation_and_validation/ # ACM certificate provisioning
├── dns_zone/                   # Route 53 hosted zone
├── dns_records/                # Route 53 DNS records
├── ebs_volume/                 # EBS volume definitions
├── key_pair/                   # SSH key pair management
├── provider/                   # AWS provider configuration
├── ansible-playbooks/          # Kubernetes installation playbooks
├── generate_ansible_inventory/ # Dynamic inventory generation
│
├── main.tf                     # Root Terraform entrypoint
├── output.tf                   # Terraform outputs
├── install_k8s.yml             # Ansible: install Kubernetes on all nodes
├── join-masters.yaml           # Ansible: join master nodes to cluster
├── join-workers.yaml           # Ansible: join worker nodes to cluster
├── nginx.yaml                  # Sample workload manifest
│
├── bootstrap.sh                # Initial environment setup
├── start_cluster.sh            # Full cluster bring-up sequence
├── initiate-cluster.sh         # kubeadm init on primary master
├── join_worker.sh              # Worker node join script
├── generate_ansible_inventory.sh # Generate Ansible inventory from Terraform outputs
├── configure-aws.sh            # AWS CLI configuration helper
├── login.sh                    # SSH login helper via jumpbox
└── clean.sh                    # Tear down all resources
```

---

## ⚙️ Key Design Decisions

- **Private nodes:** Master and worker nodes have no public IPs — all access goes through the jumpbox or ELB
- **Multi-AZ:** Control plane and workers distributed across 3 AZs for fault tolerance
- **NAT Gateways:** One per AZ to avoid cross-AZ traffic for outbound internet access
- **Dynamic inventory:** `generate_ansible_inventory.sh` pulls EC2 IPs from Terraform outputs — no manual inventory management
- **HTTPS:** ALB configured with ACM certificate; HTTP redirects to HTTPS

---

## 📦 Prerequisites

- Terraform >= 1.5
- Ansible >= 2.12
- AWS CLI configured with appropriate credentials
- SSH key pair for EC2 access
- A registered domain (for Route 53 + ACM)

---

## 🔧 Deployment Overview

```bash
# 1. Configure AWS credentials
./configure-aws.sh

# 2. Initialize and apply Terraform
terraform init
terraform apply

# 3. Generate Ansible inventory from Terraform outputs
./generate_ansible_inventory.sh

# 4. Install Kubernetes on all nodes
ansible-playbook -i inventory install_k8s.yml

# 5. Initialize the cluster on the primary master
./initiate-cluster.sh

# 6. Join remaining masters and workers
ansible-playbook -i inventory join-masters.yaml
ansible-playbook -i inventory join-workers.yaml
```

---

## 🧹 Teardown

```bash
./clean.sh
terraform destroy
```

---

## 📘 What This Project Demonstrates

- Multi-AZ AWS network design (VPC, subnets, routing, NAT)
- Infrastructure as Code with modular Terraform
- Kubernetes cluster bootstrap with kubeadm via Ansible
- Load balancer configuration with TLS termination
- Jumpbox pattern for secure private subnet access
- Dynamic Ansible inventory generation from infrastructure outputs
- End-to-end automation from bare AWS account to running cluster
