import * as azure from "@pulumi/azure-native";
import * as azurecontainerservice from "@pulumi/azure-native/containerservice";
import * as cloudflare from "@pulumi/cloudflare";
import * as pulumi from "@pulumi/pulumi";
import * as random from "@pulumi/random";

// Create an Azure Resource Group
const resourceGroup = new azure.resources.ResourceGroup("fos-dev", {
  location: "East US 2",
});


// Create an Azure Container Registry to store the Node.js backend image
const registry = new azure.containerregistry.Registry("fosRegistry", {
  resourceGroupName: resourceGroup.name,
  sku: {
      name: "Basic",
  },
});


// Create an Azure Container Service (ACS) instance with a Node.js backend
const k8s = new azurecontainerservice.ManagedCluster("fosCluster", {
    resourceGroupName: resourceGroup.name,
    agentPoolProfiles: [{
        count: 2,
        vmSize: "Standard_B2s", // Set the VM size as required
        osType: "Linux",
        name: "aksagentpool"
    }],
    dnsPrefix: "aks-service",
    linuxProfile: {
      adminUsername: "testuser",
      ssh: {
        publicKeys: [{
          keyData: "<your-ssh-public-key>",
        }]
      },
    },
});





// // Get the kubeconfig
// let k8sconfig = pulumi
//   .all([k8s.name, resourceGroup.name])
//   .apply(([clusterName, rgName]) =>
//     azure.containerservice.getKubeConfig({
//       resourceGroupName: rgName,
//       resourceName: clusterName,
//     })
//   )
//   .then((kubeconfig) => kubeconfig.kubeConfig);



// // Create a k8s provider instance using the kubeconfig
// let provider = new k8s.Provider("k8sProvider", { kubeconfig: k8sconfig });

// // Assume the Node.js backend image is already built and pushed to Azure Container Registry
// const containerImageName = "YOUR_ACR_NAME.azurecr.io/fos-backend:latest";

// // Setup the Kubernetes deployment and service for the Node.js backend
// const appName = "node-backend-app";



// // Push a Docker image to the Azure Container Registry
// let image = new docker.Image("appImage", {
//   build: {
//     context: "<your-dockerfile-path>",
//   },
//   imageName: `${registry.loginServer}/mynginx:v1.0.0`,
//   registry: {
//     server: registry.loginServer,
//     username: registry.,
//     password: registry.adminPassword,
//   },
// });

// // Deploy a Kubernetes manifest to the AKS cluster
// let appDeployment = new k8s.yaml.ConfigFile("app-deployment", {
//   file: "<your-manifest-file-path>",
//   transformations: [(obj) => {
//     if (obj.metadata.labels['app'] === 'my-app') {
//       obj.spec.template.spec.containers[0].image = "<your-docker-image>"; // replace with your docker image
//     }
//   }]
// }, { provider: provider });

// ... (Details for setting up Kubernetes deployment and service) ...

// Provision an API token that'll be used to access Azure OpenAI services
// const apiToken = new random.RandomPassword("apiToken", {
//     length: 32,
//     special: false,
// });

// Now we define the Cloudflare R2 bucket to serve the frontend
// const frontendBucket = new cloudflare.R2Bucket("frontendBucket", {
//     zoneId: "YOUR_CLOUDFLARE_ZONE_ID", // Replace with your Cloudflare Zone ID
//     bucketName: appName,
// });

// Output the access and secret keys for the Cloudflare R2 bucket
// export const accessKey = frontendBucket.accessKey;
// export const secretKey = frontendBucket.secretKey;

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