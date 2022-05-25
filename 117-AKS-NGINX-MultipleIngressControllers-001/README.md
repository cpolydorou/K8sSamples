# AKS-NGINX-MultipleIC-001
Source files to deploy an Azure AKS cluster and multiple NGINX ingress controllers.

The deployment contains:
* Azure Bicep template files for vNet and AKS
* K8s Deployments and Helm charts for the NGINX ingress controllers
* K8s Deployments for two sample apps
* Docker file for custom image (applications)

## Deployment
To deploy the environment execute the below steps in sequence.

### AKS Deployment
1. Execute the [101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/101-Bicep-Templates/900-IaC-FullDeployment-001/deploy-manual.sh) script to deploy the vNet and AKS. Update the names of the resource groups in the [101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/101-Bicep-Templates/900-IaC-FullDeployment-001/main.bicep) file.

### AKS Permissions
1. Grant the 'Contributor' role on the vNet to the AKS cluster using the [201-K8s-Deployments/401-Scripts/101-Azure/vNetAccess.sh](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/401-Scripts/101-Azure/vNetAccess.sh) script.

### NGINX Public Deployment
1. Get the credentials for the AKS cluster using the [201-K8s-Deployments/401-Scripts/101-Azure/getAKSCredentials.sh](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/401-Scripts/101-Azure/getAKSCredentials.sh) script.
2. Apply the [201-K8s-Deployments/101-K8s-NGINX-Public-001/1-namespace.yaml](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/101-K8s-NGINX-Public-001/1-namespace.yaml) file to create the namespace for the first ingress controller.
3. Run the [201-K8s-Deployments/101-K8s-NGINX-Public-001/2-helm.sh](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/101-K8s-NGINX-Public-001/2-helm.sh) script to install the first ingress controller.

### NGINX Private Deployment
1. Apply the [201-K8s-Deployments/101-K8s-NGINX-Internal-001/1-namespace.yaml](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/111-K8s-NGINX-Internal-001/1-namespace.yaml) file to create the namespace for the second ingress controller.
2. Run the [201-K8s-Deployments/101-K8s-NGINX-Internal-001/2-helm.sh](https://github.com/cpolydorou/K8sSamples/blob/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/111-K8s-NGINX-Internal-001/2-helm.sh) script to install the second ingress controller.

### Deploy the testing applications
1. Apply the YAML files in each application directory ([201-K8s-Deployments/201-K8s-App-Public-001/](https://github.com/cpolydorou/K8sSamples/tree/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/201-K8s-App-Public-001) and [201-K8s-Deployments/202-K8s-App-Internal-001/](https://github.com/cpolydorou/K8sSamples/tree/main/117-AKS-NGINX-MultipleIngressControllers-001/201-K8s-Deployments/211-K8s-App-Internal-001)) with a sequence according to their file name.

## Important note
in order to access the sample applications, you have to update your hosts files with the IP of the ingress. You can't just use the IP since NGINX uses the host header to distinguish between the sites.

## Blog
I've published a blog post that contains more detailed information on why and how to deploy NGINX. Take a look over [here](https://blog.cpolydorou.net/2022/05/running-multiple-nginx-ingress.html).
