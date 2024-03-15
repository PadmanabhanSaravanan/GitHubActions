# In Github create a repository as github-actions

To create a repository named "github-actions" on GitHub and push your local project to it, you can follow these steps:

* First, create a new directory and navigate into it:

  ```git
  mkdir github-actions
  cd github-actions
  ```

* Initialize a new Git repository in this directory:

  ```git
  git init
  ```

* Add all files in the directory to the staging area:

  ```git
  git add .
  ```
  
* Check the status to verify that all files you want to commit are staged:
  
  ```git
  git status
  ```
  
* Commit the changes with a meaningful commit message:
  
  ```git
  git commit -m "Initial commit: todo project"
  ```
  
* To Configure username and Password
  
  ```git
  git config --global --edit
  #add these values for your profile
  [user]
        name = vijay
        email = vijay.nvb@gmail.com
  
  git commit --amend --reset-author
  ```
  
* Now, you need to add the remote repository URL. Since you've already created a repository named "github-actions" on GitHub, you can set the remote URL   accordingly:
  
  ```git
  git remote add origin https://github.com/vijaynvb/github-actions.git
  ```
  
* Rename the default branch from master to main:
  
  ```git
  git branch -M main
  ```
  
* Finally, push your changes to GitHub:
  
  ```git
  git push -u origin main
  ```