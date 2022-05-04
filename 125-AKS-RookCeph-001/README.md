# AKS-RookCeph-001
Source files to deploy an Azure AKS cluster and Rook/Ceph.

The deployment contains:
* Azure Bicep template files for vNet and AKS
* K8s Deployments for Rook/Ceph
* K8s Deployments for a sample app

## Deployment
To deploy the environment execute the below steps in sequence.

### AKS Deployment
1. Execute the [101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh](https://github.com/cpolydorou/K8sSamples/blob/main/125-AKS-RookCeph-001/101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh) script to deploy the vNet and AKS. Update the names of the resource groups in the [101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep](https://github.com/cpolydorou/K8sSamples/blob/main/125-AKS-RookCeph-001/101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep) file.

### Rook/Ceph Deployment
1. Get the credentials for the AKS cluster using the [201-K8s-Deployments/401-Scripts/101-Azure/getAKSCredentials.sh](https://github.com/cpolydorou/K8sSamples/blob/main/125-AKS-RookCeph-001/201-K8s-Deployments/401-Scripts/101-Azure/getAKSCredentials.sh) script.
2. Apply the files in the [201-K8s-Deployments/101-K8s-Ceph/](https://github.com/cpolydorou/K8sSamples/blob/main/125-AKS-RookCeph-001/201-K8s-Deployments/101-K8s-Ceph) directory to deploy the cluster.

### Deploy the testing applications
1. Apply the YAML files in the application directory ([201-K8s-Deployments/201-K8s-App-001/](https://github.com/cpolydorou/K8sSamples/tree/main/125-AKS-RookCeph-001/201-K8s-Deployments/201-K8s-App) with a sequence according to their file name.

## Blog
I've published a blog post that contains more detailed information on why and how to deploy Rook/Ceph. Take a look over [here](https://blog.cpolydorou.net/2022/05/high-performance-k8s-storage-with-rook.html).

## Deployment Status
![Build Status](https://vsrm.dev.azure.com/christospolydorou/_apis/public/Release/badge/a8001c7b-70d1-4fd4-b4b5-ab1a8bbbc570/2/2)
