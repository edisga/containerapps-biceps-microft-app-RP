//https://docs.microsoft.com/en-us/azure/container-apps/azure-resource-manager-api-spec
param location string
param app string
param env string
param containerAppEnvId string
param containerImage string

resource container 'Microsoft.App/containerApps@2022-01-01-preview' = {
  name: app
  location: location
  tags: {
    app: app
    env: env
  }
  kind: 'containerapp'
  properties: {
    configuration: {
      activeRevisionsMode: 'single'
      ingress: {
        allowInsecure: true
        external: true
        targetPort: 80
        transport: 'auto'
      }
    }
    managedEnvironmentId: containerAppEnvId
    template: {
      containers: [
        {
          image: containerImage
          name: 'string'
          resources: {
            cpu: 1
            memory: '2Gi'
          }
        }
      ]
      scale: {
        maxReplicas: 3
        minReplicas: 0
      }
    }
  }
}
