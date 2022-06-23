# Deploy the bicep template

az deployment sub create \
  --name "AKS-NetworkingPolicies-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               vNetName="vNet" \
               aksClusterName="aks" \
               resourceGroupNamePrefix="RG-AKS-NetworkingPolicies-"