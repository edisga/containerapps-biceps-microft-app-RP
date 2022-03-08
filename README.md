# Readme

This is just a test, not intented for production.

- `az deployment sub create  --location eastus2  --template-file resourcegroup.bicep  --parameters resourceGroupName='rg-edisga-prod' resourceGroupLocation='eastus2'`

- `az deployment group create --resource-group rg-edisga-prod  --template-file log-analytics.bicep --parameters app='edisga' env='prod' location='eastus2'`

- `az deployment sub create --location eastus2 --template-file main.bicep --parameters app='edisga' env='prod'`