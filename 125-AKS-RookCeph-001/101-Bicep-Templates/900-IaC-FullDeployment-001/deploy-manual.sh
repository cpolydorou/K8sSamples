# Deploy the bicep template

az deployment sub create \
  --name "AKS-RookCeph-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               vNetName="vNet" \
               aksClusterName="aks"