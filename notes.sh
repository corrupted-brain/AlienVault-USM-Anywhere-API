#!/bin/bash

# Set your API endpoint and authorization token
BASE_API_ENDPOINT="https://example.alienvault.cloud/api/2.0/investigations"
AUTH_TOKEN="Bearer XXXXXXXXXXXXXXXXXXXXXX"

# Create a file to store the responses
OUTPUT_FILE="notes.txt"

# Iterate through note IDs from 1 to 360
for note_id in {0..360}; do
    # Construct the API endpoint with the current note_id
    API_ENDPOINT="$BASE_API_ENDPOINT/$note_id/notes"

    # Make the API request and store the response in a variable
    response=$(curl -i -s -k -X GET \
        -H "Host: example.alienvault.cloud" -H "Authorization: $AUTH_TOKEN" -H "User-Agent: PostmanRuntime/7.32.3" -H "Accept: */*" -H "Postman-Token: 8c810eb3-be73-40a2-b70b-91efd2d09ffa" -H "Accept-Encoding: gzip, deflate" -H "Connection: keep-alive" \
        -b "samesite=lax; JSESSIONID=XXXXXXXXXXXXXXXXXXXXXX" \
        "$API_ENDPOINT")

    # Extract the response body using awk and add a separator
    response_body=$(echo "$response" | sed -n '/^\r$/,$p')
    echo "$response_body" >> "$OUTPUT_FILE"

    echo "-----" >> "$OUTPUT_FILE"

    echo "Processed note ID: $note_id"
done

echo "All response bodies have been saved to $OUTPUT_FILE"
