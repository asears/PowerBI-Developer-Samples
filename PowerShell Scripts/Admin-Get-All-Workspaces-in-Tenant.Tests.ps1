Describe 'Admin-Get-All-Workspaces-in-Tenant' {
    BeforeAll {
        Mock 'Write-Host' -MockWith {}
        Mock 'Connect-PowerBIServiceAccount' -MockWith {}
        Mock 'Get-PowerBIWorkspace' -MockWith { }
        Mock 'Out-Null' -MockWith {}
    }
    Context "When Admin Get All Workspaces in Tenant" {
        It "Should connect"{
            .\Admin-Get-All-Workspaces-in-Tenant.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
        }
    }
  }
