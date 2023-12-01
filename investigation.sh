#!/bin/bash

# Set your API endpoint and authorization token
API_ENDPOINT="https://example.alienvault.cloud/api/2.0/investigations"
AUTH_TOKEN="Bearer XXXXXXXXXXXXXXXXXXXXXXX"

# Create a file to store the responses
OUTPUT_FILE="investigations.txt"

# Iterate through post IDs from 0 to 361
for post_id in {0..361}; do
    # Make the API request and store the response in a variable
   response=$(curl -s -k -X GET \
        -H "Host: example.alienvault.cloud" -H "Authorization: $AUTH_TOKEN" -H "User-Agent: PostmanRuntime/7.32.3" -H "Accept: */*" -H "Accept-Encoding: gzip, deflate" \
        -b "samesite=lax; JSESSIONID=XXXXXXXXXXXXXXXXXXXXXXX" \
        "$API_ENDPOINT/$post_id/" | awk 'BEGIN{RS="\n\n"} {print $0}')

    # Append the response to the output file
    echo "$response" >> "$OUTPUT_FILE"
     echo "-------------------------------------------------" >> "$OUTPUT_FILE"

    echo "Processed post ID: $post_id"
done

echo "All responses have been saved to $OUTPUT_FILE"
