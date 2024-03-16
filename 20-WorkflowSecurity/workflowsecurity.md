# Workflow Security

Workflow security involves safeguarding CI/CD processes and data through access control, secrets management, code review, vulnerability scanning, and proactive monitoring to mitigate risks and ensure integrity.

* unsafe-pr: This job directly reads the PR title from the event payload and checks if it starts with `"feat"` using a bash script.
* safer-pr: This job sets the PR title as an environment variable and then checks if it starts with `"feat"` using a bash script. This approach is slightly safer as it avoids directly referencing the event payload in the script.
* js-safer-pr: This job uses a custom action located at `./.github/actions/security-safe-input` to perform the check. It also checks if the PR title starts with "feat".

```yaml
name: 20 - Workflow Security

on:
  pull_request:

jobs:
  unsafe-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Check PR title
        run: |
          title=${{ github.event.pull_request.title }}
          if [[ $title =~ ^feat ]]; then
          echo "PR is a feature"
          exit 0
          else
          echo "PR is not a feature"
          exit 1
          fi
  safer-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Check PR title
        env:
          TITLE: ${{ github.event.pull_request.title }}
        run: |
          if [[ $TITLE =~ ^feat ]]; then
          echo "PR is a feature"
          exit 0
          else
          echo "PR is not a feature"
          exit 1
          fi
  js-safer-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Check PR title
        uses: ./.github/actions/security-safe-input
        with:
          pr-title: ${{ github.event.pull_request.title }}
```

**let's break down the code**

```yaml
name: 20 - Workflow Security

on:
  pull_request:
```

* This YAML header specifies the name of the workflow and defines the event that triggers it, in this case, pull_request.

```yaml
jobs:
  unsafe-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
```

* The workflow defines a job named unsafe-pr that runs on an Ubuntu environment. The actions/checkout action is used to clone the repository so that subsequent steps can access its contents.

```yaml
      - name: Check PR title
        run: |
          title=${{ github.event.pull_request.title }}
          if [[ $title =~ ^feat ]]; then
          echo "PR is a feature"
          exit 0
          else
          echo "PR is not a feature"
          exit 1
          fi
```

* This step checks the title of the pull request. It assigns the pull request title to a variable title. Then, it uses a bash script to check if the title starts with "feat". If it does, it prints "PR is a feature" and exits with code 0 (indicating success). Otherwise, it prints "PR is not a feature" and exits with code 1 (indicating failure).

```yaml
  safer-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Check PR title
        env:
          TITLE: ${{ github.event.pull_request.title }}
        run: |
          if [[ $TITLE =~ ^feat ]]; then
          echo "PR is a feature"
          exit 0
          else
          echo "PR is not a feature"
          exit 1
          fi
```

This job safer-pr is similar to unsafe-pr, but instead of directly using the pull request title in the script, it sets the title as an environment variable TITLE. The bash script then checks this environment variable to determine if the pull request is a feature or not.

```yaml
  js-safer-pr:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Check PR title
        uses: ./.github/actions/security-safe-input
        with:
          pr-title: ${{ github.event.pull_request.title }}, Explain the code for Documentation and start with what is workflow security

```

* This job js-safer-pr is again similar to the previous ones but instead of directly running a bash script, it uses a custom action located at `./.github/actions/security-safe-input`. It passes the pull request title to this action using the with keyword.