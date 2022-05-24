// Main bicep file the deploys all resources

// ---------- Start - Configuration ----------
targetScope = 'subscription'
// ---------- End - Configuration ------------

// ---------- Start - Parameters -------------
// Deployment location
param location string = 'westeurope' 

// Resource Group Names
param resourceGroupNamePrefix string = 'RG-NGINX-'

// Resource names
param vNetName string = 'vNet'
param aksClusterName string = 'aks'

// Virtual Machine credentials
@secure()
param adminUsername string
@secure()
param adminPassword string
// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
// ---------- End - Variables ----------------

// ---------- Start - ResourceGroups ---------
resource rgnetworking 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}Networking'
  location: location
}

resource rgvm 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupNamePrefix}VM'
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

// Deploy the bastion host
module bastion '../111-Networking-Bastion-001/bastion.bicep' = {
  name: 'bastion'
  scope: rgnetworking
  params: {
    bastionHostName: 'bastion${uniqueString(subscription().id)}'
    location: location
    bastionSubnetId: '${vNet.outputs.vNetId}/subnets/AzureBastionSubnet'    
  }
}

// Deploy the management virtual machine
module vm '../301-VirtualMachines-Management-001/vm.bicep' = {
  name: 'vm'
  scope: rgvm
  params: {
    vmName: 'aksmgmt'
    location: location
    subnetId: '${vNet.outputs.vNetId}/subnets/Management'    
    adminUsername: adminUsername
    adminPassword: adminPassword
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
    aksNodeCountAppPool: 1
    aksNodeCountSystemPool: 1
    aksSubnetIdAppPool: '${vNet.outputs.vNetId}/subnets/AKSApp'
    aksSubnetIdSystemPool: '${vNet.outputs.vNetId}/subnets/AKSSystem'
    aksSubnetIdInfraPool: '${vNet.outputs.vNetId}/subnets/AKSInfra'
    aksVMSizeAppPool: 'Standard_B2ms'
    aksVMSizeSystemPool: 'Standard_B2ms'
  }
  dependsOn: [
    vNet
  ]
}
// ---------- End - Modules -----------
