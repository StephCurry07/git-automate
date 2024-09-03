@echo off

git branch -M main

if not exist .git (
    git init
    git remote add origin https://github.com/StephCurry07/git-automate.git
)

git add .

@REM for /f "delims=" %%i in ('python3 msg_generator.py') do set commit_message=%%i

git commit -m success

git push -u origin main

echo Code pushed successfully with commit message: success