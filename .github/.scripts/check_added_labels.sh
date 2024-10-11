GH_TOKEN=${GH_TOKEN}

CURRENT_PR_LABELS=$(gh pr view $PR_NUMBER --repo $REPO --json labels | jq -r '.labels[].name' | tr ' ' '\n' | sort | tr '\n' ' ')

echo $CURRENT_PR_LABELS
