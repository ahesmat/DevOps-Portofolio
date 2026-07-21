# Ahmed Esmat – DevOps & Platform Engineering Portfolio

**Integration/DevOps Engineer** with 15+ years of experience building and operating production infrastructure. Currently at Ericsson supporting AT&T's 5G core network — running Kubernetes at carrier scale, maintaining CI/CD pipelines, and operating observability stacks that can't afford downtime.

This portfolio demonstrates hands-on work with Kubernetes, Terraform, Ansible, Jenkins, and AWS across real infrastructure projects.

---

## 🛠️ Core Skills

| Domain | Tools |
|---|---|
| **Container Orchestration** | Kubernetes, Docker, Helm |
| **Infrastructure as Code** | Terraform, Ansible |
| **CI/CD** | Jenkins, GitHub Actions |
| **Cloud** | AWS — EC2, VPC, ELB, Route 53, ACM, S3, IAM |
| **Observability** | Prometheus, Grafana, ELK Stack |
| **OS & Scripting** | Linux, Bash, SSH |

---

## 📁 Projects

### 🔹 [Incident Tracker – Kubernetes + Postgres + Helm](./k8s-ha-app-postgres)
A production-style Kubernetes deployment of a Node.js API backed by PostgreSQL. Covers StatefulSets, persistent storage, Helm chart design, liveness/readiness probes, resource management, and ConfigMap/Secret injection.

**Stack:** Kubernetes · Helm · Docker · PostgreSQL · Node.js

---

### 🔹 [HA Kubernetes Cluster on AWS – Terraform + Ansible](./Create-K8s-Cluster)
Full infrastructure-as-code provisioning of a highly available Kubernetes cluster across 3 AWS Availability Zones. VPC design with public/private subnets, NAT Gateways, ELB, Route 53, ACM, and Ansible-based cluster bootstrap.

**Stack:** Terraform · Ansible · AWS · Kubernetes · kubeadm

---

### 🔹 [Multi-Region Jenkins Deployment – Terraform + Ansible](./MultiRegion_Jenkins_Deployment)
Jenkins Master/Worker infrastructure spanning two AWS regions with VPC peering, ALB with TLS termination, Route 53 DNS, S3 remote state, and dynamic Ansible inventory generation from Terraform outputs.

**Stack:** Terraform · Ansible · AWS · Jenkins · Route 53 · ACM

---

### 🔹 [EC2 Jenkins Deployment – Terraform + Bash](./Create-EC2-Instance-With-Jenkins)
Scripted Terraform workflow for provisioning an AWS EC2 instance and installing Jenkins automatically. Clean separation of provision and destroy lifecycle with Bash automation.

**Stack:** Terraform · Bash · AWS EC2 · Jenkins

---

### 🔹 [SSH Git Authentication Setup](./SSH-Connect-to-Repo)
A Bash utility that automates switching a Git repository from HTTPS to SSH authentication — generates an ed25519 key pair, configures the remote URL, and verifies the GitHub connection. Useful in CI/CD environments where credential prompts aren't practical.

**Stack:** Bash · SSH · Git

---

## Featured Project

### [AWS Infrastructure Platform](https://github.com/ahesmat/aws-infra-platform)
Production-grade AWS infrastructure built with Terraform, GitHub Actions CI/CD, Ansible, and CloudWatch observability. Hosts a live resume page at [devops.reachlyapp.com](https://devops.reachlyapp.com).

---

## 🏭 Production Background

My day-to-day work at Ericsson runs at a scale where these patterns matter in production:

- **Kubernetes** — operating workloads on 5G core infrastructure
- **CI/CD** — building and maintaining deployment pipelines for telco-grade systems
- **Observability** — Prometheus, Grafana, and ELK for real-time system visibility
- **Linux/Bash** — automation for system management and integration tasks

---

## 🐳 DockerHub

Public images from these projects: [hub.docker.com/u/ahesmat](https://hub.docker.com/repositories/ahesmat)

---

## 📬 Let's Connect

I'm currently exploring remote **DevOps / Platform Engineering** roles.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Ahmed%20Esmat-blue?logo=linkedin)](https://www.linkedin.com/in/ahmed-mohamed-esmat/)
