
param vnetName string = 'kamranvnet1'
param location string = 'australiasoutheast'
@secure()
param adminPassword string
param adminUsername string = 'azureuser'


module nsgMod 'modules/nsg.bicep' ={
  name: 'nsgdeployment'
  params: {
    location: location
  }
}
module vnetMod './modules/vnet.bicep' ={
 name: 'vnetdeployment' 
 params:{
  vnetName: vnetName
  location: location
  nsgId: nsgMod.outputs.nsgId
 }
}

resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'VM1'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    osProfile: {
      computerName: 'VM1'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: 'id'
        }
      ]
    }
  }
}
