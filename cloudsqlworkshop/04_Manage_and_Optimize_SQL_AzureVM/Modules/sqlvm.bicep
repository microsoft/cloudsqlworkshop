// Define parameters to customize the deployment
param location string  = resourceGroup().location
param vmName string
param vmSize string
param adminUsername string
@secure()
param adminPassword string
param SKU string
param nicName string
param subnetName string
param vnetName string
param publicipName string
param publicipSku string
param publicIPAllocationMethod string
param dnsLabelPrefix string

// Create a virtual network
resource vnet 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: vnetName
}

// Create a subnet
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' existing = {
  parent: vnet
  name: subnetName
}

// Create a public IP address
resource publicip 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: publicipName
  location: location
  sku: {
    name: publicipSku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsSettings: {
      domainNameLabel: '${resourceGroup().name}-${dnsLabelPrefix}'
    }
  }
}

// Create a network interface
resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'NetworkInterfaceConfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicip.id
          }
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}

// Create a virtual machine
resource SQLvm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: {
        publisher: 'MicrosoftSQLServer'
        offer: 'SQL2019-WS2019'
        sku: SKU
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces',nic.name)
        }
      ]
    }
  }
}
