
schtasks /create /tn "RunPowerShellScript" /tr "PowerShell.exe -File .\GatherADMapping.ps1 > ADMapping.json" /sc daily /mo 1 /st 00:01
schtasks /create /tn "RunPowerShellScript" /tr "PowerShell.exe -File .\UploadADMappingtoSDL.ps1" /sc daily /mo 1 /st 00:05