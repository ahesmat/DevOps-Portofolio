 Incident Tracker – Kubernetes + Postgres + Helm Deployment

This project is a production-style Kubernetes deployment of a simple Incident Tracker API backed by PostgreSQL.
It demonstrates key DevOps and SRE skills, including:

Kubernetes Deployments & StatefulSets

Persistent storage (PV / PVC)

Secrets, ConfigMaps, probes, and resource management

Helm chart design for multi-component applications

Containerized API built with Node.js + Express

The goal of the project is to show how to deploy a real API and database on Kubernetes using robust, scalable patterns that reflect what is done in production environments.

🏗️ Architecture Overview
                      k8s-ha-app-postgres/images/IncidentTrackerDiagram.png

                      
![Repository Structure](https://raw.githubusercontent.com/ahesmat/DevOps-Portofolio/main/k8s-ha-app-postgres/IncidentTrackerDiagram.png)
*Diagram: Full project folder layout, including app code, Helm chart, and Kubernetes manifests.*


Components
Component	Description
demo-app	Node.js API providing /health and /incidents endpoints
Deployment	2 replicas, probes, resource requests/limits
ConfigMap	Database host, port, name, and user
Secret	Encoded DB credentials
postgres	StatefulSet with persistent storage
Headless Service	Enables stable network identity for Postgres
PV/PVC	1Gi storage for the DB data
Helm Chart	Generates all manifests from configurable values
🚀 Features Demonstrated

Helm templating for multi-tier apps

Kubernetes StatefulSet + persistent storage

Liveness & readiness probes

Resource requests & limits

Configuration via ConfigMaps & Secrets

Internal service-to-service communication

Fully reproducible deployment via Helm

This shows practical DevOps fundamentals expected in Kubernetes-focused roles.

📂 Repository Structure
.
├── app/
│   ├── server.js                  # Node.js API
│   ├── Dockerfile                 # App container image
│   └── package.json
│
├── helm/
│   └── incident-tracker/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── configmap.yaml
│           ├── postgres-statefulset.yaml
│           ├── postgres-service.yaml
│           ├── postgres-secret.yaml
│           ├── postgres-pv.yaml
│           └── postgres-pvc.yaml

📦 Prerequisites

Kubernetes cluster (minikube, kind, or multi-node cluster)

kubectl installed

helm installed

Docker (to build your own app image)

🔧 Deployment Instructions
1️⃣ Build & Push the App Image

Inside the /app directory:

docker build -t <your-dockerhub-username>/incident-api:v1 .
docker push <your-dockerhub-username>/incident-api:v1


Update the image reference in:

helm/incident-tracker/values.yaml

2️⃣ Deploy Using Helm
cd helm/incident-tracker
helm upgrade --install incident-tracker-v1 . --namespace demo-ha-app --create-namespace


Verify:

kubectl get all -n demo-ha-app
kubectl get pv,pvc


You should see:

Deployment (2 pods)

StatefulSet (1 pod)

Services (demo-app, postgres)

PV + PVC bound

🧪 Testing the Application
1️⃣ Start a temporary curl client inside the cluster
kubectl run curl-client \
  -n demo-ha-app \
  --restart=Never \
  --image=curlimages/curl \
  --command -- sleep 3600


Wait for it to be running:

kubectl get pod curl-client -n demo-ha-app

2️⃣ Check the API health
kubectl exec -it curl-client -n demo-ha-app -- \
  curl -sS http://demo-app/health


Expected output:

{"status":"ok"}

3️⃣ Fetch incidents
kubectl exec -it curl-client -n demo-ha-app -- \
  curl -sS http://demo-app/incidents


Expected:

Seeded incidents

Any incidents you POSTed previously

🧹 Cleanup
helm uninstall incident-tracker-v1 -n demo-ha-app
kubectl delete namespace demo-ha-app

📘 Future Enhancements (Optional)

These can further strengthen the project:

Add NetworkPolicy to restrict DB access

Add an HPA (HorizontalPodAutoscaler) for demo-app

Add Ingress + TLS

Add CI/CD pipeline to package & deploy the Helm chart

Add automated backup Job for Postgres

🏁 Summary

This project demonstrates practical, production-grade Kubernetes deployment skills:

Stateful workloads

Persistent storage

Application configuration

Secrets management

Health checks & resources

Helm chart packaging


