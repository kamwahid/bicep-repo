
param vnetName string = 'kamranvnet1'
param location string = 'australiasoutheast'
param nsgId string

module vnetMod './modules/vnet.bicep' ={
 name: 'vnetdeployment' 
 params:{
  vnetName: vnetName
  location: location
  nsgId: nsgId
 }
}

module nsgMod 'modules/nsg.bicep' ={
  name: 'nsgdeployment'
  params: {
    location: location
  }
}

