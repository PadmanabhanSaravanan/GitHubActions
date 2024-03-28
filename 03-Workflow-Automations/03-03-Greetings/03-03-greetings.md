# Greeting

The Greeting Action is a GitHub Action designed to welcome users when they interact with a repository for the first time by creating an issue or a pull request. It facilitates fostering a welcoming and inclusive environment within open-source projects by providing personalized greetings to new contributors.

## Features

* **Automated Welcoming**: Automatically greets users when they make their first contribution to the repository, whether by creating an issue or a pull request.
* **Customizable Messages**: Allows customization of the greeting messages, enabling maintainers to tailor the welcome message to suit the project's tone and guidelines.
* **Enhanced Engagement**: Encourages engagement and participation from new contributors by acknowledging their initial interactions with the project.
* **User-Friendly**: Provides a seamless onboarding experience for new contributors, helping them feel valued and supported within the community.
* **Flexible Configuration**: Offers flexibility in configuration, allowing repository maintainers to adjust the greeting messages according to their project's requirements.

## Usage

To utilize the Greeting Action in your GitHub repository, follow these steps:

* **Create Workflow File:** Create a workflow YAML file (e.g., greetings.yml) in the `.github/workflows` directory of your repository.

  ```yaml
  name: Greetings
  
  on: [pull_request_target, issues]
  
  jobs:
    greeting:
      runs-on: ubuntu-latest
      permissions:
        issues: write
        pull-requests: write
      steps:
      - uses: actions/first-interaction@v1
        with:
          repo-token: ${{ secrets.GITHUB_TOKEN }}
          issue-message: "Message that will be displayed on users' first issue"
          pr-message: "Message that will be displayed on users' first pull request"
  ```


* **Define Workflow**: Specify the workflow details, including triggering events and job configurations.

  ```yaml
  name: Greetings
  
  on: [pull_request_target, issues]
  ```

* **Define Job:** Define the job named greeting that will execute the greeting action.

  ```yaml
  jobs:
    greeting:
      runs-on: ubuntu-latest
      permissions:
        issues: write
        pull-requests: write
  ```

* **Define Steps:** Inside the greeting job, configure the steps to execute the Greeting Action.

  ```yaml
  steps:
    - uses: actions/first-interaction@v1
      with:
        repo-token: ${{ secrets.GITHUB_TOKEN }}
        issue-message: "Message that will be displayed on users' first issue"
        pr-message: "Message that will be displayed on users' first pull request"
  ```
     
* **Customize Messages:** Adjust the issue-message and pr-message parameters to provide personalized messages welcoming new contributors.

* **Commit and Push:** Save the changes to the workflow file and commit them to your repository. Then, push the changes to trigger the workflow.