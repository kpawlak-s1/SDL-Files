DownloadAlerts() {
curl --location 'https://xdr.us1.sentinelone.net//getFile' \
--header 'Authorization: Bearer 0HuQ4SSXeO3dfoTUpOlbO3SoHCDqqlaGnVJTH8s2/Z4E-' \
--header 'Content-Type: application/json' \
--header 'Cookie: sp=3156b153-fa63-415c-910a-0a521f6eab06' \
--data '{
    "token": "0HuQ4SSXeO3dfoTUpOlbO3SoHCDqqlaGnVJTH8s2/Z4E-",
    "path": "/scalyr/alerts",
}'
}

JQExtractAlerts() {

local file="$1"
Filecontent=$(<"$file")
echo "$Filecontent" | jq -r '.content' > currentcontents.json


}

DownloadAlerts > output.txt
JQExtractAlerts output.txt