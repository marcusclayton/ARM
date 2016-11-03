param(
    [parameter()]
    [string]
    $Uri
)


    # these values would be retrieved from or set by an application
    $status = 'success'
    $fact1 = 'All tests passed.'
    $fact2 = 'None'

    $body = ConvertTo-Json -Depth 4 @{
        title = 'New Build Notification'
        text = "A build completed with status $status"
        sections = @(
            @{
                activityTitle = 'Build'
                activitySubtitle = 'automated test platform'
                activityText = 'A change was evaluated and new results are available.'
                activityImage = 'https://mcautomationgitresources.blob.core.windows.net/images/GitHub-Mark-64px.png' # this value would be a path to a nice image you would like to display in notifications
            },
            @{
                title = 'Details'
                facts = @(
                    @{
                    name = 'Unit Tests'
                    value = $fact1
                    },
                    @{
                    name = 'Integration Tests'
                    value = $fact2
                    }
                )
            }
        )
    }


    Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json'

