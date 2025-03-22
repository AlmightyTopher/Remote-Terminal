@echo off
SETLOCAL ENABLEEXTENSIONS

:: Set script directory as working directory
cd /d "%~dp0"

:: Step 1 - Check for Python
where python >nul 2>nul || (
  echo ❌ Python is not installed. Installing with winget...
  winget install -e --id Python.Python.3.10 || goto error
)

:: Step 2 - Check for pip
where pip >nul 2>nul || (
  echo ❌ pip not found. Trying to repair Python installation...
  python -m ensurepip --upgrade || goto error
)

:: Step 3 - Install dependencies
pip install -r requirements.txt || goto error

:: Step 4 - Start the agent
start cmd /k python "%~dp0agent.py"

echo ✅ Agent started successfully!
echo Open your Cloudflare-hosted website in a browser to test.
pause
exit /b 0

:error
echo ❌ Setup failed. Please ensure Python and pip are installed correctly.
pause
exit /b 1
