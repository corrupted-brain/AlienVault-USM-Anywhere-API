#!/bin/bash

# Set your API endpoint and authorization token
BASE_API_ENDPOINT="https://example.alienvault.cloud/api/2.0/investigations"
AUTH_TOKEN="Bearer XXXXXXXXXXXXXXXXXX"

# Create a file to store the responses
OUTPUT_FILE="events.txt"

# Iterate through note IDs from 1 to 360
for event_id in {0..360}; do
    # Construct the API endpoint with the current note_id
    API_ENDPOINT="$BASE_API_ENDPOINT/$event_id/events"

    # Make the API request and store the response in a variable
    response=$(curl -i -s -k -X GET \
        -H "Host: example.alienvault.cloud" -H "Authorization: $AUTH_TOKEN" -H "User-Agent: PostmanRuntime/7.32.3" -H "Accept: */*" -H "Postman-Token: 8c810eb3-be73-40a2-b70b-91efd2d09ffa" -H "Accept-Encoding: gzip, deflate" -H "Connection: keep-alive" \
        -b "samesite=lax; JSESSIONID=XXXXXXXXXXXXXXXXXX" \
        "$API_ENDPOINT")

    # Extract the response body using awk and add a separator
    response_body=$(echo "$response" | sed -n '/^\r$/,$p')
    echo "$response_body" >> "$OUTPUT_FILE"

    echo "--------------------------- Event details for Investigation: $event_id ---------------------------" >> "$OUTPUT_FILE"

    echo "Processed note ID: $event_id"
done

echo "All response bodies have been saved to $OUTPUT_FILE"
