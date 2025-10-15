import json
import os
import logging

import random
import requests

import requests
import pandas as pd
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
    execute_query("SELEC * FROM users")  # This won't run if connection fails
except DatabaseConnectionError as e:
    print("Connection Error:", e)
except QueryError as e:
    print("Query Error:", e)

