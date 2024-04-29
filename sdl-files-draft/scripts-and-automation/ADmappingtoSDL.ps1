# Import the Active Directory module
Import-Module ActiveDirectory

# Get a list of all users
$users = Get-ADUser -Filter *

# Loop through each user
foreach ($user in $users) {
    # Get the groups the user is a member of
    $userGroups = Get-ADPrincipalGroupMembership -Identity $user | Select-Object -ExpandProperty Name
    
    # Create an object with user's information and groups
    $userObject = [PSCustomObject]@{
        UserName = $user.Name
        Groups = $userGroups -join ', '
    }
    
    # Output the object to JSON
    $userObject | ConvertTo-Json
}