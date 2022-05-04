// Main bicep file the deploys all resources

// ---------- Start - Configuration ----------
targetScope = 'subscription'
// ---------- End - Configuration ------------

// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// ---------- Start - Variables --------------
var resourceGroupNamePrefix = 'RG-RookCeph-'
// ---------- End - Variables ----------------

// Resource names
param vNetName string = 'vNet'
param aksClusterName string = 'aks'
// ---------- End - Parameters ---------------

// ---------- Start - ResourceGroups ---------
resource rgnetworking 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}Networking'
  location: location
}

resource rgaks 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}AKS'
  location: location
}
// ---------- End - ResourceGroups -----------

// ---------- Start - Modules ---------
// Deploy the virtual network
module vNet '../101-Networking-VNet-001/vNet.bicep' = {
  name: 'vNet'
  scope: rgnetworking
  params: {
    vNetName: vNetName
    location: location
  }
}

// Deploy the AKS cluster
module aks '../201-Kubernetes-AKS-001/aks.bicep' = {
  name: 'AKS'
  scope: rgaks
  params: {
    aksClusterName: aksClusterName
    location: location
    vNetName: vNet.outputs.vNetName
    vNetResourceGroupName: rgnetworking.name
    aksClusterManagedResourceGroupName: '${rgaks.name}-MC'
    aksNodeCountAppPool: 2
    aksNodeCountSystemPool: 1
    aksSubnetIdAppPool: '${vNet.outputs.vNetId}/subnets/AKSApp'
    aksSubnetIdSystemPool: '${vNet.outputs.vNetId}/subnets/AKSSystem'
    aksSubnetIdStoragePool: '${vNet.outputs.vNetId}/subnets/AKSStorage'
    aksVMSizeAppPool: 'Standard_B2ms'
    aksVMSizeSystemPool: 'Standard_B2ms'
  }
  dependsOn: [
    vNet
  ]
}
// ---------- End - Modules -----------
