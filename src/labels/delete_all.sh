#!/usr/bin/env bash

set -euo pipefail

REPO=${REPO}
PR_NUMBER=${PR_NUMBER}

gh api \
    --method DELETE \
    "repos/$REPO/issues/$PR_NUMBER/labels"
