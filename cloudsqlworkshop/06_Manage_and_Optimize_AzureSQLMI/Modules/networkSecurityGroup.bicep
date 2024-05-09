// Parameters for customizing the deployment
param location string = resourceGroup().location
param sqlmiName string

// Create a network security group for the SQL Managed Instance
var networkSecurityGroupName = '${sqlmiName}-NSG'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-08-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    
  }
}

output nsgId string = networkSecurityGroup.id
