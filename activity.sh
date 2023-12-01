#!/bin/bash

# Set your API endpoint and authorization token
BASE_API_ENDPOINT="https://example.alienvault.cloud/api/2.0/userActivities"
AUTH_TOKEN="Bearer XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
OBJECT_TYPE="investigation"
SIZE="100"


# Array of object IDs
OBJECT_IDS=(
"xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
)
 


# Create a file to store the responses
OUTPUT_FILE="activity.txt"

# Iterate through note IDs from 1 to 360
for object_id in "${OBJECT_IDS[@]}"; do
    API_URL="${BASE_API_ENDPOINT}?object_id=${object_id}&object_type=${OBJECT_TYPE}&size=${SIZE}"
    response=$(curl -s "$API_URL")

    # Make the API request and store the response in a variable
    response=$(curl -i -s -k -X GET \
        -H "Host: example.alienvault.cloud" -H "Authorization: $AUTH_TOKEN" -H "User-Agent: PostmanRuntime/7.32.3" -H "Accept: */*" -H "Postman-Token: 8c810eb3-be73-40a2-b70b-91efd2d09ffa" -H "Accept-Encoding: gzip, deflate" -H "Connection: keep-alive" \
        -b "samesite=lax; JSESSIONID=XXXXXXXXXXXXXXXXXXXXXXXX" \
        "$API_URL")
        
    # Extract the response body using awk and add a separator
    response_body=$(echo "$response" | sed -n '/^\r$/,$p')
    echo "$response_body" >> "$OUTPUT_FILE"

    echo "--------------------------- Alarm details for Investigation: $object_id ---------------------------" >> "$OUTPUT_FILE"

    echo "Processed note ID: $object_id"
done


