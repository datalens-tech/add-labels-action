#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=src/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/../common.sh"

REPO=${REPO}
PR_NUMBER=${PR_NUMBER}

labels=$(
    gh api \
        --method GET \
        "repos/$REPO/issues/$PR_NUMBER/labels" | \
    jq -r '.[] | .name' | sort | sed 's/\n$//'
)

set_output labels "$labels"
