// Set the deployment target to the resource group level
targetScope = 'resourceGroup'

param sqlmiName string
param adminLogin string
@secure()
param adminPassword string
param location string = resourceGroup().location
param virtualNetworkName string
param addressPrefix string
param subnetName string
param subnetPrefix string
param skuName string
param vCores int
param storageSizeInGB int
param licenseType string


module networkSecurityGroup './networkSecurityGroup.bicep' = {
  name: 'networkSecurityGroup-deployment'
  params: {
    location: location
    sqlmiName: sqlmiName
  }
}

module routeTable './routeTable.bicep' = {
  name: 'routeTable-deployment'
  params: {
    location: location
    sqlmiName: sqlmiName
  }
}

module virtualNetwork './virtualNetwork.bicep' = {
  name: 'virtualNetwork-deployment'
  params: {
    location: location
    virtualNetworkName: virtualNetworkName
    addressPrefix: addressPrefix
    subnetName: subnetName
    subnetPrefix: subnetPrefix
    nsgId: networkSecurityGroup.outputs.nsgId
    routeTableId: routeTable.outputs.routeTableId
  }
}

module managedInstance './managedInstance.bicep' = {
  name: 'managedInstance-deployment'
  params: {
    sqlmiName: sqlmiName
    location: location
    skuName: skuName
    adminLogin: adminLogin
    adminPassword: adminPassword
    subnetId: virtualNetwork.outputs.subnetId
    storageSizeInGB: storageSizeInGB
    vCores: vCores
    licenseType: licenseType
  }
  dependsOn: [
    virtualNetwork
  ]
}
