param location string = resourceGroup().location
param vmNames array
param adminUsername string
@secure()
param adminPassword string
param existingVnetName string
param vmSize string = 'Standard_DS1_v2'
param imagePublisher string = 'MicrosoftWindowsServer'
param imageOffer string = 'WindowsServer'
param imageSku string = '2025-Datacenter'
param imageVersion string = 'latest'

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  name: existingVnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' existing = {
  parent: vnet
  name: 'appsubnet'
}

@batchSize(1)
resource nic 'Microsoft.Network/networkInterfaces@2023-05-01' = [for vmName in vmNames: {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}]

@batchSize(1)
resource vmResources 'Microsoft.Compute/virtualMachines@2023-03-01' = [for (vmName, i) in vmNames: {
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
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic[i].id
        }
      ]
    }
  }
}]
