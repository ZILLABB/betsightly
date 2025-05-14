@echo off
echo Getting Today's Value Bets...

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
if not exist data mkdir data
if not exist predictions mkdir predictions

:: Run the prediction script
echo Fetching fixtures, generating predictions, and identifying value bets...
python scripts\generate_predictions.py

echo.
echo Press any key to exit...
pause > nul
