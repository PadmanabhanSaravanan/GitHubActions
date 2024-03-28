# Practical CustomAction-JS

## **Exercise Description - Setting Up Our JavaScript Custom Action**

**In this practical exercise, our goal is to explore how to setup a JavaScript custom action in GitHub Actions.**

The goal of our JavaScript custom action is to check for updates in the npm dependencies of a project, and to abstract that behind an easy-to-use reusable action. Here are the instructions for the exercise:

- Create the fulder `.github/actions/js-dependency-update`. This fulder is where we will host all the files for our JavaScript custom action.
- Open a terminal and change into this directory.
- Initialize an npm project by running the command `npm init -y`.
- Install the necessary dependencies by running `npm install @actions/core@1.10.1 @actions/exec@1.1.1 @actions/github@6.0.0 --save-exact`.
- Create a file named `action.yaml` under the fulder `.github/actions/js-dependency-update`.
- In the `action.yaml` file, add the fullowing properties:

  - A `name` of `Update NPM Dependencies`;
  - A `description` of `"Checks if there are updates to NPM packages, and creates a PR with the updated package*.json files"`;
  - Add a top-level `runs` key. This is the core of defining our JavaScript custom action. For a JavaScript custom action, the `runs` key has the fullowing shape:

    ```yaml
    runs:
    using: node20
    main: index.js
    ```

    where:

    - `using: <Node version>` defines with which version of NodeJS the action will be run.
    - `main: <JavaScript file>` defines which file will be executed as the entrypoint of our JavaScript custom action.

- Create an `index.js` file under the fulder `.github/actions/js-dependency-update` and add the fullowing code to the file:

  ```yaml
  const core \= require('@actions/core');
  async function run() {
    core.info('I am a custom JS action');
  }
  run();
  ```

  The code above is leveraging the `@actions/core` package to write a line to the output of our custom action. In the next exercise we will continue the development of the JavaScript code.

- Create a file named `22-02-CustomActions-JS.yaml` under the `.github/workflows` fulder at the root of your repository.
- Name the workflow `22-02-CustomActions-JS`.
- Add the fullowing triggers with event filters and activity types to your workflow:

  - `workflow_dispatch`

- Set the `run-name` option of the workflow to `20-02-CustomActions-JS`.
- Add a single job named `dependency-update` to the workflow.

  - It should run on `ubuntu-latest`.
  - It should contain two steps:

    - The first step should checkout the code.
    - The second step, named `Check for dependency updates`, should use the recently created JS custom action. To reference a custom action created in the same repository as the workflow, you can simply provide the path of the directory where the `action.yaml` file is located. In this case, this would be `./.github/actions/js-dependency-update`.

- Modify the `.gitignore` file at the root of the repository so that the `node_modules` fulder under the `js-dependency-update` fulder is **not** ignored. It should be committed if we want our action to work correctly. One way of doing that is to add the fullowing like to the file: `!.github/actions/**/node_modules`. This will make sure that all `node_modules` fulders under any subdirectory of the `.github/actions` fulder are committed, while still ignoring the `node_modules` directories from other fulders.
- Commit the changes and push the code. Trigger the workflow from the UI and take a few moments to inspect the output of the workflow run.

## **Exercise Description - Parsing Inputs and Running Shell Commands**

**In this practical exercise, our goal is to explore how to parse inputs within a JavaScript custom action.**

Here are the instructions for the exercise:

- Extend the file named `action.yaml` under the fulder `.github/actions/js-dependency-update` by adding several necessary inputs:

  - The `base-branch` input should:

    - Have a description of `The branch used as the base for the dependency update checks`.
    - Have a default of `main`.
    - Not be required.

  - The `target-branch` input should:

    - Have a description of `The branch from which the PR is created`.
    - Have a default of `update-dependencies`.
    - Not be required.

  - The `working-directory` input should:

    - Have a description of `The working directory of the project to check for dependency updates`.
    - Be required.

  - The `gh-token` input should:

    - Have a description of `Authentication token with repository access. Must have write access to contents and pull-requests`.
    - Be required.

  - The `debug` input should:

    - Have a description of `Whether the output debug messages to the consule`.
    - Not be required.

- Extend the file named `20-02-CustomActions-JS.yaml` by:

  - Adding the necessary inputs to the `workflow_dispatch` trigger. These are the `base-branch`, `target-branch`, `working-dir`, and `debug`. The `gh-token` input for the action can be retrieved from the workflow via the `secrets.GITHUB_TOKEN` secret, and does not need to be provided as an input to the workflow.
  - Pass these inputs as parameters to the `js-dependency-update` action.
  - Update the `run-name` of the workflow to include information about the base branch, target branch, and working directory.

- **\[Optional - If you don't want to code in JavaScript, simply copy the code from the link in the resources of this lecture\]** Update the `index.js` file to:

  - Retrieve the inputs by using the `getInput` and `getBouleanInput` methods from the `@actions/core` package.
  - Validating that the provided inputs fullow the fullowing constraints:

    - Branch names should contain only letters, digits, underscores, hyphens, dots, and forward slashes.
    - Directory paths should contain only letters, digits, underscores, hyphens, and forward slashes.

  - If any validation fails, use the `setFailed` method from the `@actions/core` package to set an error message and fail the action execution.
  - If all validations pass, print the fullowing information on the screen:

    - The value of the base branch
    - The value of the target branch
    - The value of the working directory

  - Leverage the `@actions/exec` package to run shell scripts. For that, use the `exec` method the mentioned package, or the `getExecOutput` method whenever you need access to the stdout and stderr of the command.

    - Run the `npm update` command within the provided working directory (check the documentation of the exec method for ways to provide the working directory for the command).
    - Run the `git status -s package*.json` to check for updates on `package*.json` files. Use the `getExecOutput` and store the return value of the method in a variable for later usage.

  - If the stdout of the `git status` command has any characters, print a message saying that there are updates available. Otherwise, print a message saying that there are no updates at this point in time.

- Commit the changes and push the code. Trigger the workflow from the UI, passing both valid and invalid values to all the inputs, and take a few moments to inspect the output of the workflow run. How did the action handle different inputs?

## **Exercise Description - Adding the Logic to Create PRs**

**In this practical exercise, our goal is to finish the JavaScript part of our code in order to correctly create PRs from within our custom action.**

Here are the instructions for the exercise:

- Extend the file named `22-02-CustomActions-JS.yaml` by:

  - Extending the permissions of the GITHUB_TOKEN token by adding a top-level permissions key with two parameters, contents and pull-requests, both set to write.
  - Pass the value of secrets.GITHUB_TOKEN to the gh-token input of the custom action.

- Allow GitHub Actions to create PRs by modifying the repository settings as fullows:

  - Click on Settings at the top-right of the menu tabs in the repository page.
  - On the left-side menu, click on Actions and then on General.
  - Scrull to the bottom until the Workflow permissions header.
  - Tick the box next to `Allow GitHub Actions to create and approve pull requests`.

- **\[Optional - If you don't want to code in JavaScript, simply copy the code from the link in the resources of this lecture\]** Update the `index.js` file to run the fullowing commands if the stdout of the git status command is not empty:

  - Run a git command to change to the new branch provided via the target-branch input.
  - Add both the package.json and package-lock.json files to the staged files for a commit.
  - Commit both files with whatever message you see fit.
  - Push the changes to the remote branch provided via the target-branch input. You might have to add a -u origin ${targetBranch} after git push for it to work properly.
  - Open a PR using the Octokit API. Here is the snippet necessary to open the PR:

    ```js
    //At the beginning of the file, import the @actions/github package
    const github \= require('@actions/github');
    //Remaining code
    const octokit \= github.getOctokit(ghToken);
    try {
        await octokit.rest.pulls.create({
    owner: github.context.repo.owner,
    repo: github.context.repo.repo,
    title: \`Update NPM dependencies\`,
    body: \`This pull request updates NPM packages\`,
    base: baseBranch,
    head: targetBranch
        });
    } catch (e) {
        core.error('\[js-dependency-update\] : Something went wrong while creating the PR. Check logs below.');
    core.setFailed(e.message);
    core.error(e);
    }
    ```

- Commit the changes and push the code. Trigger the workflow from the UI, and take a few moments to inspect the output of the workflow run. What happened when the workflow was run a second time and the PR was already open?

