import * as azure from "@pulumi/azure-native";
import * as azurecontainerservice from "@pulumi/azure-native/containerservice";
import * as cloudflare from "@pulumi/cloudflare";
import * as pulumi from "@pulumi/pulumi";
import * as random from "@pulumi/random";

// Create an Azure Resource Group
const resourceGroup = new azure.resources.ResourceGroup("resourceGroup");

// Create an Azure Container Service (ACS) instance with a Node.js backend
const containerService = new azurecontainerservice.ManagedCluster("aksCluster", {
    resourceGroupName: resourceGroup.name,
    agentPoolProfiles: [{
        count: 1,
        vmSize: "Standard_B2s", // Set the VM size as required
        osType: "Linux",
        name: "aksagentpool"
    }],
    dnsPrefix: "aks-service",
});

// Create an Azure Container Registry to store the Node.js backend image
const registry = new azure.containerregistry.Registry("registry", {
    resourceGroupName: resourceGroup.name,
    sku: {
        name: "Basic",
    },
    adminUserEnabled: true,
});

// Assume the Node.js backend image is already built and pushed to Azure Container Registry
const containerImageName = "YOUR_ACR_NAME.azurecr.io/node-backend:latest";

// Setup the Kubernetes deployment and service for the Node.js backend
const appName = "node-backend-app";

// ... (Details for setting up Kubernetes deployment and service) ...

// Provision an API token that'll be used to access Azure OpenAI services
const apiToken = new random.RandomPassword("apiToken", {
    length: 32,
    special: false,
});

// Now we define the Cloudflare R2 bucket to serve the frontend
const frontendBucket = new cloudflare.R2Bucket("frontendBucket", {
    zoneId: "YOUR_CLOUDFLARE_ZONE_ID", // Replace with your Cloudflare Zone ID
    bucketName: appName,
});

// Output the access and secret keys for the Cloudflare R2 bucket
export const accessKey = frontendBucket.accessKey;
export const secretKey = frontendBucket.secretKey;

// The following part where you provide the token to the container as an environment variable
// would logically be part of your Kubernetes deployment (Pod) specification. 
// You'll reference the apiToken.result in your container spec as an environment variable like so:

/*
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: node-backend
    image: containerImageName
    env:
    - name: OPENAI_API_KEY
      valueFrom:
        secretKeyRef:
          name: apiToken
          key: result
*/

// Note that this is a simplified representation. You'll have to create a Kubernetes secret resource
// and reference it in your actual deployment spec.