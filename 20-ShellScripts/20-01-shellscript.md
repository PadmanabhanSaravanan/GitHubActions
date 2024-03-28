# **Shell Script**

**1. Create the Shell Script:**

- Create a shell script named `init.sh` in your repository. This script contains the commands you want to execute during the workflow.

  ```sh
  echo "message from shell script"
  ```

**2. Define the Workflow:**

- Create a YAML file named `20-01-Shell-Script.yml` in the `.github/workflows` directory of your repository.

  ```yaml
  name: 20-01-Shell-Script

  on:
    workflow_dispatch

  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - name: Checkout code
          uses: actions/checkout@v4

        - name: Make script executable and run
          run: |
            chmod +x ./init.sh
            ./init.sh
          shell: bash
  ```

- Copy and paste the provided workflow YAML into this file.

**3. Commit Changes:**

- Commit both the `init.sh` script and the workflow YAML file to your repository.

**4. Test the Workflow:**

- Navigate to the "Actions" tab in your GitHub repository.
- Manually trigger the workflow by clicking on the "Run workflow" button for the `20-01-Shell-Script` workflow.
- Monitor the workflow run and verify that the shell script `init.sh` is executed successfully.
- Check the logs to ensure that any commands specified in the shell script are executed as expected.

**5. Troubleshooting:**

- If the workflow fails, review the logs to identify any errors in the script or workflow configuration.
- Ensure that the script `init.sh` is present in the root directory of your repository and has the correct permissions set to execute (`chmod +x init.sh`).
- Debug any issues by adding debugging statements or inspecting the workflow environment during execution.