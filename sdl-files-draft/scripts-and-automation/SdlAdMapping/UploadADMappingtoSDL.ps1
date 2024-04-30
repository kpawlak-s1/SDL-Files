PowerShell.exe -File .\GatherADMapping.ps1 > .\ADMapping.json

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