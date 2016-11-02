Import-Module azure -verbose

Get-AzureRmResourceGroup
$groups = Get-AzureRmResourceGroup
$groups.count