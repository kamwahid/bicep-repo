targetScope= 'subscription'
param resourceGroupName string
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: 'australiasoutheast'
}

output rgname string = rg.name
