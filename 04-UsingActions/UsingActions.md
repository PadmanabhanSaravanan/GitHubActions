# Using Actions in Workflows

This GitHub Actions workflow demonstrates how to use actions within our GitHub Actions workflow to test a Java application.

## Workflow Details

- **Trigger**: This workflow is triggered manually from the UI.

- **Runner**: It runs on an Ubuntu environment provided by GitHub-hosted runners.

## Workflow Steps

1. **Checkout Code**: The workflow checks out the code from the repository using the `actions/checkout` action.

2. **Set up JDK:** This step sets up the Java Development Kit (JDK) using the actions/setup-java@v2 action. It specifies Java version 11 from AdoptOpenJDK.

3. **Build with Maven:** This step executes the `mvn clean install` command to build the Java project using Maven. It cleans the project, resolves dependencies, compiles source code, and packages the application.

4. **Run tests:** This step runs tests using the `mvn test` command. It executes the unit tests defined in the project to ensure the application behaves as expected.

```yaml
name: 04 - Using Actions

on: workflow_dispatch

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: 'adopt'
          java-version: '11'

      - name: Build with Maven
        run: mvn clean install -Dmaven.test.skip=true
        
      - name: Run tests
        run: mvn test

      - name: I will be skipped
        if: ${{ success() }}
        run: echo "I will print if previous steps succeed."
      - name: I will execute
        if: ${{ failure() }}
        run: echo "I will print if any previous step fails."
```