#!/bin/bash

# ===========================================================
# SCRIPT INTRODUCTION
# ===========================================================
# This script automates the process of managing a Git repository,
# ensuring that the repository URL is properly set and allowing
# for easy pushing to the remote repository.
#
# The script performs the following tasks:
# 1. Sets the correct remote repository URL (either SSH or HTTPS).
# 2. Verifies the current branch and pushes changes to the remote.
#
# Usage:
# 1. Clone the repository to your local machine (if not already done).
# 2. Run this script from within the local repository directory.
# 3. Ensure you have the necessary permissions for the remote repository.
#
# The script assumes that Git is installed and configured on your system.
# It will check for SSH authentication or HTTPS credentials, depending on
# the remote URL format chosen (SSH recommended for security).
#
# Author: Ahmed Esmat
# Date: 06-12-2024
# ===========================================================
clear
rm -r ~/tmp
mkdir -p ~/tmp
REPO=`git remote -v | head -1 | awk -F"//" '{print $2}' | awk '{print"git@" $1}'`
USERNAME=`git remote -v | head -1 | awk -F"/" '{print$4}'`
SSH_URL=${REPO/\//:}
echo "Please Enter your email address"
read EMAIL
ssh-keygen -t ed25519 -C $EMAIL -f ~/tmp/key_git_repo -N ""
git config user.name $USERNAME
git config user.email $EMAIL
clear
echo "      "
echo "      "
echo "Your key is:"
echo "      "
echo "      "
echo "      "
cat ~/tmp/key_git_repo.pub
echo "      "
echo "      "
echo "Please copy the key into your repo, once done, please press any key to continue"
read -n 1 -s
git remote set-url origin $SSH_URL
eval "$(ssh-agent -s)"
ssh-add ~/tmp/key_git_repo
ssh -T git@github.com
clear
echo "Local Repo is now connected to remote repo through SSH without the need to provide credentials"
echo "                                                                                              "
echo "                                                                                              "
echo "                                                                                              "
echo "Before start, please run the below command"
echo "                                                                                              "
echo "                                                                                              "
echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
echo "                                                     "
echo "						           " 
