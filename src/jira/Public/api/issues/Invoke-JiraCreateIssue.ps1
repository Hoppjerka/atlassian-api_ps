function Invoke-JiraCreateIssue {

    [CmdletBinding(DefaultParameterSetName)]
    param (
        # Mandatory Fields
        [Parameter(Mandatory)][Int]$ProjectID, 
        [Parameter(Mandatory)][Int]$IssueTypeID,
        [Parameter(Mandatory)][String]$Summary,
        # Optional Fields
        [Parameter()][String]$Description,
        [Parameter()][String]$ReporterID,
        [Parameter()]$ComponentIDs,
        [Parameter()][Int]$PriorityID,
        [Parameter()]$Labels,
        [Parameter()][Alias('FixVersion')]$FixVersions,
        [Parameter()][Int]$ParentKey
    )

    $BaseURL = "https://<example>.atlassian.net/rest/api/3/issue"
    $Method = "POST"
    $Headers = @{}
    $Headers["Authorization"] = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("<login username>:<api token>"))
    $Headers["X-Atlassian-Token"] = "nocheck"

    # Set mandatory fields
    [PSCustomObject]$Fields = @{
        "project"   = @{"id" = $ProjectID }
        "issuetype" = @{"id" = $IssueTypeID }
        "summary"   = $Summary
    }
    # Add optional fields if provided
    if ($Description) {
        $Fields["description"] = @{
            "type"    = "doc"
            "version" = 1
            "content" = [System.Collections.ArrayList]@(
                @{"type" = "paragraph"; "content" = @(
                        @{ "text" = $Description; "type" = "text" }
                    ) 
                }
            )
        }
    }
    if ($ReporterID) {
        $Fields["reporter"] = @{"id" = $ReporterID }
    }
    if ($ComponentIDs) {
        $Fields["components"] = [System.Collections.ArrayList]@()
        foreach ($item in $ComponentIDs) {
            $null = $Fields["components"].Add( @{ "id" = $item } )
        }
    }
    if ($PriorityID) {
        $Fields["priority"] = @{"id" = $PriorityID }
    }
    if ($Labels) {
        $Fields["labels"] = [System.Collections.ArrayList]@()
        foreach ($item in $Labels) {
            $null = $Fields["labels"].Add($item)
        }
    }
    if ($FixVersions) {
        $Fields['fixVersions'] = [System.Collections.ArrayList]@()
        foreach ($item in $FixVersions) {
            $null = $Fields["fixVersions"].Add( @{ "id" = $item } )
        }
    }
    if ($ParentKey) { $Fields["parent"] = @{"key" = $ParentKey } }


    # Bake it all up and convert to Json
    # Adjust Depth if the final $Body ends up too nested
    $HashTable = @{"fields" = $Fields }
    $Body = (ConvertTo-Json -InputObject $HashTable -Depth 7)

    # Invoke :^)
    $Result = Invoke-WebRequest `
        -Uri $BaseURL `
        -Method $Method `
        -Body $Body `
        -Headers $Headers `
        -ContentType "application/json"

    return $Result
}