#Check Module Path: Before
write-verbose "$($env:PSModulePath.Split(';'))"

$azure1 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager"
$azure2 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\Storage"
$azure3 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement"

$env:PSModulePath=$env:PSModulePath+"$azure1"+"$azure2"+"$azure3"

#Check Module Path: After
write-verbose "$($env:PSModulePath.Split(';'))"

Get-AzureRmResourceGroup
$groups = Get-AzureRmResourceGroup
write-verbose "$($groups.count)"
