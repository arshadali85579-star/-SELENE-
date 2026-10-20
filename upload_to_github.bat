@echo off
setlocal
cd /d "%~dp0"

echo ========================================================
echo        SELENE - Upload to GitHub in 1-Click
echo ========================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Git is not installed or not in PATH!
    echo Please install Git from https://git-scm.com/
    pause
    exit /b 1
)

:: Initialize git if not already initialized
if not exist ".git" (
    echo [1/5] Initializing Git repository...
    git init
    git branch -M main
) else (
    echo [1/5] Git repository already initialized.
)

:: Set remote origin
echo [2/5] Setting remote repository URL...
git remote get-url origin >nul 2>nul
if %ERRORLEVEL% equ 0 (
    git remote set-url origin https://github.com/arshadali85579-star/-SELENE-.git
) else (
    git remote add origin https://github.com/arshadali85579-star/-SELENE-.git
)

:: Add all files
echo [3/5] Adding files to commit...
git add .

:: Commit
echo [4/5] Creating commit...
git commit -m "Deploy SELENE website" 2>nul
if %ERRORLEVEL% equ 0 (
    echo Commit created successfully.
) else (
    echo No new changes to commit or commit already up to date.
)

:: Push to GitHub
echo [5/5] Pushing files to GitHub (main branch)...
git push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo  SUCCESS! Code uploaded to GitHub successfully!
    echo  Repo: https://github.com/arshadali85579-star/-SELENE-
    echo ========================================================
) else (
    echo.
    echo ========================================================
    echo  [NOTICE] If push failed, check your GitHub login/credentials.
    echo ========================================================
)

echo.
pause
