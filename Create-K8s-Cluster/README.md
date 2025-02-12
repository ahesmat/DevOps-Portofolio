# Kubernetes Cluster on AWS with Terraform and Ansible

## Overview
This project demonstrates how to create a **production-grade Kubernetes (K8s) cluster** on AWS, leveraging **Terraform** for infrastructure provisioning and **Ansible** for Kubernetes setup and deployment. The cluster consists of:
- **3 Master Nodes**: For high availability and fault tolerance.
- **3 Worker Nodes**: To host applications and workloads. ( Can be scaled when needed)

The project also incorporates AWS services to enhance the production environment, such as:
- **Load Balancing**
- **DNS Management (Route 53)**
- **Security Groups**
- **Certificate Management**
- **EBS Volumes**


---

## Goals
1. Create a reliable Kubernetes cluster on AWS using EC2 instances.
2. Apply best practices for infrastructure-as-code with Terraform.
3. Use Ansible for automated installation and configuration of Kubernetes.
4. Leverage AWS features to build a scalable, secure, and highly available environment.
5. Document every step of the process for learning and portfolio purposes.

---

## Architecture Design
### **AWS Resources**
- **VPC**: A custom Virtual Private Cloud with subnets spread across multiple availability zones.
- **Subnets**:
  - Public Subnets: For internet-facing resources (e.g., load balancers).
  - Private Subnets: For Kubernetes nodes.
- **EC2 Instances**:
  - `t3.medium` for master nodes.
  - `t3.large` for worker nodes.
- **IAM Roles**: To provide permissions for EC2 instances to interact with AWS services.
- **Load Balancer**: Elastic Load Balancer for distributing traffic.
- **DNS**: Route 53 for domain management.

---

## Tools and Technologies
- **Terraform**: Infrastructure provisioning.
- **Ansible**: Configuration management and Kubernetes installation.
- **AWS**: Cloud provider for hosting the cluster.
- **Kubernetes**: Container orchestration platform.

---

## Step-by-Step Guide

### **Phase 1: Infrastructure Setup**
1. **Design the VPC**:
   - Create a custom VPC with public and private subnets.
   - Set up internet gateways and route tables.
2. **Provision EC2 Instances**:
   - Launch EC2 instances for master and worker nodes.
   - Configure security groups and IAM roles.

### **Phase 2: Kubernetes Setup**
3. **Install Kubernetes with Ansible**:
   - Deploy Kubernetes on provisioned instances.
   - Configure etcd, kube-apiserver, kube-scheduler, and kube-controller-manager on master nodes.
   - Install kubelet and kube-proxy on worker nodes.

### **Phase 3: AWS Integration**
4. **Leverage AWS Features**:
   - Configure an Elastic Load Balancer for Kubernetes services.
   - Set up auto-scaling groups for worker nodes.
   - Use Route 53 for DNS management.

---

## How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/aws-k8s-cluster.git
   cd aws-k8s-cluster

2. Initialize Terraform:

      terraform init

3. Apply the Terraform configuration:

      terraform apply

4. Run Ansible playbooks to set up Kubernetes

      ansible-playbook -i inventory k8s-setup.yml


Prerequisites
Terraform (version >= 1.5)
Ansible (version >= 2.12)
AWS CLI (configured with appropriate credentials)
A valid AWS account
SSH key pair for accessing EC2 instance
2. Initialize Terraform:

      terraform init

3. Apply the Terraform configuration:

      terraform apply

4. Run Ansible playbooks to set up Kubernetes

      ansible-playbook -i inventory k8s-setup.yml


Prerequisites

Terraform (version >= 1.5)
Ansible (version >= 2.12)
AWS CLI (configured with appropriate credentials)
A valid AWS account
SSH key pair for accessing EC2 instance


Project Roadmap
Step 1: Define the VPC (in progress).
Step 2: Provision EC2 instances for the cluster.
Step 3: Configure Kubernetes using Ansible.
Step 4: Integrate AWS services like load balancing, auto-scaling, and DNS.


Author:

Ahmed Esmat


## License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

