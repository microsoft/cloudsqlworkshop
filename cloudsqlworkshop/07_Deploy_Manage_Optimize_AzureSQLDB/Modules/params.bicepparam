// Specify the main Bicep file to use for deployment
using 'main.bicep'

// Define parameters related to SQL database configuration
param serverName = 'lab01-server'
param dbName = 'lab01-db'
param skuName = 'Basic'
param skuTier = 'Basic'
param skuSize = 'Basic'
param adminUsername = 'lab01-admin'
@secure() 
param adminPassword = 'P@ssword12!'

// Define parameters related to virtual machine configuration
param vmName = 'lab01-vm'
param vmComputerName = 'lab01-vm'
param vmUsername = 'azureuser'
@secure() 
param vmAdminPassword = 'P@ssword12!'

param vmSize = 'Standard_D2s_v3'
param diskType = 'Premium_LRS'
param imageSKU = 'SQLDEV'
param nicName = 'lab01-nic'

// Define networking parameters for the virtual network and subnet
param subnetName = 'default'
param vnetName = 'lab01-vnet'
param vnetaddressPrefix = '10.0.0.0/16'
param subnetaddressPrefix = '10.0.0.0/24'
