#!/bin/bash

# REPO_URL stores the path to the input file that I want to process
repo_url="reposList.txt"

feature_branch_name="feature_branch"

# check if file exist or not
if [ ! -f "$repo_url" ]; then
  echo "Repo list file '$repo_url' not found."
  exit 1
fi

# IFS= argument is an empty string to prevent trimming whitespaces
# -r => to prevent backslash
# basename => it prints the file name NAME with any leading directory components removed.
while IFS= read -r url;
do
	git clone "$url"
	repo_name=$(basename "$url" ".git")
	cd "$repo_name" || continue
	git checkout -b "$feature_branch_name" # is used to create and switch to a new branch in Git
	cd ..
done <"$repo_url" # this redirect input to the url

