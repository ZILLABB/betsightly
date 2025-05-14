@echo off
echo Starting Football Betting Assistant Backend Server...

cd backend

:: Check if virtual environment exists
if exist venv\Scripts\activate.bat (
    echo Activating virtual environment...
    call venv\Scripts\activate.bat
) else (
    echo Creating virtual environment...
    python -m venv venv
    call venv\Scripts\activate.bat
    
    echo Installing dependencies...
    pip install -r requirements.txt
)

:: Create necessary directories
if not exist cache mkdir cache
if not exist data mkdir data
if not exist models mkdir models
if not exist predictions mkdir predictions

:: Start the server
echo Starting the backend server...
start "" python start_server.py

:: Wait for the server to start
echo Waiting for the server to start...
timeout /t 5 /nobreak > nul

:: Open the API documentation in the browser
echo Opening API documentation in browser...
start "" http://localhost:8000/docs

echo.
echo The backend server is running at http://localhost:8000
echo API documentation is available at http://localhost:8000/docs
echo.
echo Press Ctrl+C to stop the server when you're done.
echo.
