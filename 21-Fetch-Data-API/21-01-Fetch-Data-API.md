# **Fetch-Data-API**

**1. Define the Workflow:**

- Create a YAML file named `21-01-Fetch-Data-API.yml` in the `.github/workflows` directory of your repository.

  ```yaml
  name: 21-01-Fetch-Data-API
  on:
    workflow_dispatch: 
  
  jobs:
    fetch-todo:
      runs-on: ubuntu-latest
      steps:
        - name: Fetch Todo Data
          run: |
            # Use curl to fetch the data from the API endpoint
            # Integrate external systems within the Actions workflow
            # prepare API request with the required inputs like token payload etc
            todo_data=$(curl -s https://jsonplaceholder.typicode.com/todos/1)
            # Print the fetched data
            echo "Fetched Todo Data: $todo_data"
  ```

- Copy and paste the provided workflow YAML into this file.

**2. Commit Changes:**

- Commit the workflow YAML file to your repository.

**3. Test the Workflow:**

- Navigate to the "Actions" tab in your GitHub repository.
- Manually trigger the workflow by clicking on the "Run workflow" button for the `21-01-Fetch-Data-API` workflow.
- Monitor the workflow run and verify that the data is fetched from the API endpoint successfully.
- Check the logs to ensure that the fetched data is printed correctly.

**4. Troubleshooting:**

- If the workflow fails, review the logs to identify any errors in the script or workflow configuration.
- Ensure that the API endpoint (`https://jsonplaceholder.typicode.com/todos/1`) is accessible from the GitHub Actions environment.
- Debug any issues by adding debugging statements or inspecting the workflow environment during execution.