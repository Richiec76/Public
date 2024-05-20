#Connect-AzAccount
Connect-AzAccount -Tenant '67f438d6-119c-4716-a38c-df2220e7b240'

#$context = Get-AzSubscription -SubscriptionName 'Concierge Subscription'
Set-AzContext f78e0c11-8c2f-4e35-ae7c-c61d27b2ebd6 #$context


#Set Directory location
cd C:\AzureStuff\Bicep
#cd C:\AzureStuff\Bicep\modules

#Prompt for Parameters
# Prompt for resource group name and location
$resourceGroupName = Read-Host -Prompt "Enter the name for the new resource group"
$lresourceGroupLocation = Read-Host -Prompt "Enter the location for the new resource group"

#Prompt for VNet Name and Address Prefix
$virtualNetworkName = Read-Host -Prompt "Enter the name for the new Virtual Network"
$virtualNetworkAddressPrefix = Read-Host -Prompt "Enter the IP Range for the VNet"

# Set the Bicep file path
$bicepFilePath = "AzureVirtualDeskop.bicep"

# Deploy using New-AzSubscriptionDeployment
New-AzSubscriptionDeployment -Name AVDScriptDeployment-Resources -TemplateFile main-avd.bicep




# Testing Full Script (with RG, VNet, Subnet, Nics, VM, SQL VM, Storeage Ac, RSV)
cd C:\AzureStuff\ChatGPT-Bicep
New-AzSubscriptionDeployment -Name AVDScriptDeployment-ResourceGroups -location northeurope -TemplateFile resourcegroup-main.bicep
New-AzResourceGroupDeployment -Name AVDScriptDeployment-Resources -location northeurope -TemplateFile main.bicep
New-AzResourceGroupDeployment -Name AVDScriptDeployment-Resources -TemplateFile main.bicep

