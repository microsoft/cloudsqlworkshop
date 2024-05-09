// Parameters for customizing the deployment
param sqlmiName string
param location string = resourceGroup().location
param skuName string
param adminLogin string
@secure()
param adminPassword string
param subnetId string
param storageSizeInGB int
param vCores int
param licenseType string

// Create a managed instance
resource managedInstance 'Microsoft.Sql/managedInstances@2021-11-01-preview' = {
  name: '${resourceGroup().name}-${sqlmiName}'
  location: location
  sku: {
    name: skuName
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    subnetId: subnetId
    storageSizeInGB: storageSizeInGB
    vCores: vCores
    licenseType: licenseType
  }
}
