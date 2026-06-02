# EC2 Jenkins Deployment – Terraform + Bash

A scripted Terraform workflow for provisioning an AWS EC2 instance and installing Jenkins automatically. Designed as a quick-start template for standing up a Jenkins server in a fresh AWS environment.

---

## 🛠️ Tools & Technologies

- **Terraform** — EC2 instance provisioning
- **Bash** — lifecycle automation scripts
- **AWS** — EC2, Security Groups, IAM
- **Jenkins** — installed and configured on first boot

---

## 📂 Repository Structure

```
.
├── main.tf                    # Terraform configuration for EC2 instance
├── bootstrap.sh               # Install Terraform and AWS CLI
├── configure-aws.sh           # AWS CLI credential configuration
├── provision-EC2-instance.sh  # Provision EC2 and install Jenkins
├── destroy-hardware.sh        # Tear down all provisioned resources
└── Instructions/              # Step-by-step deployment notes
```

---

## 🚀 Deployment Steps

### 1. Bootstrap the Controller Node

Installs Terraform and AWS CLI, then runs `terraform init`.

```bash
./bootstrap.sh
```

### 2. Configure AWS Credentials

```bash
aws configure
```

> ⚠️ Do not pass credentials as command-line arguments — they will be stored in your shell history. Use `aws configure` or environment variables instead.

### 3. Provision EC2 and Install Jenkins

```bash
./provision-EC2-instance.sh
```

This will:
- Provision the EC2 instance via Terraform
- Install Jenkins on the instance
- Print the Jenkins URL and first-time admin password to stdout

### 4. Access Jenkins

After provisioning, open the printed URL in your browser and use the admin password to complete setup.

### 5. Teardown

```bash
./destroy-hardware.sh
```

Destroys the EC2 instance and all associated AWS resources.

---

## 📦 Prerequisites

- Terraform >= 1.x
- AWS CLI configured with appropriate credentials
- AWS account with EC2 permissions

---

## 📘 What This Project Demonstrates

- Terraform-based EC2 provisioning
- Bash scripting for infrastructure lifecycle management
- Automated software installation on cloud instances
- Clean separation of provision and destroy workflows
