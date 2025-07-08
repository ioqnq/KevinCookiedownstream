#!/bin/bash

TARGET_FILE="tock-tbf/src"

RESPONSE=$(curl -s "https://api.github.com/repos/ioqnq/KevinCookieCompany/commits?path=$TARGET_FILE&sha=main")

echo "📦 API raw response:"
echo "$RESPONSE"

COMMIT_DATE=$(echo "$RESPONSE" | jq -r ".[0].commit.author.date")

if [[ "$COMMIT_DATE" == "null" || -z "$COMMIT_DATE" ]]; then
  echo "❌ Error: Could not extract a valid commit date. The path or branch may be wrong."
  exit 1
fi


NOW=$(date +%s)

DIFF_DAYS=$(( (NOW - DAYS_SINCE_COMMIT) / 60 / 60 / 24 ))
DIFF_MINS=$(( (NOW - DAYS_SINCE_COMMIT) / 60 ))

echo "⏱️ Age in days: $DIFF_DAYS"
echo "⏱️ Age in minutes: $DIFF_MINS"

exit $DIFF_DAYS
