#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=src/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

CURRENT_LABELS="${CURRENT_LABELS:-""}"
PR_TITLE=${PR_TITLE}

CONFIG_JSON="https://raw.githubusercontent.com/datalens-tech/datalens/main/.github/workflows/scripts/changelog/changelog_config.json"

CONFIG_DATA=$(curl -s "$CONFIG_JSON")
TYPE_LABELS_PREFIX=$(echo "$CONFIG_DATA" | jq -r '.section_tags.prefix')
COMPONENT_LABELS_PREFIX=$(echo "$CONFIG_DATA" | jq -r '.component_tags.prefix')

if [[ -n $CURRENT_LABELS ]]; then
    CURRENT_LABELS=$(echo "$CURRENT_LABELS" | grep -E "$TYPE_LABELS_PREFIX|$COMPONENT_LABELS_PREFIX" | sort)
fi

LABELS_SECTION=${PR_TITLE%%:*}
COMMIT_TYPE=${LABELS_SECTION%%\(*}
COMPONENT_SECTION=${LABELS_SECTION#"$COMMIT_TYPE"}

LABELS_TO_ADD="$TYPE_LABELS_PREFIX$COMMIT_TYPE"

if [[ -n $COMPONENT_SECTION ]]; then
    COMMIT_COMPONENTS=$(echo "$CONFIG_DATA" | jq -r '.component_tags.tags[].id' | awk -v component_sec="$COMPONENT_SECTION" 'component_sec ~ $0' | sed "s#^#$COMPONENT_LABELS_PREFIX#")
    LABELS_TO_ADD+="\n$COMMIT_COMPONENTS"
fi

LABELS_TO_ADD=$(echo -e "$LABELS_TO_ADD" | sort)
LABELS_TO_DELETE=$(comm -13 <(echo "$LABELS_TO_ADD") <(echo "$CURRENT_LABELS"))

set_output "labels_to_add" "$LABELS_TO_ADD"
set_output "labels_to_delete" "$LABELS_TO_DELETE"
