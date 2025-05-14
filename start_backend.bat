@echo off
echo Starting Football Betting Assistant Backend...

cd backend

:: Check if virtual environment exists
if exist venv\Scripts\activate.bat (
    echo Activating virtual environment...
    call venv\Scripts\activate.bat
) else (
    echo Virtual environment not found. Please run setup.bat first.
    pause
    exit /b 1
)

:: Start the server
echo Starting server...
python start_server.py

pause
