import json
import os 
import logging
import requests




#1.Write a program that demonstrates exception propagation across multiple functions.


#2.Write a program using exception chaining (raise ... from ...).

class CalculationError(Exception):
    pass

def divide(a, b):
    try:
        return a / b
    except ZeroDivisionError as e:
        raise CalculationError("❌ Division failed") from e

try:
    result = divide(10, 0)
    print(result)
except CalculationError as e:
    print("Caught exception:", e)
    print("Original exception:", e.__cause__)  # Shows the original ZeroDivisionError



#3.Write a program that simulates database connection and raises custom exceptions.

class DatabaseConnectionError(Exception): pass
class QueryError(Exception): pass

# --- Database Simulation ---
def connect_to_db():
    # Simulate a connection attempt
    raise DatabaseConnectionError("❌ Unable to connect to database")

def execute_query(query):
    # Simulate query execution
    if not query.upper().startswith("SELECT"):
        raise QueryError(f"❌ Invalid query: {query}")
    print(f"✅ Query executed: {query}")

try:
    connect_to_db()                   # Try connecting
    execute_query("SELECT * FROM users")  # This won't run if connection fails
except DatabaseConnectionError as e:
    print("Connection Error:", e)
except QueryError as e:
    print("Query Error:", e)



#4.Write a program that reads from a file using with statement and handles errors.

try:
    with open("sample.txt", "r") as f:
      content = f.read()
    print(content)
except FileNotFoundError as e:
    print("Error",e)


#5.Write a program that skips bad data rows in a CSV file using exception handling.


#6.Write a program that handles timeout error when connecting to a server (use requests).


url = "https://httpbin.org/delay/5"  # This delays response by 5 seconds

try:
    # Set timeout to 2 seconds (will raise Timeout)
    response = requests.get(url, timeout=2)
    print("✅ Success:", response.status_code)

except requests.exceptions.Timeout:
    print("⏱️ Request timed out!")

except requests.exceptions.RequestException as e:
    print("❌ An error occurred:", e)


#7.Write a program that handles exceptions in a recursive factorial function.

def factorial(n):
    if n < 0:
        raise ValueError("Negative not allowed")
    return 1 if n == 0 else n * factorial(n-1)

try:
    print(factorial(-5))
except ValueError as e:
    print("Error:", e)


#8.Write a program that simulates transaction rollback in a banking system using exceptions.


#9.Write a program to validate credit card numbers and raise exceptions for invalid inputs.

class InvalidCardError(Exception): pass
class NonDigitError(InvalidCardError): pass
class InvalidLengthError(InvalidCardError):pass 

def validate(card_number):
        if not card_number.isdigit():
            raise NonDigitError("❌ Card number must contain only digits")

        if len(card_number) != 16:
            raise InvalidLengthError("❌ Card number length must be 16 digits")
        return "✅ Card number is valid"

try:
    card_number = "4539578763621486" 
    print(validate(card_number))

except InvalidCardError as e:
    print(e)


#10.Write a program that raises an exception if memory usage goes beyond a threshold.

class MemoryThresholdError(Exception):
    pass

def check_memory_usage(usage, threshold=60):
    if usage > threshold:
        raise MemoryThresholdError(f"Memory usage {usage}% exceeded threshold of {threshold}%")
    else:
        print(f"Memory usage {usage}% is within safe limits")

try:
    # Simulated usage (we can change this number to test)
    usage = 59  
    check_memory_usage(usage)
except MemoryThresholdError as e:
    print("Custom Exception:", e)