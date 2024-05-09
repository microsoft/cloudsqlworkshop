// Specify the main Bicep file to use for deployment
using 'main.bicep'

// Set up deployment parameters for the virtual machine and associated resources
@description('Parameters for the SQL Server virtual machine deployment')

param adminUsername = 'adminsqlvm'
@secure()
param adminPassword = 'P@ssword12!'

// Define parameters related to SQL database configuration
param vmName = 'lab03-sqlvm'
param nicName = 'lab03-nic'
param SKU = 'SQLDEV'
param vmSize = 'Standard_D2s_v3'
param subnetName = 'lab03-subnet-1'
param vnetName = 'lab03-vnet-1'

// Define networking parameters for the virtual network and subnet
param vnetaddress = '10.0.0.0/16'
param subnetaddress = '10.0.0.0/24'
param publicipName = 'lab03-Publicip'
param publicipSku = 'Standard'
param publicIPAllocationMethod = 'Static'
param dnsLabelPrefix = 'lab03-sqlvm'
param networkSecurityGroupName = 'lab03-nsg-sqlvm'


