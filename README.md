
Blue-Green Deployment using ArgoCD on Minikube with Nginx
This guide will walk you through setting up a blue-green deployment using ArgoCD on a local Minikube cluster. We will be using Nginx as the web server to serve two different web pages: one for the blue version and one for the green version.

Prerequisites
Docker installed on your local machine
Minikube installed and running
kubectl installed and configured to interact with your Minikube cluster
ArgoCD installed and accessible
Step 1: Clone the Repository
Clone the repository containing the Nginx configurations and HTML files:

bash
Copy code
git clone https://github.com/RohithER12/blue-green.git
cd blue-green
Step 2: Build the Docker Image
Build the Docker image containing the Nginx server and the HTML files:

bash
Copy code
docker build -t nginx-blue-green .
Step 3: Deploy to Minikube
Apply the Kubernetes manifests to deploy the Nginx server and create the necessary services and ingress:

bash
Copy code
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml
Step 4: Configure ArgoCD Application
Ensure ArgoCD is running and accessible. Then create an application for the blue-green deployment:

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
    targetRevision: HEAD # Replace with the desired Git revision (e.g., branch, tag, commit hash)
  syncPolicy:
    automated:
      prune: true # Enable or disable pruning of resources not in the Git repository
      selfHeal: true # Enable or disable auto-reconciliation to ensure desired state
      allowEmpty: false # Allows deleting all application resources during automatic syncing ( false by default ).
    syncOptions:
      - Validate=false # Additional sync options if needed
Apply the ArgoCD application manifest:

bash
Copy code
kubectl apply -f kubernetes/application.yaml
## Step 5: Access the Application

Retrieve the URL of the service using Minikube:

```bash
minikube service blue-green-service --url
```

You'll get an output like:

```
http://192.168.58.2:30543
```

Now you can access the blue-green deployment at the provided URL.

### Accessing Blue and Green Versions

Navigate to the following URLs to access the blue and green versions respectively:

- Blue Version: [http://192.168.58.2:30543/blue](http://192.168.58.2:30543/blue)
  
  ![Blue Version](blue_page.png)

- Green Version: [http://192.168.58.2:30543/green](http://192.168.58.2:30543/green)
  
  ![Green Version](green_page.png)

## Conclusion

You have successfully set up a blue-green deployment using ArgoCD on your local Minikube cluster with Nginx serving different versions of the web pages. You can now easily switch between the blue and green versions of your application.
