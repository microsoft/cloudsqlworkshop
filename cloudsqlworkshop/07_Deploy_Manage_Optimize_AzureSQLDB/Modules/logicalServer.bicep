
param location string = resourceGroup().location
param serverName string
param dbName string

param adminLogin string
@secure()
param adminPassword string

param skuName string
param skuTier string
param skuSize string

// Define a logical SQL server resource
resource logicalServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: '${serverName}-${resourceGroup().name}'
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}

// Define outputs for the SQL logical server name and administrator username
output sqlInstanceName string = logicalServer.name
output adminUsername string = logicalServer.properties.administratorLogin

// Create a SQL database resource under the logical server
resource database 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: logicalServer
  name: dbName
  location: location
  sku: {
    name: skuName
    size: skuSize
    tier: skuTier
  }
}
