#!/bin/bash
# mkdir -p ~/.ssh
# touch ~/.ssh/known_hosts

# ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts


if [ ! -d ".git" ]; then
    git init
    git branch -M main
    git remote add origin git@github.com:StephCurry07/git-automate.git
fi

git remote set-url origin git@github.com:StephCurry07/git-automate.git

git add .

commit_message="success"

git commit -m "$commit_message"

git push -u origin main

echo "Code pushed successfully with commit message: $commit_message"
