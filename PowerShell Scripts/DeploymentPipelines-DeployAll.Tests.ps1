Describe 'DeploymentPipelines-DeployAll' {
    BeforeAll {
        Mock 'Write-Host' -MockWith {}
        Mock 'Out-Null' -MockWith {}
        Mock 'Connect-PowerBIServiceAccount' -MockWith {} 
        Mock 'Invoke-PowerBIRestMethod' -MockWith { }
        Mock 'Resolve-PowerBIError' -MockWith {}
    }
    Context "When DeploymentPipelines Deploy All" {
        It "Should connect" {
            .\DeploymentPipelines-DeployAll.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
        }
        It "Should return error if pipeline not found" {
            .\DeploymentPipelines-DeployAll.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
            Should -Invoke -CommandName Invoke-PowerBIRestMethod -Exactly -Times 1
            Should -Invoke -CommandName Write-Host -Exactly -Times 1 -Scope It -ParameterFilter { $Object -like "*name was not found" }
        }
        It "Should send request without error" {
            Mock 'Invoke-PowerBIRestMethod' -MockWith { return @{ value = @{DisplayName = " FILL ME IN " }} | ConvertTo-Json }
            .\DeploymentPipelines-DeployAll.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
            Should -Invoke -CommandName Invoke-PowerBIRestMethod -Exactly -Times 1 -Scope It -ParameterFilter { $Url -like "*DeployAll*" }
        }
        It "Should handle error" {
            Mock 'Invoke-PowerBIRestMethod' -MockWith { Throw 'Some Error' }
            .\DeploymentPipelines-DeployAll.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
            Should -Invoke -CommandName Resolve-PowerBIError -Exactly -Times 1
        }
    }
  }