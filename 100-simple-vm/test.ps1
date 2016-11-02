<#$hash = @{
    AGENT_MACHINE_NAME = $env:AGENT_MACHINE_NAME
    AGENT_ID
    AGENT_NAME

}

$blob = @"
$env:AGENT_MACHINE_NAME
$env:
"@
#>

Write-Warning "AGENT_NAME is: $env:AGENT_NAME"

<#if($env:AGENT_NAME -like '*HOSTED*'){
    Write-Warning
    
}
#>

<#
$azure1 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager"
$azure2 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\Storage"
$azure3 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement"

$env:PSModulePath=$env:PSModulePath+"$azure1"+"$azure2"+"$azure3"
#>