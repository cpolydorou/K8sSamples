# Deploy the bicep template

az deployment sub create \
  --name "AKS-NGINX-PrivateService-Demo" \
  --location "westeurope" \
  --template-file main.bicep \
  --parameters location="westeurope" \
               vNetName="vNet" \
               aksClusterName="aks" \
               adminUsername="localadmin" \
               adminPassword="Str0ngP@ss"