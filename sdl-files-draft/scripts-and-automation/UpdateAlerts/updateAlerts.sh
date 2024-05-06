#!/bin/bash

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
truncate -s -10 currentcontents.json
}

concatfiles() {
# Check if both files exist
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

if [ ! -f "$2" ]; then
    echo "Error: File '$2' does not exist."
    exit 1
fi

# Concatenate the files with comma and new line
cat "$1" <(echo ",") "$2" <(echo "]}")
}


#need to bring in the contents of the local concatenated alerts file and dump it to the content string on 44
putAlertstoSDL() {
curl -X POST https://xdr.us1.sentinelone.net/api/putFile \ 
    -H "Authorization: Bearer 0HuQ4SSXeO3dfoTUpOlbO3SoHCDqqlaGnVJTH8s2/Z4E-"  \ 
    -H "Content-Type: application/json" \ 
    -d '{
      "path": "/scalyr/alerts",
      "content": "// My Foo Dashboard"
    }'

}


DownloadAlerts > output.txt
JQExtractAlerts output.txt

concatfiles  currentcontents.json S1-EDr-Alerts.json > concatenated.txt


