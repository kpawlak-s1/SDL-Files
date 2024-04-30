# Import the Active Directory module
Import-Module ActiveDirectory


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

