Describe 'DeploymentPipelines-DeployAll' {
    BeforeAll {
        Mock 'Write-Host' -MockWith {}
        Mock 'Out-Null' -MockWith {}
        Mock 'Start-Sleep' -MockWith {}
        Mock 'Connect-PowerBIServiceAccount' -MockWith {} 
        Mock 'Invoke-PowerBIRestMethod' -MockWith { }
        Mock 'Resolve-PowerBIError' -MockWith {}
    }
    Context "When DeploymentPipelines Deploy All" {
        It "Should connect" {
            .\DeploymentPipelines-WaitForDeployment.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
        }
        It "Should return error if pipeline not found" {
            .\DeploymentPipelines-WaitForDeployment.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
            Should -Invoke -CommandName Invoke-PowerBIRestMethod -Exactly -Times 1
            Should -Invoke -CommandName Write-Host -Exactly -Times 1 -Scope It -ParameterFilter { $Object -like "*name was not found" }
        }
        It "Should handle error" {
            Mock 'Invoke-PowerBIRestMethod' -MockWith { Throw 'Some Error' }
            .\DeploymentPipelines-WaitForDeployment.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
            Should -Invoke -CommandName Resolve-PowerBIError -Exactly -Times 1
        }
    }
}
