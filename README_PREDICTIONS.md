# BetSightly Predictions System

This document explains the optimized predictions system for BetSightly.

## Overview

The BetSightly predictions system has been optimized to:

1. Use only GitHub football data for training ML models
2. Fetch daily fixtures from Football-Data.org API with strict rate limiting
3. Generate predictions using trained models
4. Cache predictions to minimize API calls
5. Categorize predictions by odds (2 odds, 5 odds, 10 odds)

## API Rate Limits

Football-Data.org API has the following rate limits for the free tier:

- 10 calls per minute
- Limited to 12 competitions

To respect these limits, the system implements:

- Strict caching of fixtures and predictions
- Rate limiting for API calls (minimum 6 seconds between calls)
- Refresh limiting (maximum once per hour)

## Caching Strategy

The system uses a multi-level caching strategy:

1. **Database Cache**:

   - Predictions are cached with a 24-hour TTL
   - Fixtures are cached with a 24-hour TTL
   - Last refresh times are tracked to prevent excessive refreshes

2. **File Cache**:
   - Predictions are also saved to JSON files for backup
   - Files are used if database cache is unavailable

## API Endpoints

The following API endpoints are available:

1. **Get Daily Predictions**:

   - `GET /api/football-json-api/predictions/daily`
   - Returns predictions for today (or specified date) grouped by category
   - Uses cached data when available

2. **Get Predictions by Category**:

   - `GET /api/football-json-api/predictions/category/{category}`
   - Returns predictions for a specific category (2_odds, 5_odds, 10_odds)
   - Uses cached data when available

3. **Refresh Predictions**:
   - `GET /api/football-json-api/predictions/refresh`
   - Forces a refresh of predictions
   - Rate limited to once per hour to avoid excessive API calls

## Usage

To use the predictions system:

1. Ensure the backend server is running
2. Access predictions through the API endpoints
3. The system will automatically fetch fixtures and generate predictions when needed
4. Predictions will be cached to minimize API calls

No additional processes or schedulers are needed - the system is designed to be self-contained and efficient.

## Best Practices

To avoid API rate limits:

1. Use the cached predictions whenever possible
2. Limit refresh requests to once per hour
3. Schedule refreshes during off-peak hours
4. Use the category endpoints to fetch only the predictions you need

## Troubleshooting

If you encounter issues:

1. Check the server logs for error messages
2. Verify that the Football-Data.org API key is valid
3. Check if you've exceeded the API rate limits
4. Clear the cache if predictions are stale

## Future Improvements

Potential improvements for the future:

1. Implement a background job to refresh predictions during off-peak hours
2. Add more sophisticated caching with Redis or similar
3. Implement fallback data sources if Football-Data.org is unavailable
4. Add more prediction categories and types
