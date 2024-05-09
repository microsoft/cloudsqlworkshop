// Specify the main Bicep file to use for deployment
using 'main.bicep'

param sqlmiName = 'lab05-sqlmi'
param adminLogin = 'adminsqlmi'
param adminPassword = 'P@ssword12!'

param virtualNetworkName = 'lab05-vnet'
param addressPrefix = '10.0.0.0/16'
param subnetName = 'lab05-subnet'
param subnetPrefix = '10.0.0.0/24'
param skuName = 'GP_Gen5'
param vCores = 16
param storageSizeInGB = 256
param licenseType = 'LicenseIncluded'
