param app string
param env string
param location string

resource wkspce 'microsoft.operationalinsights/workspaces@2021-12-01-preview' = {
  location: location
  name: 'log-${app}-${env}'
  properties: {
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: 5
    }
  }
}

output id string = wkspce.id
