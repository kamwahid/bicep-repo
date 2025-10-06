targetScope= 'subscription'

param rgName1 string
param rgName2 string

module RG1 'resourcegroup.bicep' = {
  scope: subscription('c1903185-088d-4d0c-8557-94baacb3afeb')
  name: 'deploy-rg1'
  params: {
    resourceGroupName: rgName1
  }
}

module RG2 'resourcegroup.bicep' = {
  scope: subscription('c1903185-088d-4d0c-8557-94baacb3afeb')
  name: 'deploy-rg2'
  params: {
    resourceGroupName: rgName2
  }
}

output RG1 string = RG1.outputs.rgname
output RG2 string = RG2.outputs.rgname
