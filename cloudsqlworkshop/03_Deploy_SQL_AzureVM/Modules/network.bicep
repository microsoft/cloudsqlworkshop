// Parameters for customizing the deployment
param location string = resourceGroup().location
param vnetName string
param subnetName string
param vnetaddress string
param subnetaddress string
param networkSecurityGroupName string

// Resource definition for the Network Security Group (NSG)
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP-All'
        properties: {
          priority: 100
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}


// Resource definition for the Virtual Network (VNet)
resource vnet 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnetaddress]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetaddress
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}
