// Set the deployment target to the resource group level
targetScope = 'resourceGroup'

// Define parameters to be used in the main Bicep file
param location string = resourceGroup().location
param vmName string
param nicName string
param vmSize string
param SKU string
param subnetName string
param vnetName string
param vnetaddress string
param subnetaddress string
param publicipName string
param publicipSku string
param publicIPAllocationMethod string
param dnsLabelPrefix string
param networkSecurityGroupName string

// VM administrator credentials
param adminUsername string
@secure()
param adminPassword string

// Import the network module from a local Bicep file
module network './network.bicep' = {
  name: 'network-deployment'
  params: {
    location: location
    subnetName: subnetName
    vnetName: vnetName
    vnetaddress: vnetaddress
    subnetaddress: subnetaddress
    networkSecurityGroupName: networkSecurityGroupName
  }
}

// Import the VM module from a local Bicep file
module sqlvm './sqlvm.bicep' = {
  name: 'vm-deployment'
  params: {
    location: location
    vmName: vmName
    nicName: nicName
    vmSize: vmSize
    SKU: SKU
    adminUsername: adminUsername
    adminPassword: adminPassword
    vnetName: vnetName
    subnetName: subnetName
    publicipName: publicipName
    publicipSku: publicipSku
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsLabelPrefix: dnsLabelPrefix
  }
  // Declare dependencies on both the resource group and network module
  dependsOn: [
    network
  ]
}
