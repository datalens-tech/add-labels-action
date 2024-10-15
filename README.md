# add-labels-action

[![CI](https://github.com/datalens-tech/add-labels-action/workflows/Check%20PR/badge.svg)](https://github.com/datalens-tech/add-labels-action/actions?query=workflow%3A%22%22Check+PR%22%22)
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Add%20Labels%20Action-blue.svg)](https://github.com/marketplace/actions/add-labels-action)

Labeler for pull_requests based on commitlint. Adds `type/...` and `component/...` labels by PR title

## How it works:

1. The action loads [config.json](https://raw.githubusercontent.com/datalens-tech/datalens/main/.github/workflows/scripts/changelog/changelog_config.json) and gets info about type and component labels
2. After gets labels section from PR title and compares with available labels from config.json
3. Adds comparable labels and also removes redundant labels from PR

## Usage

### Example

```yaml
on:
  pull_request:
    types: [opened, reopened, edited, synchronize]

jobs:
  labeler:
    name: Add labels
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write

    steps:
      - uses: datalens-tech/add-labels-action@v1
```

### Action Inputs

| Name               | Description              | Default                                 |
| ------------------ | ------------------------ | --------------------------------------- |
| `github_owner`     | Owner of the repository. | ${{ github.repository_owner }}          |
| `github_repo`      | Repository name          | ${{ github.event.repository.name }}     |
| `github_pr_number` | GitHub PR number.        | ${{ github.event.pull_request.number }} |
| `github_pr_title`  | GitHub PR title.         | ${{ github.event.pull_request.title }}  |
| `github_token`     | GitHub token.            | ${{ github.token }}                     |

### Action Outputs

None

## Development

### Global dependencies

- nvm
- node

### Taskfile commands

For all commands see [Taskfile](Taskfile.yaml) or `task --list-all`.

## License

[MIT](LICENSE)
