#!/bin/bash

TARGET_FILE="tock-tbf/src"

RESPONSE=$(curl -s "https://api.github.com/repos/ioqnq/KevinCookieCompany.com/commits?path=$TARGET_FILE&sha=main")

echo "📦 API raw response:"
echo "$RESPONSE"

# Extract commit date from the JSON response
COMMIT_DATE=$(echo "$RESPONSE" | jq -r ".[0].commit.author.date")

# Check if we got a valid commit date
if [[ "$COMMIT_DATE" == "null" || -z "$COMMIT_DATE" ]]; then
  echo "❌ Error: Could not extract a valid commit date. The path or branch may be wrong."
  exit 1
fi

# Convert commit date to epoch seconds
COMMIT_TIME=$(date -d "$COMMIT_DATE" +%s)
NOW=$(date +%s)

# Calculate age in days and minutes
DIFF_SECS=$((NOW - COMMIT_TIME))
DIFF_DAYS=$(( DIFF_SECS / 60 / 60 / 24 ))
DIFF_MINS=$(( DIFF_SECS / 60 ))

echo "⏱️ Age in days: $DIFF_DAYS"
echo "⏱️ Age in minutes: $DIFF_MINS"

exit $DIFF_DAYS
