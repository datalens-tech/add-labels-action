#!/usr/bin/env bash

set -euo pipefail

LABELS=${LABELS}
REPO=${REPO}
PR_NUMBER=${PR_NUMBER}

gh api \
    --method PUT \
    "repos/$REPO/issues/$PR_NUMBER/labels" \
    --input <(jq -n --compact-output --arg labels "$LABELS" '{"labels": $labels | split("\n") | map(select(. != ""))}')
