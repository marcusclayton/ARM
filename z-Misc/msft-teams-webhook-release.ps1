param(
    [parameter()]
    [string]
    $Uri,
    [string]
    $slot
)


    # these values would be retrieved from or set by an application
    $status = 'success'
    $fact1 = 'None'
    $fact2 = 'None'

    $body = ConvertTo-Json -Depth 4 @{
        title = 'New Release Notification'
        text = "A release completed with status $status"
        sections = @(
            @{
                activityTitle = 'Release'
                activitySubtitle = 'automated test platform'
                activityText = 'A change was evaluated and new results are available.'
                activityImage = 'https://mcautomationgitresources.blob.core.windows.net/images/GitHub-Mark-64px.png' # this value would be a path to a nice image you would like to display in notifications
            },
            @{
                title = 'Details'
                facts = @(
                    @{
                    name = 'Environment'
                    value = $slot
                    },
                    @{
                    name = 'Integration Tests'
                    value = $fact1
                    },
                    @{
                    name = 'Acceptance Tests'
                    value = $fact2
                    }
                )
            }
        )
    }


    Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json'