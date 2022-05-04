// Create the VNet to base the entire platform

// ---------- Start - Parameters -------------
param vNetName string
param location string
// ---------- End - Parameters ---------------

// ---------- Start - Resources --------------
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vNetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: 'Networking'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'AKSSystem'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'AKSStorage'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
      {
        name: 'AKSApp'
        properties: {
          addressPrefix: '10.0.3.0/24'
        }
      }
    ]
  }
}
// ---------- End - Resources ----------------

// ---------- Start - Outputs ----------------
output vNetId string = vnet.id
output vNetName string = vnet.name
// ---------- Start - Outputs ----------------
