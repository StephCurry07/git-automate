@echo off

if not exist .git (
    git init
    git branch -M main
    git remote add origin https://github.com/StephCurry07/git-automate.git
)

git add .

for /f "delims=" %%i in ('python3 msg_generator.py') do set commit_message=%%i

git commit -m "%commit_message%"

git push -u origin main

echo Code pushed successfully with commit message: %commit_message%