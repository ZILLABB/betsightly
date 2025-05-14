import os
import sys
import json
from datetime import datetime

# Add the backend directory to the path
sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)), "backend"))

# Import the football.json prediction model
try:
    from app.ml.football_json_prediction_model import football_json_prediction_model
    print("Successfully imported football_json_prediction_model")
except Exception as e:
    print(f"Error importing football_json_prediction_model: {str(e)}")
    sys.exit(1)

def test_model():
    """Test the football.json prediction model."""
    try:
        # Check if models are loaded
        print(f"Models loaded: {football_json_prediction_model.is_loaded}")
        
        # Create a sample match
        sample_match = {
            "id": "1",
            "homeTeam": {
                "name": "Manchester United"
            },
            "awayTeam": {
                "name": "Liverpool"
            },
            "competition": {
                "name": "Premier League"
            },
            "utcDate": datetime.now().isoformat()
        }
        
        # Make predictions
        print("Making predictions...")
        predictions = football_json_prediction_model.predict(sample_match)
        
        # Print predictions
        print(f"Predictions: {json.dumps(predictions, indent=2)}")
        
    except Exception as e:
        print(f"Error testing model: {str(e)}")

if __name__ == "__main__":
    test_model()
