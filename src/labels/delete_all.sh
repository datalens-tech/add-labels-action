#!/usr/bin/env bash

gh api \
    --method DELETE \
    "repos/$REPO/issues/$PR_NUMBER/labels"
