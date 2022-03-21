// Create the AKS cluster

// ---------- Start - Parameters -------------
param location string = 'westeurope'

param vNetName string
param vNetResourceGroupName string

param aksClusterName string = 'aks'
param aksClusterManagedResourceGroupName string

param aksSubnetIdSystemPool string
param aksSubnetIdAppPool string
param aksSubnetIdInfraPool string

param aksNodeCountSystemPool int = 1
param aksVMSizeSystemPool string = 'standard_b2ms'

param aksNodeCountAppPool int = 1
param aksVMSizeAppPool string = 'standard_b2ms'

param aksNodeCountInfraPool int = 3
param aksVMSizeInfraPool string = 'standard_b8ms'
// ---------- End - Parameters -------------

// ---------- Start - References -----------
resource vNet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: vNetName
  scope: resourceGroup(vNetResourceGroupName)
}
// ---------- End - References -------------

// ---------- Start - Resources ------------
resource aks 'Microsoft.ContainerService/managedClusters@2021-05-01' = {
  name: aksClusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: aksClusterName
    nodeResourceGroup: aksClusterManagedResourceGroupName
    enableRBAC: false
    agentPoolProfiles: [
      {
        name: 'systempool'
        count: aksNodeCountSystemPool
        vmSize: aksVMSizeSystemPool
        mode: 'System'
        vnetSubnetID: aksSubnetIdSystemPool
        nodeLabels: {
          nodeType: 'system'
        }
      }
      {
        name: 'apppool'
        count: aksNodeCountAppPool
        vmSize: aksVMSizeAppPool
        mode: 'User'
        vnetSubnetID: aksSubnetIdAppPool
        nodeLabels: {
          nodeType: 'application-node'
        }
      }
      {
        name: 'infrapool'
        count: aksNodeCountInfraPool
        vmSize: aksVMSizeInfraPool
        mode: 'User'
        vnetSubnetID: aksSubnetIdInfraPool
        nodeLabels: {
          nodeType: 'infrastructure-node'
        }
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: '192.168.0.0/16'
      networkPolicy: 'azure'
      dnsServiceIP: '192.168.0.10'
      loadBalancerSku: 'standard'
    }
    addonProfiles: {
      azureKeyvaultSecretsProvider: {
        enabled: true
        config: {
          enableSecretRotation: 'true'
        }
      }
   }  
 }
}
// ---------- End - Resources -----------

// ---------- Start - Outputs -----------
output identity string = aks.identity.principalId
output clusterName string = aks.properties.dnsPrefix
output kubeletId string = aks.properties.identityProfile.kubeletidentity.objectId
// ---------- End - Outputs -------------
