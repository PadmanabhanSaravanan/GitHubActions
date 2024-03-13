# Using Actions in Workflows

This GitHub Actions workflow demonstrates how to use actions within our GitHub Actions workflow to test a Java application.

## Workflow Details

- **Trigger**: This workflow is triggered manually from the UI.

- **Runner**: It runs on an Ubuntu environment provided by GitHub-hosted runners.

## Workflow Steps

1. **Checkout Code**: The workflow checks out the code from the repository using the `actions/checkout` action.

2. **Build with Maven:** This step executes the `mvn clean install` command to build the Java project using Maven. It cleans the project, resolves dependencies, compiles source code, and packages the application.

3. **Run tests:** This step runs tests using the `mvn test` command. It executes the unit tests defined in the project to ensure the application behaves as expected.