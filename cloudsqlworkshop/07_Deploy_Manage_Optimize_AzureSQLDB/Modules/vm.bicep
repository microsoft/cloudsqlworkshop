// Define parameters for the virtual machine configuration
param location string = resourceGroup().location
param vmName string
param vmComputerName string

param vmUsername string
@secure()
param vmAdminPassword string

param vmSize string
param diskType string
param imageSKU string

param nicName string
param subnetName string
param vnetName string

// Use an existing virtual network
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing  = {
  name: vnetName
}

// Use an existing subnet within the virtual network
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' existing  = {
  name: subnetName
  parent: vnet
}

// Create a network interface for the virtual machine
resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          // Associate the NIC with the existing subnet
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnet.name)     // Sets the ID of the subnet to associate with the NIC.
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// Create the virtual machine
resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  // Depend on the NIC resource to ensure it's created before the VM
  dependsOn: [
    nic
  ]
  properties: {
    hardwareProfile: {
      // Set the VM size
      vmSize: vmSize                                                            
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'                                               
        managedDisk: {
          // Set the disk type
          storageAccountType: diskType
        }
      }
      imageReference: {
        // Set the image reference for the OS disk
        publisher: 'MicrosoftSQLServer'
        offer: 'SQL2019-WS2019'
        sku: imageSKU
        version: 'latest'
      }
    }
    osProfile: {
      // Set the computer name, VM username, and password
      computerName: vmComputerName
      adminUsername: vmUsername
      adminPassword: vmAdminPassword
    }
    networkProfile: {
      // Associate the VM with the NIC
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', nic.name)
        }
      ]
    }
  }
}
