Describe 'Create-Workspace' {
    BeforeAll {
        Mock 'Write-Host' -MockWith {}
        Mock 'Connect-PowerBIServiceAccount' -MockWith {}
        Mock 'New-PowerBIGroup' -MockWith { return "test" }
        Mock 'Out-Null' -MockWith {}
    }
    Context "When creating workspace" {
        It "Should connect"{
            .\Create-Workspace.ps1 
            Should -Invoke -CommandName Connect-PowerBIServiceAccount -Exactly -Times 1
        }

        It "Should create new Power BI Group workspace" {
            .\Create-Workspace.ps1 
            Should -Invoke -CommandName New-PowerBIGroup -Exactly -Times 1
        }
    }
}
