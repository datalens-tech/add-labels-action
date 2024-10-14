#!/usr/bin/env bash

labels=$(
    gh api \
        --method GET \
        "repos/$REPO/issues/$PR_NUMBER/labels" | \
    jq -r '.[] | .name' | sort | tr '\n' ',' | sed 's/,$//'
)

echo "labels=$labels" >> $GITHUB_OUTPUT
