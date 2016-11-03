param(
    [parameter()]
    [ValidateSet('Build','Deploy')]
    [string]
    $fileName
)

#$Error.Clear()

Invoke-PSake $PSScriptRoot\100-simple-vm\$filename.ps1

<#if($Error.count)
{
    Throw "$fileName script failed. Check logs for failure details."
}
#>