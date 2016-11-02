if($env:AGENT_NAME -like '*HOSTED*'){

    $azure1 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager"
    $azure2 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\Storage"
    $azure3 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement"

    $env:PSModulePath=$env:PSModulePath+"$azure1"+"$azure2"+"$azure3"
    write-host ("##vso[task.setvariable variable=PSModulePath]$($env:PSModulePath)")
    
}