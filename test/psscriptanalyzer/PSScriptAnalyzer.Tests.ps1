<# 
Improvements to consider:
  - Make "Context" data driven too
  - Include where failures occured in test result
#>
Describe "Testing against PSScriptAnalyzer Standard Rules" {  

    $Problems = Invoke-ScriptAnalyzer -Path "./../../src" -Recurse
    #$Problems = Invoke-ScriptAnalyzer -Path "./../../src/jira/public/api/issues" -Recurse

    Context "Information" {
        It "Should not violate rule: <_>" -ForEach (Get-ScriptAnalyzerRule -Severity Information)  {
            $Problems | Where-Object -Property RuleName -EQ $_ | Should -BeNullOrEmpty
        }
    }
    Context "Warning" {
        It "Should not violate rule: <_>" -ForEach (Get-ScriptAnalyzerRule -Severity Warning) {
            $Problems | Where-Object -Property RuleName -EQ $_ | Should -BeNullOrEmpty
        }
    }
    Context "Error" {
        It "Should not violate rule: <_>"  -ForEach (Get-ScriptAnalyzerRule -Severity Error)  {
            $Problems | Where-Object -Property RuleName -EQ $_ | Should -BeNullOrEmpty
        }
    }
}
