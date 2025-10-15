import json
import os
import logging


#1.Write a program that raises a custom exception if a data file is missing.

class DataFileMissingError(Exception):
    def __init__(self, filename):
        super().__init__(f"Data file '{filename}' is missing.")
        self.filename = filename

# Function to check if the file exists
def check_data_file(filename):
    if not os.path.exists(filename):
        raise DataFileMissingError(filename)
    else:
        print(f"Data file '{filename}' found!")

# File to check
filename = "data.txt"  

try:
    check_data_file(filename)
except DataFileMissingError as e:
    print("Error: e")


#2.Write a program that raises exceptions when schema mismatch occurs in a dataset.

class SchemaMismatchError(Exception):
    pass

def validate_schema(df_schema, expected_schema):
    if df_schema != expected_schema:
        raise SchemaMismatchError(f"❌ Schema mismatch! Got {df_schema}, Expected {expected_schema}")
    return "✅ Schema validation passed"

try:
    print(validate_schema(["id", "name"], ["id", "name", "amount"]))
except SchemaMismatchError as e:
    print("Handled:", e)

#3.Write a program that handles KeyError while accessing dictionary values in a dataset.

# Configure logging to write errors to a file with timestamp and level
logging.basicConfig(filename='data_processing.log', level=logging.ERROR,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# Example dataset (could be from a CSV, database, etc.)
dataset = [
    {"id": 1, "name": "Alice", "age": 30},
    {"id": 2, "name": "Bob"},  # Missing 'age'
    {"id": 3, "name": "Charlie", "age": 25},
    {"id": 4, "name": "Diana", "age": None}  # age is None
]

def process_dataset(dataset):
    processed_data = []
    for row in dataset:
        try:
            # Ensure 'age' is present and valid
            if "age" not in row or row["age"] is None:
                raise KeyError("age")
        except KeyError as e:
            error_msg = f"Missing or invalid key {e} in row: {row}"
            logging.error(error_msg)
            print(f"Warning: {error_msg}")
        except Exception as e:
            error_msg = f"Unexpected error in row {row}: {e}"
            logging.error(error_msg)
            print(f"Error: {error_msg}")

    return processed_data

# Run the dataset processing
result = process_dataset(dataset)


#4.Write a program to simulate ETL pipeline exception handling (Extract → Transform → Load).



#5.Write a program to catch exceptions while reading data from an API.


#6.Write a program to handle exceptions while connecting to Azure Blob Storage (mocked).


#7.Write a program that handles exceptions when reading from a corrupted JSON file.

def read_json_file(file_path):
    try:
        print(f"🔹 Reading JSON file: {file_path}")
        with open(file_path, "r") as f:
            data = json.load(f)  # may raise JSONDecodeError
        print("✅ Successfully read JSON data")
        return data

    except FileNotFoundError:
        print(f"❌ File not found: {file_path}")
    except json.JSONDecodeError as e:
        print(f"❌ JSON decode error at line {e.lineno}, column {e.colno}: {e.msg}")
    except PermissionError:
        print(f"⚠️ Permission denied: {file_path}")
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
    finally:
        print("🔚 JSON read attempt finished\n")

# --- Example Run ---
corrupted_file = "corrupted.json"

# Write invalid JSON for testing
with open(corrupted_file, "w") as f:
    f.write('{"id": 1, "name": "Alice", "age": 25,}')  # corrupted JSON

# Call the function directly
data = read_json_file(corrupted_file)

if data:
    print("Data:", data)

#8.Write a program that raises an exception when duplicate data is found in a dataset.

class DuplicateDataError(Exception):
    """Custom exception for duplicate data in dataset."""
    pass

def check_duplicates(dataset):
    seen = set()
    for record in dataset:
        if record in seen:
            raise DuplicateDataError(f"❌ Duplicate data found: {record}")
        seen.add(record)
    print("✅ No duplicates found")

# --- Example Usage ---
dataset1 = [101, 102, 103, 104, 105]
dataset2 = [201, 202, 203, 201, 204] 

try:
    print("Checking dataset1...")
    check_duplicates(dataset1)

    print("Checking dataset2...")
    check_duplicates(dataset2)

except DuplicateDataError as e:
    print(e)


#9.Write a program to catch exceptions while writing data into SQL database.


#10.rite a program that retries failed API requests 3 times using exception handling.

