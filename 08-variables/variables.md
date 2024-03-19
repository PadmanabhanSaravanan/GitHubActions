# Working with Environment Variables in GitHub Actions

GitHub Actions allows you to work with environment variables to customize and parameterize your workflows. Environment variables are key-value pairs that can store secrets, configuration settings, or other data. This README provides examples of how to use environment variables effectively in GitHub Actions and outlines best practices for managing them securely.

## Using Environment Variables

You can use environment variables in GitHub Actions workflows to:

- Store secrets securely.
- Define parameters or configuration settings.
- Share information between workflow steps or jobs.

Here are some common use cases and examples of working with environment variables:

### Example 1: Define Workflow Parameters

Environment variables can be used to define parameters or configuration settings for your workflow. This makes it easy to customize workflow behavior:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    env:
      APP_ENV: ${{ vars.APP_ENV || "dev" }}
      DEBUG: ${{ vars.DEBUG || "false" }}
    steps:
      - name: Run Workflow with Parameters
        run: |
          # Use environment variables to control workflow behavior
          if [[ "$APP_ENV" == "production" && "$DEBUG" == "false" ]]; then
            echo "Running in production mode."
          else
            echo "Running in a different mode or with debugging enabled."
          fi
```

## Best Practices for Using Environment Variables

When working with environment variables in GitHub Actions, consider the following best practices:

**Avoid Hardcoding Secrets:** Do not hardcode secrets directly in your workflow files. Store secrets securely as encrypted secrets in your repository settings and reference them using the secrets context.

**Use Descriptive Names:** Choose descriptive and meaningful names for your environment variables to make your workflows more readable and maintainable.

**Keep Secrets Secret:** Ensure that sensitive information, such as API keys or passwords, is stored and accessed securely. Avoid printing secrets in logs or exposing them unintentionally.

**Scope Variables Appropriately:** Use environment variables with appropriate scope (workflow-level, job-level) based on your workflow's requirements. Keep in mind that job-level environment variables are accessible only within the specific job.

**Document Your Variables:** Include comments or documentation in your workflow files to explain the purpose and usage of environment variables, making it easier for collaborators to understand and contribute to your workflows.

**Review Access Permissions:** Ensure that only authorized users have access to view or edit secrets and environment variables in your repository settings.

## Exploring Organization, Repository, and Environment Variables in GitHub Actions

To effectively utilize organization, repository, and environment variables in GitHub Actions, it's crucial to understand how to set them up and access them within workflows. This guide walks through the process, using a GitHub organization for Udemy courses as an example.

**Organization Variables**

**1. Navigate to Organization Settings:**

* Go to your organization on GitHub.
* Under Settings, find the `"Secrets"` and `"Variables"` section.

**2. Create Organization Variables:**

* Click on `"Variables"`.
* Create new variables, e.g., `org_var` and `org_overridden_var`.
* Specify values and choose which repositories can access them.
* Note: Private repository access might be restricted based on your plan.

**Repository Variables**

**1. Access Repository Settings:**

* In the repository settings, find `"Secrets"` and `"Variables"` under Actions.

**2. Define Repository Variables:**

* Create variables specific to the repository, e.g., `repository_var`.
* Set values and configure access as needed.

**Environment Variables**

**1. Create Environments:**

* Navigate to `"Environments"` under repository settings.
* Define environments such as `"Staging"` and `"Prod"`.
* Add environment variables within each environment.

**Implementing Variables in Workflows**

**1. Accessing Variables in Workflows:**

* Use the `vars` context to access organization and repository variables.
* Environment variables are accessed using `vars` or `env` context depending on the scope.

**2. Using Default Values:**

* Define default values for variables to handle undefined cases.
* Utilize the Or operator (`||`) to provide fallback values when variables are not defined.

