# Grant access to AKS on the vNet
spID=$(az resource list -n aks -g RG-NGINX-AKS --query [*].identity.principalId --out tsv)

scope=$(az resource list -n vnet -g RG-NGINX-Networking --query [*].id --out tsv)

az role assignment create --assignee $spID --role 'Contributor' --scope $scope