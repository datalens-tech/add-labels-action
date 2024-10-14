#!/usr/bin/env bash

labels=$(
    gh api \
        --method GET \
        "repos/$GITHUB_REPOSITORY/issues/$GITHUB_ISSUE_NUMBER/labels" | \
    jq -r '.[] | .name' | tr '\n' ',' | sed 's/,$//'
)

echo "labels=$labels" >> $GITHUB_OUTPUT
