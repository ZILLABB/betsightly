import sqlite3
import json
import os

# Connect to the database
db_path = os.path.join('backend', 'data', 'betsightly.db')
print(f"Checking database at: {os.path.abspath(db_path)}")

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Get all tables
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = [row[0] for row in cursor.fetchall()]
print(f"Tables in database: {tables}")

# Check if predictions table exists
if 'predictions' in tables:
    # Get count of predictions
    cursor.execute("SELECT COUNT(*) FROM predictions")
    count = cursor.fetchone()[0]
    print(f"Number of predictions: {count}")

    # Get sample predictions
    cursor.execute("SELECT * FROM predictions LIMIT 5")
    columns = [description[0] for description in cursor.description]
    rows = cursor.fetchall()

    # Print sample predictions
    print("\nSample predictions:")
    for row in rows:
        prediction = dict(zip(columns, row))
        print(json.dumps(prediction, indent=2))

# Check if fixtures table exists
if 'fixtures' in tables:
    # Get count of fixtures
    cursor.execute("SELECT COUNT(*) FROM fixtures")
    count = cursor.fetchone()[0]
    print(f"\nNumber of fixtures: {count}")

    # Get sample fixtures
    cursor.execute("SELECT * FROM fixtures LIMIT 5")
    columns = [description[0] for description in cursor.description]
    rows = cursor.fetchall()

    # Print sample fixtures
    print("\nSample fixtures:")
    for row in rows:
        fixture = dict(zip(columns, row))
        print(json.dumps(fixture, indent=2))

# Close connection
conn.close()
