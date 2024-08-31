#!/bin/sh

git add .

commit_message=$(python3 msg_generator.py)

git commit -m "$commit_message"

git push -u origin main

echo "Code pushed successfully with commit message: $commit_message"
