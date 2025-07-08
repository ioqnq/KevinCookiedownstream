#!/bin/bash

TARGET_FILE="tock-tbf/src"

DAYS_SINCE_COMMIT=$(curl -s "https://api.github.com/repos/ioqnq/KevinCookieCompany/commits?path=$TARGET_FILE&sha=main" \
  | jq -r ".[0].commit.author.date" \
  | xargs -I{} date -d {} +%s)

NOW=$(date +%s)

DIFF_DAYS=$(( (NOW - DAYS_SINCE_COMMIT) / 60 / 60 / 24 ))
DIFF_MINS=$(( (NOW - DAYS_SINCE_COMMIT) / 60 ))

echo "⏱️ Age in days: $DIFF_DAYS"
echo "⏱️ Age in minutes: $DIFF_MINS"

exit $DIFF_DAYS
