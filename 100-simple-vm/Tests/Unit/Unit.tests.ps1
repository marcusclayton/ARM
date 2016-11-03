####################################################################
# Unit tests for DNSServer
#
# Unit tests content of DSC configuration as well as the MOF output.
####################################################################

#region

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Verbose $here
$parent = Split-Path -Parent $here
$GrandParent = Split-Path -Parent $parent
Write-Verbose $GrandParent
$configPath = Join-Path $GrandParent "Configs"
Write-Verbose $configPath
$sut = ($MyInvocation.MyCommand.ToString()) -replace ".Tests.","."
Write-Verbose $sut
#. $(Join-Path -Path $configPath -ChildPath $sut)


#endregion

try{
$azure1 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager"
$azure2 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\Storage"
$azure3 = ";" + "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement"
$env:PSModulePath=$env:PSModulePath+"$azure1"+"$azure2"+"$azure3"
}
catch{
'Error'
}

Describe "Pre-flight checks." {
    Context "Looking for required Azure Modules."{
        
        It "Should exist." {
            (Get-Module Azure -ListAvailable).Name | Should be "Azure"
        }

        It "Should be version 3.x.x" {
            (Get-Module Azure -ListAvailable).version.Major | Should be "3"
        }

    }

    Context "Node Configuration" {
        $OutputPath = "TestDrive:\"
        
        It "Should not be null" {
            "$configPath\pesterfilecheck.md" | Should Exist
        }
        
        It "Should find a single file." { 
            (Get-ChildItem -Path $configPath -File -Filter "*.md" -Recurse ).count | Should be 1
        }
                
        It "Should contain a string." {
            Join-Path $configPath "pesterfilecheck.md" | Should Contain "Version=`"2.0.0`""
        }
        
        #Clean up TestDrive between each test
        AfterEach {
            Remove-Item TestDrive:\* -Recurse
        }

    }
}
