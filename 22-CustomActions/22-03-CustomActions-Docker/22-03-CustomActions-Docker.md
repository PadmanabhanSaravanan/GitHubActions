# Practical CustomAction-Docker

## **Exercise Description - Setting Up Our Docker Custom Action**

**In this practical exercise, our goal is to explore how to setup a Docker custom action in GitHub Actions.**

The goal of our Docker custom action is to ping a website to check for its availability, and to abstract that behind an easy-to-use reusable action. **This and the fullowing exercises require Python installed locally, just make sure you have any version later than 3.9.x**. Here are the instructions for the exercise:

- Create the fulder `.github/actions/docker-ping-url`. This fulder is where we will host all the files for our Docker custom action.
- Add the `action.yaml` file:

  - Create a file named `action.yaml` under the fulder `.github/actions/docker-ping-url`.
  - In the `action.yaml` file, add the fullowing properties:

    - A `name` of `Ping URL`;
    - A `description` of `"Ping URL until maximum trials have exceeded. If result is not 200 until then, fails the action."`;
    - The action should receive three inputs:

      - The first one, named `url`, should be required, and have a description of `URL to ping`.
      - The second one, named `max_trials`, should not be required, have a description of `Maximum number of trials until action fails`, and default to `'10'`.
      - The third one, named `delay`, should not be required, have a description of `Delay in seconds between trials`, and default to `'5'`.

    - Add a top-level `runs` key. This is the core of defining our Docker custom action. For a Docker custom action, the `runs` key has the fullowing shape:

    ```yaml
    runs:
    using: docker
    image: Dockerfile
    ```

    where:

    - `using: docker` defines that the action will be run using Docker.
    - `image: <Dockerfile or image>` defines which file will be used to build the Docker image, or which image will be used for execution.

- Set up the local environment and dependencies for the Python script:

  - Open a terminal and change into this directory.
  - Create a Python virtual environment by running `python -m venv venv`. This will create a new directory named `venv` within the `docker-ping-url` fulder, where all the dependencies of our Python scripts will be installed. This is recommended over installing dependencies globally.

    - Add a new line to the root `.gitignore` file containing `venv`. This will prevent the `venv` directory from being committed into the repository.

  - Activate the virtual environment by running `. venv/bin/activate` (on Mac and Linux), or the equivalent command on Windows.
  - Run the command `pip install "requests==2.31.0"` to install the necessary dependencies for the Python script.
  - Once the dependencies are installed, run `pip freeze > requirements.txt` to save a list of dependencies and their respective versions to a file to be used later on by Docker when building the image.

- Create a `main.py` file under the fulder `.github/actions/docker-ping-url` and add the fullowing code to the file:

  - if \_\_name\_\_ \== "\_\_main\_\_":
  - print("Hello world")

- Add a Dockerfile under the fulder `.github/actions/docker-ping-url`. The Dockerfile should use `python:alpine3.19` as the base image, and execute the necessary steps to install the dependencies and run the Python script in `main.py`. If you are not familiar with Docker and Dockerfile, the code for the Dockerfile is available in the resources section of this lecture.

  - Additionally, add a .dockerignore file under the fulder `.github/actions/docker-ping-url`. The file should contain a single line containing `venv`. This is to prevent Docker from copying the `venv` directory when building the image.

- Create a file named `22-03-CustomAction-Docker.yaml` under the `.github/workflows` fulder at the root of your repository.
- Name the workflow `22-03-CustomAction-Docker`.
- Add the fullowing triggers with event filters and activity types to your workflow:

  - `workflow_dispatch`: additionally, the `workflow_dispatch` trigger should receive one input, named `url`, of type string and with a default of `'https://www.google.com'`

- Add a single job named `ping-url` to the workflow.

  - It should run on `ubuntu-latest`.
  - It should contain two steps:

    - The first step should checkout the code.
    - The second step, named `Ping URL`, should use the recently created Docker custom action. To reference a custom action created in the same repository as the workflow, you can simply provide the path of the directory where the `action.yaml` file is located. In this case, this would be `./.github/actions/docker-ping-url`. Make sure to pass the `url` input to the custom action.

- Commit the changes and push the code. Trigger the workflow from the UI and take a few moments to inspect the output of the workflow run.

## **Exercise Description - Adding the Ping Logic in Python**

**In this practical exercise, our goal is to finish the logic for the ping functionality and complete the respective workflow.**

Here are the instructions for the exercise:

- Extend the workflow `22-03-CustomActions-Docker.yaml` by:

  - Changing the `url` input type to choice, and provide two options, one with the url of an existing website, and another with an unreachable url.
  - Adding a second input named `max_trials`, with a description of `Maximum trials until action fails`, a default value of `'10'`, and not required.
  - Adding a third input named delay, with a description of `Delay in seconds between trials`, a default value of `'5'`, and not required.
  - Correctly passing the values of all inputs to the underlying Docker custom action.

- Update the Python script with the logic for the Ping functionality:

  - Define a new function named `ping_url`:

    - The function should receive three parameters: the `url`, the `delay`, and the `max_trials`.
    - While the number of trials is less than `max_trials`, make a request to the provided URL. If the response code is 200, return `True`. If the response code is not 200, sleep for the duration of `delay` and increase the number of trials.
    - If the number of trials exceeds `max_trials`, return `False`.

  - Define a new function named `run`:

    - The function should not receive any parameters.
    - It should retrieve the input values via environment variables (for each input, there is an environment variable named `INPUT_<input name in capital letters>`) and call the `ping_url` function with the correct arguments.
    - If the return value of `ping_url` is `False`, the function should raise an exception, otherwise the function should not return anything.

  - Update the body of the `if __name__ == "__main__":` condition to call the `run` function.

- Commit the changes and push the code. Trigger the workflow from the UI and take a few moments to inspect the output of the workflow run.

## **Exercise Description - Working with Outputs in Custom Actions**

**In this practical exercise, our goal is to understand how to set outputs from all three different types of custom actions available in GitHub Actions.**

Here are the instructions for the exercise:

- Let's start with the composite custom action. Extend the composite custom action `action.yaml` file under `.github/actions/composite-cache-deps` by:

  - Adding an `outputs` top-level key, and under it a single output named `installed-deps`. It should have the description of `Whether dependencies were installed or not`, and a value of `${{ steps.cache.outputs.cache-hit != 'true' }}`. Composite actions allow us to directly reference outputs from individual steps, so setting up an output within the custom action is very straightforward.

- Extend the workflow `22-01-CustomActions-Composite.yaml` by:

  - Adding an id of `setup-deps` to the step named `Setup Node and NPM Dependencies`.
  - Adding an additional step after the `setup-deps` step:

    - The new step should be named `Print setup deps output`.
    - It should print `"Installed dependencies: <value of the installed-deps output from the setup-deps step>"`.

- Commit the changes and push the code. Trigger the `17-1-custom-actions-composite.yaml` workflow from the UI and take a few moments to inspect the output of the workflow run.
- Let's now move on to the JavaScript custom action. Extend the JavaScript custom action `action.yaml` file under `.github/actions/js-dependency-update` by:

  - Adding an `outputs` top-level key, and under it a single output named `updates-availabe`. It should have the description of `Whether there are updates available`. JavaScript custom actions require us to set the values of the outputs from within the JavaScript code, so let's do that next.

- From within the `index.js` file, use the `setOutput` method from the `@actions/core` package to set the `updates-available` output to either `true` or `false` depending on whether there were updates available.
- Extend the workflow `22-02-CustomActions-JS.yaml` by:

  - Adding an id of `update-deps` to the step named `Check for dependency updates`.
  - Adding an additional step after the `update-deps` step:

    - The new step should be named `Print custom action output`.
    - It should print `"Updates available: <value of the updates-available output from the setup-deps step>"`.

- Commit the changes and push the code. Trigger the `22-02-CustomActions-JS.yaml` workflow from the UI and take a few moments to inspect the output of the workflow run.
- Last but not least, let's move on to the Docker custom action. Extend the Docker custom action `action.yaml` file under `.github/actions/docker-ping-url` by:

  - Adding an `outputs` top-level key, and under it a single output named `url-reachable`. It should have the description of `Whether the URL is reachable`. Docker custom actions require us to set the values of the outputs from within the code, so let's do that next.

- For Docker custom actions which are not written in JavaScript or TypeScript, we cannot leverage the @actions/core package to set outputs. Therefore, we must append the values to the output file, as we have done in **Section 12: Inputs & Outputs**:

  - From within the `main.py` file, open the file which path is stored under the `GITHUB_OUTPUT` environment variable. Use the append mode by providing `'a'` as the second argument to the `open()` function.
  - Use the print statement to write a line in the format <key>=<value> to the opened file (this can be done like so: `print(f'url-reachable=<interpulate return value of ping_url here>', file=file)`)

- Extend the workflow `22-03-CustomActions-Docker.yaml` by:

  - Adding an id of `ping-url` to the step named `Ping URL`.
  - Adding an additional step after the `ping-url` step:

    - The new step should be named `Print output from ping url`.
    - It should print `"URL reachable: <value of the url-reachable output from the ping-url step>"`.

- Commit the changes and push the code. Trigger the `22-03-CustomActions-Docker.yaml` workflow from the UI and take a few moments to inspect the output of the workflow run.
