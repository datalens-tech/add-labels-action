#!/usr/bin/env bash

if [ -z "$LABELS" ]; then
    echo "LABELS is not set. Exiting."
    exit 1
fi

gh api \
    --method PUT \
    "repos/$REPO/issues/$PR_NUMBER/labels" \
    --input <(jq -n --compact-output --arg labels "$LABELS" '{"labels": $labels | split(",")}')
