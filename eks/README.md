Certainly! Below is a formatted README.md file that you can use for the activity described:

markdown

# Docker and Kubernetes Deployment Guide

This README provides a comprehensive guide to deploying a Docker-based application using AWS ECR, Docker, and Kubernetes. Follow the steps below to successfully set up and run your application.

## Prerequisites

- AWS CLI installed and configured
- Docker installed on your local machine
- eksctl and kubectl installed for Kubernetes operations
- Helm installed for managing Kubernetes packages

## Docker Registry Operations

### 1. Docker Login

Authenticate your Docker client to the AWS Elastic Container Registry (ECR).

```bash
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 328526511201.dkr.ecr.us-east-2.amazonaws.com
```
2. Docker Pull
Pull the necessary Docker images from the ECR.

```bash

docker pull 328526511201.dkr.ecr.us-east-2.amazonaws.com/events-website:2.0
docker pull 328526511201.dkr.ecr.us-east-2.amazonaws.com/events-api:2.0
```
3. Docker Run
Run the Docker containers on your local machine.

```bash

docker run -d -p 8082:8082 328526511201.dkr.ecr.us-east-2.amazonaws.com/events-api:2.0
docker run -d -p 8080:8080 -e SERVER='http://localhost:8082' --network="host" 328526511201.dkr.ecr.us-east-2.amazonaws.com/events-website:2.0
```

4. Test Application
Access the running application using the following URL:
```bash
http://ec2-18-188-118-224.us-east-2.compute.amazonaws.com:8080/
```

### Kubernetes Cluster Setup
Git Clone
Clone the repository to access Kubernetes configuration files.

```bash

git clone https://github.com/jaybrata19/aws-engagement-day.git
cd eks/eksctlcluster
```
1. Create Kubernetes Cluster

Create a Kubernetes cluster using eksctl.

```bash

eksctl create cluster -f cluster.yaml
kubectl get nodes
```
2. Test Cluster Access
Verify access to your cluster with the following commands:
```bash
kubectl cluster-info
kubectl get services
kubectl get nodes
kubectl get pods
```
3. Deploying Services and Application
Navigate to the Kubernetes configuration directory and apply configurations to deploy your application.

```bash
cd ~/eventsapp/kubernetes-config
kubectl apply -f api-deployment.yaml
kubectl apply -f web-deployment.yaml
kubectl apply -f api-service.yaml
kubectl apply -f web-service.yaml
kubectl get pods
kubectl get services
```
4. Deploy Database and Install Database Server
Deploy the MariaDB database server using Helm.

```bash

helm install database-server oci://registry-1.docker.io/bitnamicharts/mariadb
```
5. Configure Storage Class
Set the default storage class for your Kubernetes cluster.

```bash
kubectl get storageclass
kubectl patch storageclass gold -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get services
```
### Conclusion
Following these steps will help you set up and deploy your application using Docker and Kubernetes. Ensure all prerequisites are met and configurations are correctly applied for successful deployment. For further assistance, consult the respective documentation of AWS, Docker, and Kubernetes.