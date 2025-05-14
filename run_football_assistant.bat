@echo off
echo Starting Football Betting Assistant...

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
if not exist data\historical mkdir data\historical
if not exist data\historical\processed mkdir data\historical\processed
if not exist data\historical\raw mkdir data\historical\raw
if not exist models mkdir models

:: Run the pipeline
echo Running the pipeline...
python scripts\run_pipeline.py

pause
