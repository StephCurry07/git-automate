#!/bin/bash

# Initialize git repository and add remote if not already initialized
if [ ! -d ".git" ]; then
    git branch -M main
    git init
    git remote add origin https://github.com/StephCurry07/git-automate.git
fi

# Stage all changes
git add .

# Generate commit message using Python script
commit_message=$(python3 msg_generator.py)

# Commit changes with the generated message
git commit -m "$commit_message"

# Push changes to the remote repository
git push -u origin main

echo "Code pushed successfully with commit message: $commit_message"
