
param vnetName string = 'kamranvnet1'
param location string = 'australiasoutheast'



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

