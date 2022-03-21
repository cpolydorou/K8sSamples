# AKS-NGINX-001
Source files to deploy an Azure AKS cluster and the NGINX ingress controller.

The deployment contains:
* Azure Bicep template files for vNet and AKS
* K8s Deployments and Helm chart for NGINX ingress controller
* K8s Deployments for two sample apps
* Docker file for custom image (applications)

## Deployment
To deploy the environment execute the below steps in sequence.

### AKS Deployment
1. Execute the deploy-manual.sh script to deploy the vNet and AKS. Update the names of the resource groups in the main.bicep file.

### NGINX Deployment
1. Get the credentials for the AKS cluster using the getAKSCredentials.sh script.
2. Apply the 1-namespace.yaml file
3. Run the 2-helm.sh script

### Deploy the testing applications
1. Apply the YAML files in each application directory with a sequence according to their file name.


## Important note
in order to access the sample applications, you have to update your hosts files with the IP of the ingress. You can't just use the IP since NGINX uses the host header to distinguish between the sites.