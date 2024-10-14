#!/usr/bin/env bash

CONFIG_DATA=$(curl -s "https://raw.githubusercontent.com/datalens-tech/datalens/main/.github/workflows/scripts/changelog/changelog_config.json")
TYPE_LABELS_PREFIX=$(echo "$CONFIG_DATA" | jq -r '.section_tags.prefix')
COMPONENT_LABELS_PREFIX=$(echo "$CONFIG_DATA" | jq -r '.component_tags.prefix')

PR_TITLE=${PR_TITLE}
GH_TOKEN=${GH_TOKEN}
REPO=${REPO}
PR_NUMBER=${PR_NUMBER}
CURRENT_LABELS=${CURRENT_LABELS}

CURRENT_LABELS=$(echo "${CURRENT_LABELS}" | tr ',' '\n' | grep -E "$TYPE_LABELS_PREFIX|$COMPONENT_LABELS_PREFIX" | sort)

LABELS_SECTION=${PR_TITLE%%:*}
COMMIT_TYPE=${LABELS_SECTION%%\(*}
COMPONENT_SECTION=${LABELS_SECTION#"$COMMIT_TYPE"}

LABELS_TO_ADD="$TYPE_LABELS_PREFIX$COMMIT_TYPE"

if [[ -n $COMPONENT_SECTION ]]; then
    COMMIT_COMPONENTS=$(echo "$CONFIG_DATA" | jq -r '.component_tags.tags[].id' | awk -v component_sec="$COMPONENT_SECTION" 'component_sec ~ $0' | sed "s#^#$COMPONENT_LABELS_PREFIX#")
    LABELS_TO_ADD+="\n$COMMIT_COMPONENTS"
fi

LABELS_TO_ADD=$(echo -e "$LABELS_TO_ADD" | sort)
LABELS_TO_DELETE=$(comm -13 <(echo "$LABELS_TO_ADD") <(echo "$CURRENT_LABELS") | tr "\n" "," | sed 's/,$//')

echo "labels_to_add=$(echo -e "$LABELS_TO_ADD" | tr '\n' ',' | sed 's/,$//')" >> $GITHUB_OUTPUT
echo "labels_to_delete=$LABELS_TO_DELETE" >> $GITHUB_OUTPUT
