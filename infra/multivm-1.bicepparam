using './multivm-1.bicep'
// Parameters for multiVM.bicep
param vmNames = [
  'kamvm1'
  'kamVM2'
  'kamVM3'
]

param adminUsername = 'azureuser'

@secure()
param adminPassword = 'Kamran@1234'

param existingVnetName = 'kamvnet'
