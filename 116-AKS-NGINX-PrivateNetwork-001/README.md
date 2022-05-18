# AKS-NGINX-001
Source files to deploy an Azure AKS cluster and the NGINX ingress controller with private service.

The deployment contains:
* Azure Bicep template files for vNet and AKS
* K8s Deployments and Helm chart for NGINX ingress controller
* K8s Deployments for a sample app
* Linux VM to test the sample app
* Bastion host to connect to the linux VM

## Deployment
To deploy the environment execute the below steps in sequence.

### AKS Deployment
1. Execute the [101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh](https://github.com/cpolydorou/K8sSamples/blob/main/116-AKS-NGINX-PrivateNetwork-001/101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh) script to deploy the Azure resources. In case you have to deploy with specific resource group naming, use the *resourceGroupNamePrefix* parameter.

### vNet Permissions
1. In order for AKS to be able to create the new Azure Load Balancer, contributor access is required on the underlying vNet. Use the below commands to grant access:
```bash
spID=$(az resource list -n aks -g RG-NGINX-AKS --query [*].identity.principalId --out tsv)

scope=$(az resource list -n vnet -g RG-NGINX-Networking --query [*].id --out tsv)

az role assignment create --assignee $spID --role 'Contributor' --scope $scope
```

### NGINX Deployment
1. Get the credentials for the AKS cluster using the [201-K8s-Deployments/401-Scripts/101-Azure/getAKSCredentials.sh](https://github.com/cpolydorou/K8sSamples/blob/main/116-AKS-NGINX-PrivateNetwork-001/201-K8s-Deployments/401-Scripts/101-Azure/getAKSCredentials.sh) script.
2. Apply the [201-K8s-Deployments/111-K8s-NGINX-Internal-001/1-namespace.yaml](https://github.com/cpolydorou/K8sSamples/blob/main/116-AKS-NGINX-PrivateNetwork-001/201-K8s-Deployments/111-K8s-NGINX-Internal-001/1-namespace.yaml) file to create the namespace for the ingress controller.
3. Run the [201-K8s-Deployments/111-K8s-NGINX-Internal-001/2-helm.sh](https://github.com/cpolydorou/K8sSamples/blob/main/116-AKS-NGINX-PrivateNetwork-001/201-K8s-Deployments/111-K8s-NGINX-Internal-001/2-helm.sh) script to install the ingress controller.

### Deploy the testing applications
1. Apply the YAML files in the application directory ([201-K8s-Deployments/211-K8s-App-Internal-001/](https://github.com/cpolydorou/K8sSamples/tree/main/116-AKS-NGINX-PrivateNetwork-001/201-K8s-Deployments/211-K8s-App-Internal-001) with a sequence according to the filenames.

## Important note
The Bicep deployment requires Owner level permission, since it grants access to the AKS cluster on the vNet (required to create the internal load balancer).

## Deployment Status
![Build Status](https://vsrm.dev.azure.com/christospolydorou/_apis/public/Release/badge/a8001c7b-70d1-4fd4-b4b5-ab1a8bbbc570/4/4)

## Blog
I've published a blog post that contains more detailed information on why and how to deploy NGINX. Take a look over [here](https://blog.cpolydorou.net/2022/05/in-one-of-previous-posts-we-used-nginx.html).
