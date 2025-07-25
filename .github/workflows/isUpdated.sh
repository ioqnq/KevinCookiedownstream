#!/bin/bash

TARGET_FILE="tock-tbf/src"

RESPONSE=$(curl -s "https://api.github.com/repos/ioqnq/KevinCookieCompany.com/commits?path=$TARGET_FILE&sha=main")

COMMIT_DATE=$(echo "$RESPONSE" | jq -r ".[0].commit.author.date")

COMMIT_TIME=$(date -d "$COMMIT_DATE" +%s)
NOW=$(date +%s)

DIFF_SECS=$((NOW - COMMIT_TIME))
DIFF_DAYS=$(( DIFF_SECS / 60 / 60 / 24 ))
DIFF_MINS=$(( DIFF_SECS / 60 ))

echo "Age in days: $DIFF_DAYS"
echo "Age in minutes: $DIFF_MINS"

if [ $DIFF_DAYS -eq 0 ]; then
  echo "0 days since last commit => notify"
  exit 0
else
  echo "Up to date."
  exit 1
fi
