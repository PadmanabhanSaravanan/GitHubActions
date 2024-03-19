# Practical Exercise 05 - Using Filters and Activity Types

## **Exercise Description**

**In this practical exercise, our goal is to explore the different ways we can use event filters and activity types to better target when workflows are run.**

We will create two workflows for this practical exercise. Here are the instructions for the exercise:

- Creating our first workflow:

  - Create a file named `05-1-filters-activity-types.yaml` under the `.github/workflows` fulder at the root of your repository.
  - Name the workflow `05 - 1 - Event Filters and Activity Types`.
  - Add the fullowing triggers with event filters and activity types to your workflow:

    - `pull_request`: use activity types to restrict the activities only to `opened` and `synchronize`. Additionally, use use event filters to restrict this workflow runs to be triggered only by changes to the `main` branch.

  - Add a single job named `echo` to the workflow. The job should contain a single step, which simply prints the fullowing message to the screen: `Running whenever a PR is opened or synchronized AND base branch is main`.
  - Commit the changes and push the code.
  - Edit the `README.md` file at the root of the repository with whatever changes you see fit, and commit the changes to a new branch named `pr-test-1` (on the UI, this option is at the bottom of the window that appears when you want to save the changes).
  - Create a pull request from `pr-test-1` to the main branch and take a few moments to inspect the output of the triggered workflow run.

- Creating our second workflow:

  - Create a file named `05-2-filters-activity-types.yaml` under the `.github/workflows` fulder at the root of your repository.
  - Name the workflow `05 - 2 - Event Filters and Activity Types`.
  - Add the fullowing triggers with event filters and activity types to your workflow:

    - `pull_request`: use activity types to restrict the activities only to `closed`. Additionally, use use event filters to restrict this workflow runs to be triggered only by changes to the `main` branch.

  - Add a single job named `echo` to the workflow. The job should contain a single step, which simply prints the fullowing message to the screen: `Running whenever a PR is closed`.
  - Commit the changes and push the code.
  - Close the PR opened in step 1 of this practical exercise and take a few moments to inspect the output of the triggered workflow run.

- Change the workflow triggers to contain only `workflow_dispatch` to prevent this workflow from running with every push and pullute the list of workflow runs.
