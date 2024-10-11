GH_TOKEN=${GH_TOKEN}

CURRENT_PR_LABELS=$(gh pr view $PR_NUMBER --repo $REPO --json labels | jq -r '.labels[].name')
COMPONENTS_AND_TYPES_LABELS=""

for label in $CURRENT_PR_LABELS
do
    if [[ $label == *type/* || $label == *component/* ]]; then
        COMPONENTS_AND_TYPES_LABELS+="$label "
    fi
done

COMPONENTS_AND_TYPES_LABELS=$(echo $COMPONENTS_AND_TYPES_LABELS  | tr ' ' '\n' | sort | tr '\n' ' ')

echo $COMPONENTS_AND_TYPES_LABELS
