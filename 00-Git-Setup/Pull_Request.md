# Pull Request

A pull request allows you to send the owner of a repository a request to pull in your new code changes. These changes could be anything from adding or improving a feature to perhaps fixing a bug.

**Step 1: Find the Repository**

First, find the repository you want to contribute to. We'll be using GitHub for this example. Be sure to review the README for general information about the repository and its contents.

**Step 2: Fork the Project**

Forking creates an exact copy and stores it under your GitHub account, so any changes made here will not affect the original code base.

**Step 3: Clone the Repository**

Clone your forked repository onto your local machine using the HTTPS link. Open your terminal or Git Bash and type:

```git
git clone <repository_https_link>
cd <repository_name>
```

**Step 4: Create a New Branch**

Create a new branch off of the main branch using the following command:

```git
git checkout -b <branch_name>
```

**Step 5: Make Changes**

Edit the file(s) in your preferred text editor. For example, using Vim:

```vim
vim hello.py
```

**Step 6: Stage and Commit Changes**

Stage your changes and commit them with a descriptive message:

```git
git add hello.py
git commit -m "Changed print statement to "Hello YouTube"
```

**Step 7: Push Changes to GitHub**

Push your changes to GitHub using:

```git
git push --set-upstream origin <branch_name>
```

**Step 8: Create a Pull Request**

Navigate to your GitHub repository. Go to the "Pull Request" tab and click "New Pull Request". Select the branches you want to merge from and into, then click "Create Pull Request".

**Step 9: Review and Merge**

As the repository owner, review the pull request. Leave comments if necessary. If everything looks good, approve the code review and merge the pull request.