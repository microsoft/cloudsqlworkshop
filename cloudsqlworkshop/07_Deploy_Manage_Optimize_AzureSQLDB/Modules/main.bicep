// Set the deployment scope to subscription level
targetScope = 'resourceGroup'

// Define parameters to be provided when executing the template
param location string = resourceGroup().location
param dbName string
param skuName string
param skuTier string
param skuSize string
param vmUsername string
param vmName string
param vmComputerName string
param nicName string
param vmSize string
param diskType string
param imageSKU string
param subnetName string
param vnetName string
param serverName string
param vnetaddressPrefix string
param subnetaddressPrefix string

// Define the administrator username parameter for the VM
param adminUsername string

// Define the administrator password parameter for the VM as secure
@secure()
param adminPassword string
@secure()
param vmAdminPassword string

// Import the module for logical server configuration
module logicalServer './logicalServer.bicep' = {
  name: 'logicalServer-deployment'
  params: {
    location: location
    serverName: serverName
    adminLogin: adminUsername
    adminPassword: adminPassword
    dbName: dbName
    skuName: skuName
    skuSize: skuSize
    skuTier: skuTier
  }
}

// Import the module for network configuration
module network './network.bicep' = {
  name: 'network-deployment'
  params: {
    location: location
    subnetName: subnetName
    vnetName: vnetName
    vnetaddressPrefix: vnetaddressPrefix
    subnetaddressPrefix: subnetaddressPrefix
  }
}

// Import the module for VM configuration
module vm './vm.bicep' = {
  name: 'vm-deployment'
  params: {
    location: location
    vmComputerName: vmComputerName
    vmUsername: vmUsername
    vmName: vmName
    nicName: nicName
    vmSize: vmSize
    diskType: diskType
    imageSKU: imageSKU
    vmAdminPassword: vmAdminPassword
    vnetName: vnetName
    subnetName: subnetName
  }
  // Set the dependency of this module on the new resource group and the network module
  dependsOn: [
    network
  ]
}
