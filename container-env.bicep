param location string
param app string
param env string
param logAnalyticsId string
param logAnalyticsKey string

resource contEnv 'Microsoft.App/managedEnvironments@2022-01-01-preview' = {
  name: 'managed-env-${app}-${env}'
  location: location
  tags: {
    app: app
    env: env
  }
  kind: 'containerenvironment'
  properties: {
    environmentType: 'managed'
    internalLoadBalancerEnabled: false
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsId
        sharedKey: logAnalyticsKey
      }
    }
  }
}

output containerEnvironmentId string = contEnv.id 
