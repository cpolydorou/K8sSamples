# AKS-NetworkingPolicies-001
Source files to deploy an Azure AKS cluster and a set of applications and networking policies.

The deployment contains:
* Azure Bicep template files for vNet and AKS.
* K8s Application deployment files
* K8s Network Policy deployment files

## Deployment
To deploy the environment execute the below steps.

### AKS Deployment
Execute the [101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh](https://github.com/cpolydorou/K8sSamples/blob/main/131-AKS-NetworkingPolicies-001/101-Bicep-Templates/900-IaC-FullDeployment-001/deploy.sh) script to deploy the vNet and AKS. Update the names of the resource groups in the [101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep](https://github.com/cpolydorou/K8sSamples/blob/main/131-AKS-NetworkingPolicies-001/101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep) file.

### Applications Deployment
Use kubectl to apply the 1-namespace.yaml and 2-app-deployment.yaml files in each application deployment directory.

### Network Policy Deployment
Use kubectl to apply the yaml file in each network policy directory.

## Testing
To test the applied policies, connect to a pod and try to ping another pod. The image used allows ping and includes the ping utility.

## Blog
I've created a blog post related to this demo that is available [here](http://blog.cpolydorou.net/2022/06/controlling-network-access-in-aks-using.html)