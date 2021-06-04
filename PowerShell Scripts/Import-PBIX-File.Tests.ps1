Describe 'Import-PBIX-File' {
  BeforeAll {
      Mock 'Write-Host' -MockWith {}
      Mock 'Out-Null' -MockWith {}
      Mock 'Connect-PowerBIServiceAccount' -MockWith {}
      Mock 'Get-PowerBIWorkspace' -MockWith { }
      Mock 'New-PowerBIGroup' -MockWith { return @{Id = New-Guid} }
      Mock 'New-PowerBIReport' -MockWith { }
  }
  Context "When Import PBIX File" {
      It "Should connect"{
          .\Import-PBIX-File.ps1
          Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
      }
      It "Should check Power BI Group workspace exists" {
        Mock 'Get-PowerBIWorkspace' -MockWith { return @{Id = New-Guid} }
        .\Import-PBIX-File.ps1
        Should -Invoke -CommandName Get-PowerBIWorkspace -Exactly -Times 1
        Should -Invoke -CommandName Write-Host -Exactly -Times 1  -Scope It -ParameterFilter { $Object -like "*already exists" }
    }

      It "Should create new Power BI Group workspace if it doesn't exist" {
          # "Creating new workspace named $workspaceName"
          .\Import-PBIX-File.ps1
          Should -Invoke -CommandName New-PowerBIGroup -Exactly -Times 1
          Should -Invoke -CommandName Write-Host -Exactly -Times 1 -Scope It -ParameterFilter { $Object -like "Creating new *" }
      }

    It "Should CreateOrOverwrite New PowerBI Report" {
      # "user1@tenant1.onMicrosoft.com"
      .\Import-PBIX-File.ps1
      Should -Invoke -CommandName New-PowerBIReport -Exactly -Times 1
    }
  }
}
