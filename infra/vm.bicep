
param vnetName string = 'kamranvnet1'
param location string = 'australiasoutheast'

module vnetMod './modules/vnet.bicep' ={
 name: 'vnetdeployment' 
 params:{
  vnetName: vnetName
  location: location
 }
}
