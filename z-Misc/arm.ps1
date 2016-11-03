#Check Module Path: Before
Write-Host "$($env:PSModulePath.Split(';'))" -ForegroundColor Green

$azure1 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager"
$azure2 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\Storage"
$azure3 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement"

$env:PSModulePath=$env:PSModulePath+"$azure1"+"$azure2"+"$azure3"

#Check Module Path: After
Write-Host "$($env:PSModulePath.Split(';'))" -ForegroundColor Green

$groups = Get-AzureRmResourceGroup
Write-Host "$($groups.count)" -ForegroundColor Cyan

Write-Warning "$env:AGENT_NAME"