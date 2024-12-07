
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
mkdir -p ~/tmp
<<<<<<< HEAD
REPO=`git remote -v | head -1 | awk -F"//" '{print $2}' | awk '{print"git@" $1}'`
SSH_URL=${REPO/\//:}
echo "Please Enter your email address"
read email
=======
REPO=`git remote -v | head -1 | awk -F"//" '{print $2}' | awk '{print $1}'`
echo $REPO
SSH_URL=${REPO/\//:}
echo $SSH_URL
USER_NAME=`git remote -v | head -1 | awk -F"/" '{print $2}'`
mkdir ~/tmp
echo "Please Enter your email address"
read email
echo "SSH_URL_is" $SSH_URL
git config --global user.email $email
git config --global user.name $USER_NAME
>>>>>>> b49c1e4ded727719b1002f820e4d9cd18bae24ed
ssh-keygen -t ed25519 -C $email -f ~/tmp/key_git_repo -N ""
eval "$(ssh-agent -s)"
ssh-add ~/tmp/key_git_repo
#clear
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
ssh -T git@github.com
<<<<<<< HEAD
rm -r ~/tmp
=======
>>>>>>> b49c1e4ded727719b1002f820e4d9cd18bae24ed
