#!/bin/bash

TARGET_FILE="tock-tbf/src"

DAYS_SINCE_COMMIT=$(curl -s "url -s https://api.github.com/repos/ioqnq/KevinCookieCompany/commits?path=$TARGET_FILE&sha=REL1_36" \
  | jq -r ".[0].commit.author.date" \
  | xargs -I{} date -d {} +%s)

NOW=$(date +%s)
DIFF_DAYS=$(( (NOW - DAYS_SINCE_COMMIT) / 60 / 60 / 24 ))

exit $DIFF_DAYS
