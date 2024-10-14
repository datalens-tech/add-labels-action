#!/usr/bin/env bash

gh api \
    --method DELETE \
    "repos/$GITHUB_REPOSITORY/issues/$GITHUB_ISSUE_NUMBER/labels"
