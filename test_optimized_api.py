import requests
import json
import time

def test_api():
    """Test the optimized API implementation."""
    try:
        print("Testing optimized API implementation...")
        
        # Test 1: Get daily predictions
        print("\nTest 1: Get daily predictions")
        response = requests.get("http://localhost:8000/api/football-json-api/predictions/daily")
        print(f"Status code: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"Found predictions for categories: {list(data.keys())}")
            for category, predictions in data.items():
                print(f"Category {category}: {len(predictions)} predictions")
        else:
            print(f"Error: {response.text}")
        
        # Test 2: Get predictions by category
        print("\nTest 2: Get predictions by category (2_odds)")
        response = requests.get("http://localhost:8000/api/football-json-api/predictions/category/2_odds")
        print(f"Status code: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"Found {len(data)} predictions in category 2_odds")
        else:
            print(f"Error: {response.text}")
        
        # Test 3: Refresh predictions (should be rate limited)
        print("\nTest 3: Refresh predictions (first time)")
        response = requests.get("http://localhost:8000/api/football-json-api/predictions/refresh")
        print(f"Status code: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"Refreshed predictions for categories: {list(data.keys())}")
        else:
            print(f"Error: {response.text}")
        
        # Test 4: Refresh predictions again (should be rate limited)
        print("\nTest 4: Refresh predictions again (should be rate limited)")
        response = requests.get("http://localhost:8000/api/football-json-api/predictions/refresh")
        print(f"Status code: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"Refreshed predictions for categories: {list(data.keys())}")
        else:
            print(f"Error: {response.text}")
        
    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    # Wait for server to start
    print("Waiting for server to start...")
    time.sleep(5)
    
    # Test API
    test_api()
