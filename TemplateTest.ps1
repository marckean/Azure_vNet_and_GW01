# Login to Azure with a Service Principal
# Create an AAD Service Principal | https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli
$SubscriptionId = '6bb00255-5486-4db1-96ca-5baefc18b0b2'
$AADAppId = 'ea77ac17-5785-419b-a198-aaa384421905' # 201809MarcKeanSP_CLI
$securePass = Read-Host "Azure password: " -AsSecureString
$TenantId = '72f988bf-86f1-41af-91ab-2d7cd011db47' # microsoft.onmicrosoft.com
$Cred = New-Object System.Management.Automation.PSCredential ($AADAppId, $securePass)
Connect-AzureRmAccount -Credential $cred -ServicePrincipal -TenantId $TenantId

Select-AzureRmSubscription -SubscriptionId $SubscriptionId

#region Test the template
$DebugPreference = "Continue"
$TemplateArgs = New-Object -TypeName Hashtable
$TemplateArgs.Add('adminUsername', 'marckean')
$TemplateArgs.Add('adminPassword', ('Passw0rd2019' | ConvertTo-SecureString -AsPlainText -Force))

Test-AzureRmResourceGroupDeployment -ResourceGroupName 'Ausgridfw' -Mode 'Complete' `
-TemplateUri 'https://raw.githubusercontent.com/marckean/AzureFirewall02/master/azuredeploy.json' `
@TemplateArgs 5>&1
$DebugPreference = "SilentlyContinue"
#endregion