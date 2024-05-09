// Parameters for customizing the deployment
param location string = resourceGroup().location
param sqlmiName string

// Variables for the route table
var routeTableName = 'SQLMI-${sqlmiName}-Route-Table'

// Create a route table for the SQL Managed Instance
resource routeTable 'Microsoft.Network/routeTables@2021-08-01' = {
  name: routeTableName
  location: location
  properties: {
    disableBgpRoutePropagation: false
  }
}

output routeTableId string = routeTable.id
