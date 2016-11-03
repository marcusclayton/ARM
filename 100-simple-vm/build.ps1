Import-Module psake

function Invoke-TestFailure
{
    param(
        [parameter(Mandatory=$true)]
        [validateSet('Unit','Integration','Acceptance')]
        [string]$TestType,

        [parameter(Mandatory=$true)]
        $PesterResults
    )

    $errorID = if($TestType -eq 'Unit'){'UnitTestFailure'}elseif($TestType -eq 'Integration'){'InetegrationTestFailure'}else{'AcceptanceTestFailure'}
    $errorCategory = [System.Management.Automation.ErrorCategory]::LimitsExceeded
    $errorMessage = "$TestType Test Failed: $($PesterResults.FailedCount) tests failed out of $($PesterResults.TotalCount) total test."
    $exception = New-Object -TypeName System.SystemException -ArgumentList $errorMessage
    $errorRecord = New-Object -TypeName System.Management.Automation.ErrorRecord -ArgumentList $exception,$errorID, $errorCategory, $null

    Write-Output "##vso[task.logissue type=error]$errorMessage"
    Throw $errorRecord
}

FormatTaskName "--------------- {0} ---------------"

Properties {
    $TestsPath = "$PSScriptRoot\Tests"
    $TestResultsPath = "$TestsPath\Results"
    $ConfigPath = "$PSScriptRoot\Configs"
    #$ArtifactPath = "$Env:BUILD_ARTIFACTSTAGINGDIRECTORY"
    #$ModuleArtifactPath = "$ArtifactPath\Modules"
    #$MOFArtifactPath = "$ArtifactPath\MOF"
    #$RequiredModules = @(@{Name='PSake'}, @{Name='PoshSpec'}) 
}

Task Default -depends UnitTests

Task Clean {
    "Starting Cleaning enviroment..."

    #Remove Test Results from previous runs
    New-Item $TestResultsPath -ItemType Directory -Force
    Remove-Item "$TestResultsPath\*.xml" -Verbose 

    $Error.Clear()
}

Task GenerateEnvironmentFiles -Depends Clean {
     'Nothing to do here.'
}

Task InstallModules -Depends GenerateEnvironmentFiles {
    # Install resources on build agent
    "Installing required resources..."

    #Workaround for bug in Install-Module cmdlet
    if(!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction Ignore))
    {
        Install-PackageProvider -Name NuGet -Force
    }
    
    if (!(Get-PSRepository -Name PSGallery -ErrorAction Ignore))
    {
        Register-PSRepository -Name PSGallery -SourceLocation https://www.powershellgallery.com/api/v2/ -InstallationPolicy Trusted -PackageManagementProvider NuGet
    }
    
    #End Workaround
    
    <#foreach ($Resource in $RequiredModules)
    {
        Install-Module -Name $Resource.Name -Force
        #Save-Module -Name $Resource.Name -Path $ModuleArtifactPath -Repository 'PSGallery' -Force
    }
    #>

}


Task ScriptAnalysis -Depends InstallModules {
    # Run Script Analyzer
    "Starting static analysis..."
    Invoke-ScriptAnalyzer -Path $ConfigPath

}

Task UnitTests -Depends ScriptAnalysis {
    # Run Unit Tests with Code Coverage
    "Starting unit tests..."

    $PesterResults = Invoke-Pester -path "$TestsPath\Unit\" -CodeCoverage "$ConfigPath\*.ps1" -OutputFile "$TestResultsPath\UnitTest.xml" -OutputFormat NUnitXml -PassThru
    
    if($PesterResults.FailedCount) #If Pester fails any tests fail this task
    {
        Invoke-TestFailure -TestType Unit -PesterResults $PesterResults
    }
    
}

Task CompileConfigs -Depends UnitTests, ScriptAnalysis {
    'Nothing to do here.'
}

