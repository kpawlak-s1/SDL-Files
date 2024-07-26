#!/usr/bin/python

#pre-requisites: 
# 1. input your S1 console url (xxx.sentinelone.net typically) in line 12 for the url
# 2. must have python installed 
# 3. generate an API token from your S1 console and add it in line 18
import requests
import re
import json
# Path to the output file
raw_file = "raw.txt"
edited_file="clean.txt"

url = "https://YOUR-S1-URL-HERE/web/api/v2.1/agents"

payload = {}
headers = {
  'Authorization': 'ApiToken YOUR_API_TOKEN_HERE'
}

response = requests.request("GET", url, headers=headers, data=payload)

# Open the file in write mode
with open(raw_file, "w") as file:
    # Redirect print output to the file
    print(response.text, file=file)

print(f"Output written to {raw_file}.")

# Read the entire content of the input file
with open(raw_file, "r") as infile:
    content = infile.read()

# Find the starting index of the substring `,"pagination"`
start_index = content.find(',"pagination"')

# If the substring is found, modify the content
if start_index != -1:
    # Replace everything from `,"pagination"` to the end with `}`
    new_content = content[:start_index] + '}'
else:
    # If `,"pagination"` is not found, keep the content unchanged
    new_content = content

# Write the modified content to the output file
with open(edited_file, "w") as outfile:
    outfile.write(new_content)


print(f"File processed. Check {edited_file} for the results.")


# Paths to the input and output JSON files
input_file = "clean.txt"
output_file = "output.jsonl"  # Using .jsonl extension for JSON Lines format

# Function to extract the required fields from each JSON object
def extract_fields(data):
    return {
        "computerName": data.get("computerName"),
        "externalIp": data.get("externalIp"),
        "lastLoggedInUserName": data.get("lastLoggedInUserName")
    }

# Read the input JSON file
with open(input_file, "r") as infile:
    input_data = json.load(infile)

# Ensure 'data' key exists and is a list
if "data" in input_data and isinstance(input_data["data"], list):
    extracted_data = [extract_fields(item) for item in input_data["data"]]
else:
    print("Invalid input format. 'data' key is missing or not a list.")
    extracted_data = []

# Write each extracted JSON object to a new line in the output file
with open(output_file, "a") as outfile:
    for item in extracted_data:
        json_line = json.dumps(item)
        outfile.write(json_line + "\n")

print(f"Extraction completed. Check {output_file} for the results.")
