# Import the Active Directory module
Import-Module ActiveDirectory


function GatherADMapping {
# Get a list of all users
$users = Get-ADUser -Filter *

$columnNamesString = '{ columnNames: ["UserName","Groups"],'
$columnNamesString 
$rowString = 'rows: ['
$rowString


# Loop through each user
foreach ($user in $users) {
    # Get the groups the user is a member of
    $userGroups = Get-ADPrincipalGroupMembership -Identity $user | Select-Object -ExpandProperty Name
    
    # Output the object to JSON
    $formattedUserName = $user.SamAccountName
    $formattedUserGroupObject = "[ '$formattedUserName','$userGroups' ],"
    $formattedString2 = $formattedUserGroupObject -replace "'", '"'
    $formattedString2
    }

$endString = ']}'
$endString

}

# Call the function
GatherADMapping > .\ADMapping.json

$rawFilePath = ".\ADMapping.json"

$preJSONCleanup = Get-Content -Path $rawFilePath -raw

$removeNewLines = $preJSONCleanup -replace "`r`n|`r|`n", ""

$backslashQuotes = $removeNewLines -replace '"','\"'

$uploadReady = $backslashQuotes -replace "],","],\n"



$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer your-api-token-here")
$headers.Add("Content-Type", "application/json")
$headers.Add("Cookie", "sp=3156b153-fa63-415c-910a-0a521f6eab06")

$body = @"
{
    `"token`": `"0HuQ4SSXeO3dfoTUpOlbO3SoHCDqqlaGnVJTH8s2/Z4E-`",
    `"path`": `"/datatables/AD-User-Group-Mapping.json`",
    `"content`": `"$uploadReady`"
}
"@

$response = Invoke-RestMethod 'https://xdr.us1.sentinelone.net//putFile' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json