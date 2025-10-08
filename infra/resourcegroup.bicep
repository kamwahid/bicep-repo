targetScope= 'subscription'
param location string
param resourceGroupName string = 'myrgkamran1'
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
