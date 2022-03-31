# MLFinalProject
Repository for BIOS:6720 final project

## Getting Started:

First start by making an account account on github: https://github.com if you have not done so already.

Next you will want to install git on your personal machine. I use git bash available here: https://git-scm.com/downloads. Bash is a unix shell which is a very similar OS to linux. The following instructions will assume you are using git bash. The basic principles of the following steps should be universal to whatever git interface software you choose to use.

## Basic Overview of git

In an overly simplified statement, git allows one to keep track of changes to files through various functions. Common functions used are saving a copy of the current files to memory and reverting files back to a previously saved state. When multiple people are collaborating on the same project, git also keeps track of who made certain changes and can be used to resolve conflicts in changes.

When using git there are 2 repositories (folders) to keep in mind. There is one on the internet, the **remote repository**, and one on your own personal computer the **local repository**. Generally, one makes changes to the important files on their personal computer. Once they are satisfied with these changes, they will make a save state of the changes on their personal computer and then upload this save state to the internet. We will explicitly go through these steps in an example workflow.

## Workflow:

Open the git bash app. You may first want to configure your username and email if you have not done so already using the following commands

```
git config --global user.name 'Your Name'
git config --global user.email 'your@email.com'
```
