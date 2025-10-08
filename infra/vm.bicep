
param vnetName string
param location string

module vnetMod './modules/vnet.bicep' ={
 name: 'vnetdeployment' 
 params:{
  vnetName: vnetName
  location: location
 }
}
