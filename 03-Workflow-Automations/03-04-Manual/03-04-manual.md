# Manual Workflow

A Manual Workflow in GitHub Actions is a type of workflow that is triggered explicitly by a user through the GitHub UI or API. Unlike automatic workflows triggered by events such as pull requests or pushes to the repository, manual workflows provide control over when the workflow executes, allowing users to initiate them when needed.

## Features

* **User Control:** Manual workflows allow users to trigger actions at their discretion, providing flexibility in workflow execution.
* **Explicit Activation:** Workflows are initiated explicitly through the GitHub UI or API, ensuring deliberate execution based on user input.
* **Custom Inputs:** Users can provide inputs when triggering the workflow, allowing for dynamic configuration based on specific requirements.
* **UI Integration:** Manual workflows are integrated into the GitHub UI, allowing users to initiate them conveniently through the repository interface.
* **Versatility:** Manual workflows can be used for various purposes, including deployment tasks, testing procedures, or any action that requires manual intervention.

## Usage

To use a Manual Workflow in your GitHub repository, follow these steps:

* **Create Workflow File:** Define a workflow YAML file (e.g., manual_workflow.yml) in the `.github/workflows` directory of your repository.

  ```yaml
  name: Manual workflow
  
  # Controls when the action will run. Workflow runs when manually triggered using the UI
  # or API.
  on:
    workflow_dispatch:
      # Inputs the workflow accepts.
      inputs:
        name:
          # Friendly description to be shown in the UI instead of 'name'
          description: 'Person to greet'
          # Default value if no value is explicitly provided
          default: 'World'
          # Input has to be provided for the workflow to run
          required: true
          # The data type of the input
          type: string
  
  # A workflow run is made up of one or more jobs that can run sequentially or in parallel
  jobs:
    # This workflow contains a single job called "greet"
    greet:
      # The type of runner that the job will run on
      runs-on: ubuntu-latest
  
      # Steps represent a sequence of tasks that will be executed as part of the job
      steps:
      # Runs a single command using the runners shell
      - name: Send greeting
        run: echo "Hello ${{ inputs.name }}"
  ```

* **Define Workflow**: Specify the workflow details, including the name and triggers.

  ```yaml
  name: Manual Workflow
  
  on:
    workflow_dispatch:
      inputs:
        name:
          description: 'Person to greet'
          default: 'World'
          required: true
          type: string
  ```

* **Define Jobs:** Define the jobs that comprise the workflow. In a manual workflow, jobs are configured to execute specific tasks or actions.

  ```yaml
  jobs:
    greet:
      runs-on: ubuntu-latest
      steps:
        - name: Send greeting
          run: echo "Hello ${{ inputs.name }}"
  ```

* **Customize Workflow:** Customize the workflow as needed, specifying additional jobs, steps, or configurations based on your requirements.

* **Commit and Push:** Save the changes to the workflow file and commit them to your repository. The workflow is now ready to be triggered manually through the GitHub UI or API.