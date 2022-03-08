param location string
param app string
param env string
param containerAppEnvId string
param containerimage string
param storageaccount string

resource sa 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageaccount
}

resource container 'Microsoft.App/containerApps@2022-01-01-preview' = {
  name: containerimage
  location: location
  tags: {
    app: app
    env: env
  }
  kind: 'containerapp'
  properties: {
    configuration: {
      ingress: {
        external: true
        targetPort: 3000
      }
    }
    managedEnvironmentId: containerAppEnvId
    template: {
      containers: [
        {
          image: 'dapriosamples/hello-k8s-node:latest'
          name: 'string'
          resources: {
            cpu: 1
            memory: '2Gi'
          }
        }
      ]
      scale: {
        maxReplicas: 1
        minReplicas: 1
      }
      dapr:{
        enabled: true
        appPort: 3000
        appId: containerimage
        secrets: 'storage-account-name=${sa.name},storage-account-key=${sa.listKeys().keys[0].value}'
        components: 'components.yaml'
      }
    }
  }
}
