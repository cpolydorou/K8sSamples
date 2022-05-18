// Create the bastion host to remotely access the platform

// ---------- Start - Parameters -------------
param bastionHostName string = 'bastion'
param bastionSubnetId string
param location string = 'westeurope'
// ---------- End - Parameters ---------------

// ---------- Start - Variables --------------
var bastionPublicIpAddressName = '${bastionHostName}-pip'
// ---------- End - Variables   --------------

// ---------- Start - Resources --------------
// The bastion public IP
resource bastionPublicIpAddress 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: bastionPublicIpAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// The bastion host
resource bastionHost 'Microsoft.Network/bastionHosts@2020-08-01' = {
  name: bastionHostName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: bastionSubnetId
          }
          publicIPAddress: {
            id: bastionPublicIpAddress.id
          }
        }
      }
    ]
  }
}
// ---------- End - Resources   --------------
