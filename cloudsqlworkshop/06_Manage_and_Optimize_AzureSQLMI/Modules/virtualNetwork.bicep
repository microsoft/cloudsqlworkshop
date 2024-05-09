// Parameters for customizing the deployment
param location string = resourceGroup().location
param virtualNetworkName string
param addressPrefix string
param subnetName string
param subnetPrefix string
param nsgId string
param routeTableId string

// Create a virtual network with a subnet that has a delegation to Azure SQL Managed Instance
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          routeTable: {
            id: routeTableId
          }
          networkSecurityGroup: {
            id: nsgId
          }
          delegations: [
            {
              name: 'managedInstanceDelegation'
              properties: {
                serviceName: 'Microsoft.Sql/managedInstances'
              }
            }
          ]
        }
      }
    ]
  }
}
output subnetId string = virtualNetwork.properties.subnets[0].id
