
# Blue-Green Deployment using ArgoCD on Minikube with Nginx

This document provides instructions for setting up a blue-green deployment using ArgoCD on a local Minikube cluster. The deployment serves two versions of a web page using Nginx.



## Prerequisites

Ensure the following prerequisites are met:

- Docker is installed on your local machine.
- Minikube is installed and operational.
- kubectl is installed and configured to communicate with the Minikube cluster.
- ArgoCD is installed and accessible.

## Step 1: Clone Repository

Clone the repository containing Nginx configurations and HTML files:

```bash
  git clone https://github.com/RohithER12/blue-green.git
  cd blue-green
```
## Step 2: Deploy Nginx
Deploy Nginx to the Minikube cluster using the following command:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f application.yaml
kubectl apply -f ingress.yaml
```
Ensure the Nginx pods are running by executing:

```bash
kubectl get pods
```
## Step 3: Configure ArgoCD
Ensure ArgoCD is configured to monitor the repository by following the official documentation or guides specific to your environment.


## Step 4: Create Blue-Green Application
Create a new application in ArgoCD for the blue-green deployment by pointing it to the cloned repository and selecting the appropriate YAML files.

## Step 5: Verify Deployment
Verify that the blue and green versions of the web page are accessible through the respective service endpoints.

```bash
minikube service blue-green-blue
minikube service blue-green-green
```
 ##   Step 6: Promote Green to Blue
Once the green version is verified and ready for production, promote it to the blue environment using ArgoCD.

## Step 7: Rollback (if necessary)
In case of issues with the green version, rollback to the blue version using ArgoCD.

## Conclusion
You have successfully set up a blue-green deployment using ArgoCD on Minikube with Nginx. This deployment strategy allows for seamless updates and minimal downtime during deployments.

