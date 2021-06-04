Describe 'Create-Workspace-and-Add-Workspace-Users' {
  BeforeAll {

      Mock 'Write-Host' -MockWith {}
      Mock 'Connect-PowerBIServiceAccount' -MockWith {}
      Mock 'Get-PowerBIWorkspace' -MockWith { }
      Mock 'New-PowerBIGroup' -MockWith { return @{Id = New-Guid} }
      Mock 'Add-PowerBIWorkspaceUser' -MockWith {}
      Mock 'Out-Null' -MockWith {}
  }
  Context "When creating workspace and adding workspace users" {
      It "Should connect"{
          .\Create-Workspace-and-Add-Workspace-Users.ps1
          Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
      }

      It "Should check Power BI Group workspace exists" {
        $expected = "*already exists"
        Mock 'Get-PowerBIWorkspace' -MockWith { return @{Id = New-Guid} }
        .\Create-Workspace-and-Add-Workspace-Users.ps1
        Should -Invoke -CommandName Get-PowerBIWorkspace -Exactly -Times 1
        Should -Invoke -CommandName Write-Host -Exactly -Times 1  -Scope It -ParameterFilter { $Object -like $expected }
    }

      It "Should create new Power BI Group workspace if it doesn't exist" {
          $expected = "Creating new *"
          .\Create-Workspace-and-Add-Workspace-Users.ps1
          Should -Invoke -CommandName New-PowerBIGroup -Exactly -Times 1
          Should -Invoke -CommandName Write-Host -Exactly -Times 1 -Scope It -ParameterFilter { $Object -like $expected }
      }

    It "Should add new PowerBI Workspace User" {
      .\Create-Workspace-and-Add-Workspace-Users.ps1
      Should -Invoke -CommandName Add-PowerBIWorkspaceUser -Exactly -Times 1
    }
  }
}
