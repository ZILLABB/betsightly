import requests
import json
import time

def test_api():
    """Test the API in detail."""
    try:
        # Test health endpoint
        print("Testing health endpoint...")
        response = requests.get("http://localhost:8000/api/health")
        print(f"Health endpoint: {response.status_code}")
        if response.status_code == 200:
            print(response.json())
        
        # Test football.json API predictions endpoint
        print("\nTesting football.json API predictions endpoint...")
        response = requests.get("http://localhost:8000/api/football-json-api/predictions/daily")
        print(f"Football.json API predictions endpoint: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Found predictions for categories: {list(data.keys())}")
            for category, predictions in data.items():
                print(f"Category {category}: {len(predictions)} predictions")
        else:
            print(f"Error response: {response.text}")
        
        # Test football.json API predictions by category endpoint
        print("\nTesting football.json API predictions by category endpoint...")
        for category in ["2_odds", "5_odds", "10_odds"]:
            print(f"\nTesting category: {category}")
            response = requests.get(f"http://localhost:8000/api/football-json-api/predictions/category/{category}")
            print(f"Category {category} endpoint: {response.status_code}")
            if response.status_code == 200:
                data = response.json()
                print(f"Found {len(data)} predictions")
                if data:
                    print(f"First prediction: {data[0]['predictionType']} - {data[0]['prediction']}")
            else:
                print(f"Error response: {response.text}")
        
        # Test football.json API predictions refresh endpoint
        print("\nTesting football.json API predictions refresh endpoint...")
        response = requests.get("http://localhost:8000/api/football-json-api/predictions/refresh")
        print(f"Football.json API predictions refresh endpoint: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Refreshed predictions for categories: {list(data.keys())}")
        else:
            print(f"Error response: {response.text}")
        
    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    # Wait for server to start
    print("Waiting for server to start...")
    time.sleep(5)
    
    # Test API
    test_api()
