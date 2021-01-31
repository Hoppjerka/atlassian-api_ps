BeforeAll {
    . $PSScriptRoot/../../../../src/jira/Public/api/issues/Invoke-JiraCreateIssue.ps1
}

Describe "Invoke-JiraCreateIssue" -Tag "Unit" {
    Context "Input testing min vs max " {
        It "creates a new issue with all available parameters" {
            Write-Host "OK"
        }
        It "creates a new with  mandatory parameters" {
            Write-Host "OK"
        }
    }
    Context "Project" {
        It "creates an issue for a project" {
            Write-Host "OK"
        }
        It "creates an issue for a project that doesn't exist" {
            Write-Host "OK"
        }
    }
    Context "Issue Types" {
        It "creates an issue for each validated issue type" {
            Write-Host "OK"
        }
        It "creates an issue for an invalid issue type" {
            Write-Host "OK"
        }
    }
    Context "Reporter" {
        It "create an issue with a reporter" {
            Write-Host "OK"
        }
        It "creates an issue without a reporter" {
            Write-Host "OK"
        }
    }
}
