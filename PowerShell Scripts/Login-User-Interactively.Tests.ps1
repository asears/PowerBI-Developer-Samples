Describe 'Login-User-Interactively' {
    BeforeAll {
        Mock 'Write-Host' -MockWith {}
        Mock 'Out-Null' -MockWith {}
        Mock 'Connect-PowerBIServiceAccount' -MockWith {}
        Mock 'Get-PowerBIWorkspace' -MockWith { }
    }
    Context "When Login User Interactively" {
        It "Should connect"{
            .\Login-User-Interactively.ps1
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
        }
        It "Should get Power BI Group workspace details" {
          Mock 'Get-PowerBIWorkspace' -MockWith { return @{Id = New-Guid} }
          .\Login-User-Interactively.ps1
          Should -Invoke -CommandName Get-PowerBIWorkspace -Exactly -Times 1
      }
    }
  }