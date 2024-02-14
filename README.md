# Blue-Green Deployment using ArgoCD on Minikube with Nginx

This document provides instructions for setting up a blue-green deployment using ArgoCD on a local Minikube cluster. The deployment serves two versions of a web page using Nginx.

###Prerequisites
Ensure the following prerequisites are met:

Docker is installed on your local machine.
Minikube is installed and operational.
kubectl is installed and configured to communicate with the Minikube cluster.
ArgoCD is installed and accessible.
##Step 1: Clone Repository
Clone the repository containing Nginx configurations and HTML files:

bash
Copy code
git clone https://github.com/RohithER12/blue-green.git
cd blue-green
##Step 2: Build Docker Image
Build the Docker image containing Nginx and HTML files:

bash
Copy code
docker build -t nginx-blue-green .
##Step 3: Deploy to Minikube
Apply Kubernetes manifests to deploy Nginx, create necessary services, and configure ingress:

bash
Copy code
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml
##Step 4: Configure ArgoCD Application
Ensure ArgoCD is operational. Create an application for blue-green deployment:

yaml
Copy code
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: blue-green
spec:
  destination:
    server: https://kubernetes.default.svc # Replace with your Kubernetes API server
    namespace: default
  project: default # Replace with your project name in ArgoCD
  source:
    repoURL: https://github.com/RohithER12/blue-green.git # Git repository URL
    path: kubernetes # Replace with the path to your application manifests within the repo
    targetRevision: HEAD # Replace with desired Git revision (e.g., branch, tag, commit hash)
  syncPolicy:
    automated:
      prune: true # Enable or disable pruning of resources not in Git repository
      selfHeal: true # Enable or disable auto-reconciliation to ensure desired state
      allowEmpty: false # Allow deleting all application resources during automatic syncing (false by default)
    syncOptions:
      - Validate=false # Additional sync options if needed
Apply the ArgoCD application manifest:

bash
Copy code
kubectl apply -f kubernetes/application.yaml
##Step 5: Access the Application
Retrieve the service URL using Minikube:

bash
Copy code
minikube service blue-green-service --url
You'll receive an output like:

arduino
Copy code
http://192.168.58.2:30543
Access the blue-green deployment at the provided URL.

Accessing Blue and Green Versions
Navigate to the following URLs to access the blue and green versions respectively:

Blue Version: http://192.168.58.2:30543/blue
Green Version: http://192.168.58.2:30543/green
Conclusion
You've successfully established a blue-green deployment using ArgoCD on your local Minikube cluster, with Nginx serving different versions of web pages. Switch between blue and green versions of your application seamlessly.
