$modules = Get-Module azure* -listavailable
$modules.count

Import-Module Azure -ErrorAction SilentlyContinue

try {
    [Microsoft.Azure.Common.Authentication.AzureSession]::ClientFactory.AddUserAgent("VSAzureTools-$UI$($host.name)".replace(" ","_"), "2.9.5")
} catch { }

Set-StrictMode -Version 3



<#Import-Module azure -verbose

Get-AzureRmResourceGroup
$groups = Get-AzureRmResourceGroup
$groups.count
#>