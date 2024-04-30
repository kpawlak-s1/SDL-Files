$EnableADMappingurl = "https://github.com/kpawlak-s1/SDL-Files/blob/main/sdl-files-draft/scripts-and-automation/GatherADMapping.ps1"
$EnableADMappingoutputFile = "EnableADmapping.ps1"

Invoke-WebRequest -Uri $EnableADMappingurl -OutFile $EnableADMappingoutputFile

$UploadADMappingtoSDLurl = "https://github.com/kpawlak-s1/SDL-Files/blob/main/sdl-files-draft/scripts-and-automation/UploadADMappingtoSDL.ps1"
$UploadADMappingtoSDLoutputFile = "UploadADMappingtoSDL.ps1"

Invoke-WebRequest -Uri $nUploadADMappingtoSDL -OutFile $UploadADMappingtoSDL


schtasks /create /tn "RunPowerShellScript" /tr "PowerShell.exe -File .\GatherADMapping.ps1" /sc daily /mo 1 /st 00:01
schtasks /create /tn "RunPowerShellScript" /tr "PowerShell.exe -File .\UploadADMappingtoSDL.ps1" /sc daily /mo 1 /st 00:05