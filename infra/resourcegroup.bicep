targetScope= 'subscription'
param resourceGroupName string = 'myrgkamran'
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: 'australiasoutheast'
}
