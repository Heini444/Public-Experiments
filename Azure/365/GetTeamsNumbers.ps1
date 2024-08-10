# Install the Teams Module within PowerShell
Install-Module MicrosoftTeams

# Connect to Microsoft Teams PowerShell
Connect-MicrosoftTeams

#Get list of Users and export their details to csv
Get-CsOnlineUser -Filter {LineURI -ne $Null} | select DisplayName,LineURI,OnlineVoiceRoutingPolicy | Export-CSV c:\temp\teams.csv -NoTypeInformation
