@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

title SELENE - GitHub 1-Click Upload

echo ========================================================
echo        SELENE - Upload to GitHub in 1-Click
echo ========================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Git is not installed or not found in PATH!
    echo Please install Git from https://git-scm.com/
    echo.
    pause
    exit /b 1
)

:: Ensure git repository is initialized
if not exist ".git" (
    echo [1/4] Initializing Git repository...
    git init
    git branch -M main
) else (
    echo [1/4] Git repository verified.
)

:: Ensure remote origin is set
git remote get-url origin >nul 2>nul
if %ERRORLEVEL% equ 0 (
    git remote set-url origin https://github.com/arshadali85579-star/-SELENE-.git
) else (
    git remote add origin https://github.com/arshadali85579-star/-SELENE-.git
)

:: Show current status
echo.
echo Checking changed files...
git status -s
echo.

:: Add all changes
echo [2/4] Staging all files...
git add -A

:: Ask for commit message (optional)
set "commit_msg="
set /p commit_msg="Enter commit message (Press ENTER for default: 'Update SELENE website'): "

if "%commit_msg%"=="" (
    set "commit_msg=Update SELENE website - %date% %time%"
)

:: Commit
echo.
echo [3/4] Creating commit...
git commit -m "%commit_msg%"
if %ERRORLEVEL% neq 0 (
    echo [INFO] No new changes to commit.
)

:: Push to GitHub
echo.
echo [4/4] Pushing to GitHub (main branch)...
git push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo  [SUCCESS] Code uploaded to GitHub successfully!
    echo  Repo: https://github.com/arshadali85579-star/-SELENE-
    echo ========================================================
) else (
    echo.
    echo ========================================================
    echo  [NOTICE] Push failed or authentication needed.
    echo  Please check your internet or GitHub login credentials.
    echo ========================================================
)

echo.
pause
