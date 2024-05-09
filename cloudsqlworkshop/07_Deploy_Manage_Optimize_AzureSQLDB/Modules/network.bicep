// Define parameters for the virtual network and subnet
param location string = resourceGroup().location
param subnetName string
param vnetName string
param vnetaddressPrefix string
param subnetaddressPrefix string

// Create a virtual network resource
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties:{
    // Define the address space for the virtual network
    addressSpace:{
      addressPrefixes:[
        vnetaddressPrefix
      ]
    }
    // Define the subnet within the virtual network
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetaddressPrefix
        }
      }
    ]
  }
}
