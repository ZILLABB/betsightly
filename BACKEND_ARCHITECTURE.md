# Football Prediction System: Backend Architecture

This document explains the architecture and workflow of the Football Prediction System backend.

## System Overview

The Football Prediction System is a machine learning-powered platform that predicts football match outcomes with high accuracy. The system uses ensemble machine learning models trained on historical football data from the Club-Football-Match-Data-2000-2025 GitHub repository.

## Key Components

### 1. Database Layer

The system uses SQLite (with option to use PostgreSQL) to store:

- **Fixtures**: Football matches fetched from API-Football
- **Predictions**: ML model predictions for these fixtures

Database models are defined in:
- `app/models/fixture.py`
- `app/models/prediction.py`

Database configuration is in:
- `app/database.py`

### 2. Machine Learning Layer

The ML pipeline consists of:

- **Data Collection**: Fetches historical data from GitHub repository
- **Feature Engineering**: Extracts and transforms features for prediction
- **Model Training**: Trains ensemble models for match results, over/under, and BTTS
- **Prediction**: Makes predictions on upcoming fixtures

Key ML files:
- `app/ml/ensemble_model_improved.py`: Enhanced ensemble models
- `scripts/train_enhanced_github_models.py`: Training script for ensemble models
- `scripts/predict_with_github_models.py`: Prediction script using trained models

### 3. API Layer

The system exposes a RESTful API built with FastAPI:

- **Fixtures Endpoints**: Access to football fixtures
- **Predictions Endpoints**: Access to match predictions
- **Dashboard Endpoints**: Summary statistics and high-confidence predictions

Key API files:
- `app/main.py`: FastAPI application setup
- `app/api/api.py`: API router configuration
- `app/api/endpoints/*.py`: API endpoint implementations

### 4. Service Layer

Services handle business logic and external API interactions:

- **Fixture Service**: Manages fixture data
- **Prediction Service**: Handles prediction generation and retrieval
- **API Client**: Interfaces with external APIs

Key service files:
- `app/services/fixture_service.py`: Fixture data management
- `app/services/prediction_service_improved.py`: Prediction generation
- `app/services/api_client.py`: Base API client

## Data Flow

### 1. Daily Fixture Collection

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  API-Football   │────▶│  API Client     │────▶│  Database       │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

- Script: `scripts/daily_predictions_production.py`
- Frequency: Once daily (scheduled via cron)
- Process:
  1. Fetches fixtures from API-Football
  2. Stores fixtures in database
  3. Handles rate limiting and caching

### 2. Prediction Generation

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Fixtures Data  │────▶│  ML Models      │────▶│  Database       │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

- Script: `scripts/daily_predictions_production.py`
- Process:
  1. Retrieves fixtures from database
  2. Loads trained ML models
  3. Generates predictions
  4. Stores predictions in database

### 3. API Access

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Client Request │────▶│  FastAPI        │────▶│  Database       │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

- Entry point: `app/main.py`
- Process:
  1. Client makes HTTP request
  2. FastAPI routes request to appropriate endpoint
  3. Endpoint retrieves data from database
  4. Response returned to client

## ML Model Architecture

The system uses ensemble models combining:

1. **Random Forest**: Excellent for handling non-linear relationships
2. **Gradient Boosting**: Provides high precision for specific outcomes
3. **Logistic Regression**: Adds stability and interpretability

Three separate models are trained:
- **Match Result**: Predicts home win, draw, or away win
- **Over/Under 2.5 Goals**: Predicts whether total goals will be over or under 2.5
- **Both Teams To Score (BTTS)**: Predicts whether both teams will score

## API Rate Limit Handling

API-Football has rate limits that reset at midnight UTC:
- Free Plan: 100 requests per day
- Pro Plan: 1,000 requests per day
- Ultra Plan: 10,000 requests per day

The system handles these limits through:
1. **Database Caching**: Stores fixtures to minimize API calls
2. **Request Delays**: Adds 1.2-second delay between requests
3. **Error Handling**: Detects 429 errors and implements backoff
4. **Daily Scheduling**: Runs once per day to optimize API usage

## Deployment Architecture

The system is designed to run as a standalone service:

```
┌─────────────────────────────────────────────────────┐
│                      Server                         │
│                                                     │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────┐  │
│  │ FastAPI     │◀──▶│ ML Models   │◀──▶│ SQLite  │  │
│  └─────────────┘    └─────────────┘    └─────────┘  │
│         ▲                                           │
└─────────┼───────────────────────────────────────────┘
          │
┌─────────┼───────────────────────────────────────────┐
│         │                                           │
│  ┌─────────────┐    ┌─────────────┐                 │
│  │ Frontend    │◀──▶│ User Browser│                 │
│  └─────────────┘    └─────────────┘                 │
│                                                     │
└─────────────────────────────────────────────────────┘
```

## Startup Process

1. **Database Initialization**: `app/database.py` initializes the database
2. **FastAPI Startup**: `app/main.py` creates and configures the FastAPI application
3. **Server Launch**: `run.py` or `start_server.py` starts the uvicorn server

## Scheduled Tasks

The system uses cron jobs for scheduled tasks:
- **Daily Predictions**: Runs once per day to fetch fixtures and make predictions
- **Model Training**: Can be scheduled weekly/monthly to retrain models with new data

## Files to Remove/Ignore

The following files are no longer used and can be removed:

1. **Duplicate Model Files**:
   - `app/ml/ensemble_model.py` - Replaced by `ensemble_model_improved.py`
   - `app/ml/football_prediction_model.py` - Replaced by GitHub-based models

2. **Unused Service Files**:
   - `app/services/prediction_service.py` - Replaced by `prediction_service_improved.py`
   - `app/services/api_football_client.py` - Has incorrect imports

3. **Unused Scripts**:
   - `scripts/fetch_football_data_github.py` - Replaced by direct download
   - `scripts/generate_predictions.py` - Replaced by `predict_with_github_models.py`
   - `scripts/generate_simple_predictions.py` - Replaced by enhanced models
   - `scripts/train_ml_models.py` - Replaced by `train_github_models.py`
   - `scripts/train_simple_models.py` - Replaced by enhanced models
   - `scripts/convert_csv_to_parquet.py` - Not needed with GitHub data format
   - `scripts/download_football_data.py` - Replaced by direct download
