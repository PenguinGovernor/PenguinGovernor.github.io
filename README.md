# penguingovernor.github.io

This is my single page personal website!
If you'd like to use this as your own you will need the following prerequisites:

- Go
- Automake
- Git Subtree

## Making it your own

The editable files include:

- Makefile (**ONLY RENAME THE CNAME VARIABLE**)
- All files in the `public` directory
- All files in the `templates` directory

## Building the project

To build the project run `make`.

To publish the project run `make publish GIT_COMMIT_MSG="your commit msg here`.

Ensure that `gh-pages` is the selected branch under GitHub pages settings, instructions [here](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).
