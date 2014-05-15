#!/bin/bash
# This script will assist in moving an old TG2 project from a git repo onto the
# OpenShift Framework put together by Luke Macken.

proj="pyramidapp"

read -p "Enter project name [$proj]: " -e temp
if [ -n "$temp" ]
then
    proj="$temp"
fi
read -p "Enter git repository to use: " -e repo

# Modify important files.
sed -e "s|APP=pyramidapp|APP=$proj|g" -i .openshift/action_hooks/build
sed -e "s|APP=pyramidapp|APP=$proj|g" -i .openshift/action_hooks/deploy
sed -e "s|pyramidapp|$proj|g" -i .gitignore
sed -e "s|pyramidapp|$proj|g" -i wsgi/application

# Remove the existing wsgi/pyramidapp directory to avoid confusion.
rm -r wsgi/pyramidapp

# Pull the existing repository as a submodule.
git clone "$repo" "wsgi/$proj"
