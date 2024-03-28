# Stale

The GitHub Stale Action is a community-maintained GitHub Action designed to automate the process of identifying and closing stale issues and pull requests within a GitHub repository. This action streamlines repository maintenance by utilizing configurable parameters to determine which issues or pull requests qualify as "stale." It then applies labels and/or comments to notify the respective authors that their contributions are considered stale.

## Features

* **Automation:** Automates the identification and management of stale issues and pull requests.
* **Customizable Criteria:** Allows customization of parameters to define what qualifies as "stale."
* **Flexible Configuration:** Supports scheduling or triggering on specific events.
* **Custom Messages and Labels:** Provides options to customize notifications and labels for stale issues or pull requests.

## Usage

To use the GitHub Stale Action, follow these steps:

* **Install the Action:** Add the action to your repository's workflow configuration file (e.g., `.github/workflows/stale.yml`).
* **Configure Parameters:** Adjust the parameters according to your project's requirements. Parameters may include thresholds for staleness, labels, comments, and more.
* **Trigger the Action:** Schedule the action to run periodically or on specific events such as issue or pull request creation.
* **Customize Notifications:** Tailor the messages and labels used to notify authors about stale issues or pull requests, ensuring clarity and relevance.

```yaml
name: Mark stale issues and pull requests

on:
  schedule:
  - cron: '18 17 * * *'

jobs:
  stale:

    runs-on: ubuntu-latest
    permissions:
      issues: write
      pull-requests: write

    steps:
    - uses: actions/stale@v5
      with:
        repo-token: ${{ secrets.GITHUB_TOKEN }}
        stale-issue-message: 'Stale issue message'
        stale-pr-message: 'Stale pull request message'
        stale-issue-label: 'no-issue-activity'
        stale-pr-label: 'no-pr-activity'
```

This workflow is designed to mark stale issues and pull requests in your GitHub repository. Here's a breakdown of what each part of the workflow does:

* **Name**: The name of the workflow. In this case, it's "Mark stale issues and pull requests."
* **on**: This specifies when the workflow should run. Currently, it's set to run on a schedule using cron syntax. It will run every day at 5:18 PM UTC.
* **jobs**: Defines the tasks that the workflow will perform. In this case, there is one job named "stale."
* **runs-on**: Specifies the type of machine the job will run on. Here, it's set to run on the latest version of Ubuntu.
* **permissions**: Grants the necessary permissions to the job for interacting with issues and pull requests. It allows writing permissions for both issues and pull requests.
* **steps**: Specifies the actions that the job will take. In this case, it's using the actions/stale@v5 action to mark stale issues and pull requests.

  * **with**: Provides configuration options for the actions/stale@v5 action. It includes the GitHub token (secrets.GITHUB_TOKEN), messages to be posted on stale issues and pull requests, and labels to be applied to stale issues and pull requests.

    * `repo-token`: The GitHub token used for authentication.
    * `stale-issue-message`: The message to be posted on stale issues.
    * `stale-pr-message`: The message to be posted on stale pull requests.
    * `stale-issue-label`: The label to be applied to stale issues.
    * `stale-pr-label`: The label to be applied to stale pull requests.