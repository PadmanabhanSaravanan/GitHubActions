# Labeler

Automatically label new pull requests based on the paths of files being changed or the branch name.

## Setting Up GitHub Actions Labeler

As a LoopBack maintainer, you may find it beneficial to utilize GitHub Actions Labeler to streamline the labeling process for issues and pull requests (PRs). Labeler automatically adds labels to issues and PRs based on predefined rules, enhancing clarity and organization within your repository.

**Here's a step-by-step guide on how to set up GitHub Actions Labeler:**

**1. Navigate to the Actions Tab**

* Go to the GitHub repository you want to set up labeler for, then click on the "Actions" tab.

**2. Set Up Workflow**

* If you haven't configured any GitHub Actions before, you'll find the Labeler GitHub Actions towards the bottom of the page. Click on "Set up this workflow" to proceed.

**3. Create Workflow File**

* GitHub will generate a file named `labeler.yml` under `.github/workflows/`. Ensure that the file name remains as `labeler.yml`.

**4. Configure Label Rules**

Create a new file named `.github/labeler.yml` to define the rules for adding labels. In this file, specify the labels and corresponding file paths or patterns.

Example .github/labeler.yml:

```yaml
root:
- changed-files:
  - any-glob-to-any-file: '*'
```

This configuration will add the labels docs, example, and repository if changes are made to files under the respective directories.

**5. Verify Configuration**

Ensure that you've set up both files correctly:

```gh
.github/workflows/labeler.yml
.github/labeler.yml
```

**6. Test Labeling:**

* Create or modify files within the repository to trigger the labeling process.
* Verify that labels are automatically added according to the defined rules.