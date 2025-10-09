
param vnetName string
param location string 
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
resource nic 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'vm1-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnetMod.outputs.virtualNetworkId}/subnets/subnet-1'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgMod.outputs.nsgId
    }
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
          id: nic.id
        }
      ]
    }
  }
}
