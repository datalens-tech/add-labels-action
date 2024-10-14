#!/usr/bin/env bash

set -euo pipefail

LABELS=${LABELS}
REPO=${REPO}
PR_NUMBER=${PR_NUMBER}

gh pr edit "$PR_NUMBER" \
    --repo "$REPO" \
    --add-label "$(echo "$LABELS" | tr '\n' ',' | sed 's/,$//')"
