# MLFinalProject
Repository for BIOS:6720 final project

## Getting Started:

First start by making an account account on github: https://github.com if you have not done so already.

Next you will want to install git on your personal machine. I use git bash available here: https://git-scm.com/downloads. Bash is a unix shell which is a very similar OS to linux. The following instructions will assume you are using git bash. The basic principles of the following steps should be universal to whatever git interface software you choose to use.

## Basic Overview of git

In an overly simplified statement, git allows one to keep track of changes to files through various functions. Common functions used are saving a copy of the current files to memory and reverting files back to a previously saved state. When multiple people are collaborating on the same project, git also keeps track of who made certain changes and can be used to resolve conflicts in changes.

When using git there are 2 repositories (folders) to keep in mind. There is one on the internet, the **remote repository**, and one on your own personal computer the **local repository**. Generally, one makes changes to the important files on their personal computer. Once they are satisfied with these changes, they will make a save state of the changes on their personal computer and then upload this save state to the internet. We will explicitly go through these steps in an example workflow.

## Basic Unix commands for file navigation

Since git bash is a unix shell, you will unfortunately need to learn a few unix commands. Here are a few basic commands to get started:

```
pwd
ls
cd file_path_to_go_to
mkdir new_directory_path
```

**pwd** stands for 'print working directory'. This will print the directory you are currently in.

**ls** is used to display all the current files/directories in your current working directory.

**cd** stands for 'change directory'. This will change your working directory to the directory you specify. The directory must exist for you to 'cd' to it.

**mkdir** stands for 'make directory' and will create a new directory at the path specified. Try 'mkdir NewFile' to get a feel of how it workds.

Relative paths:

'./' indicates the current working directory. It is generally assumed when you don't specify a full path.

'../' indicates the working directory 1 level above your current directory. Use  cd .. or cd ../ to move up one level.

## Directory set up:

Open the git bash app. You may first want to configure your username and email if you have not done so already using the following commands

```
git config --global user.name 'Your Name'
git config --global user.email 'your@email.com'
```

Next we will want to make a copy of the remote repository onto your personal machine. First use cd to get to the place you want the working directory to be located. I give an example directory below

```
cd C:users/josht/Documents/projects
```

New we will clone the **remote directory**

```
git clone 
```
