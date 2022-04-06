#!/bin/bash

## Bash script to automate MongoDB new doc branch setup.
## You must pass your intended branchname as the single
## positional parameter when you invoke this script, like:
##   workflow DOC-12345-fix-typo-in-example

############################################################
## YOUR VALUES ##
#################

## Your github username:
GITUSER=your_git_user

## Your docs workspace (i.e. where to git clone to)
## If you use a ~ in the path, don't quote the value:
WORKSPACE=~/Documents/docs_workspace

############################################################
## BEGIN SCRIPT ##
##################

## Collect intended branchname from provided parameter:
BRANCHNAME=$1

# Quit if no parameters were passed or if $BRANCHNAME is incomplete:
if [ -z $BRANCHNAME ]; then
   echo -e "\nERROR: You must provide the intended branch name as a parameter."
   echo -e "       Exiting ...\n"
   exit;
elif [ `echo $BRANCHNAME | awk -F\- '{print NF-1}'` -lt 2 ]; then
   echo -e "\nERROR: Your branchname must consist of a JIRA TICKET + a DESCRIPTION."
   echo -e "       Exiting ...\n"
   exit;
fi


# Check for existing docs dir in docs workspace, just in case:
if [ -d $WORKSPACE/docs ]; then
   echo -e "\nERROR: An existing docs dir was found here:"
   echo -e "       $WORKSPACE/docs"
   echo -e "       Please manually correct move or rename this, then rerun this program."
   echo -e "       Exiting ...\n"
   exit;
fi

## Start new repo setup:
cd $WORKSPACE
git clone git@github.com:$GITUSER/docs.git
cd docs
git remote add upstream git@github.com:cockroachdb/docs.git

#sed -i '' 's%remote = origin%remote = upstream%g' .git/config
#

git pull upstream master
git checkout -b $BRANCHNAME upstream/master
git pull --rebase

## Rename `docs` based on BRANCHNAME:
cd ..
mv docs docs_$BRANCHNAME

## Open new branch in VS Code:
cd docs_$BRANCHNAME
code .
