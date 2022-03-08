param app string
param env string
param location string = 'eastus2'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'rg-${app}-${env}'
}

resource log 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  scope: rg
  name: 'log-${app}-${env}'
}

module containerEnv 'container-env.bicep' = {
  scope: rg
  name: 'containerEnv'
  params: {
    location: location 
    app: app
    env: env
    logAnalyticsId: log.properties.customerId
    logAnalyticsKey: log.listKeys().primarySharedKey
  }

  dependsOn:[
    log
  ]
}

module agentContainer 'container-app.bicep' = {
  scope: rg
  name: '${app}-container'
  params: {
    location: location 
    app: app
    env: env
    containerAppEnvId:containerEnv.outputs.containerEnvironmentId 
    containerImage: 'nginx:latest'
  }
  dependsOn:[
    containerEnv
  ]
}

