import json
import os
import logging
import pandas as pd



#1.Write a program to create a hierarchy of custom exceptions for banking (BankError, InsufficientFunds, InvalidAccount).

# Base Exception
class BankError(Exception):

    pass

# Derived Exceptions
class InsufficientFunds(BankError):
    """Raised when account balance is not enough for a transaction."""
    def __init__(self, balance, amount):
        super().__init__(f"❌ Insufficient funds: Balance = {balance}, Tried to withdraw = {amount}")
        self.balance = balance
        self.amount = amount

class InvalidAccount(BankError):
    """Raised when an invalid account is accessed."""
    def __init__(self, account_id):
        super().__init__(f"❌ Invalid account: {account_id}")
        self.account_id = account_id

# Simulated Banking System
class BankAccount:
    def __init__(self, account_id, balance=0):
        if account_id <= 0:
            raise InvalidAccount(account_id)
        self.account_id = account_id
        self.balance = balance

    def withdraw(self, amount):
        if amount > self.balance:
            raise InsufficientFunds(self.balance, amount)
        self.balance -= amount
        print(f"✅ Withdrawal successful: {amount}, Remaining Balance: {self.balance}")

# --- Example Usage ---
try:
    acc1 = BankAccount(101, balance=500)
    acc1.withdraw(200)   # ✅ Works
    acc1.withdraw(400)   # ❌ Raises InsufficientFunds

except BankError as e:
    print(e)

print("\n--- Testing Invalid Account ---")
try:
    acc2 = BankAccount(-5, balance=1000)  # ❌ Raises InvalidAccount
except BankError as e:
    print(e)


#2.Write a program that raises a custom exception when user enters a weak password.

class WeakPasswordError (Exception):
    pass

def checkpassword(password):
    if len(password)<8:
        raise WeakPasswordError("❌ Password too short (min 8 characters required).")
    if not any (ch.isupper() for ch in password):
        raise WeakPasswordError("❌ Password must contain atleast one uppercase letter.")
    if not any (ch.islower() for ch in password):
        raise WeakPasswordError("❌ Password must contain atleast one lowercase letter.")
    if not any (ch.isdigit() for ch in password):
        raise WeakPasswordError("❌ Password must contain atleast one digit.")
    if not any(ch in "!@#$%^&*-+=" for ch in password):
        raise WeakPasswordError("❌ Password must contain atleast one special character.")
    
    print("✅ Strong password accepted!")

try:
    password = input("Enter your password: ")
    checkpassword(password)
except WeakPasswordError as e:
    print(e)


#3.Write a program that handles multiple custom exceptions in an e-commerce system (OutOfStockError, PaymentFailedError).

class OutOfStockError(Exception):
    pass

class PaymentFailedError(Exception):
    pass

def purchase_item(inventory, item, qty, payment_success=True):
    if item not in inventory:
        raise OutOfStockError(f"❌ {item} is not available in the store")
    if inventory[item] < qty:
        raise OutOfStockError(f"❌ Not enough stock for {item}, available: {inventory[item]}")
    if not payment_success:
        raise PaymentFailedError("❌ Payment failed: Card declined")

    inventory[item] -= qty
    return f"✅ Purchased {qty} {item}(s)"

# Inventory
inventory = {"laptop": 5, "phone": 10, "tablet": 2}

try:
    print(purchase_item(inventory, "phone", 2, payment_success=False))  # ❌ Payment failure
except OutOfStockError as e:
    print(e)
except PaymentFailedError as e:
    print(e)


#4.Write a program to simulate exception handling in machine learning model training (skip invalid rows).



#5.Write a program that raises exceptions if missing values are detected in a dataset.

class MissingValueError(Exception):
    pass

def check_missing_values(df):
    if df.isnull().values.any():
        # Find which columns have missing values
        missing_cols = df.columns[df.isnull().any()].tolist()
        raise MissingValueError(f"❌ Missing values detected in columns: {missing_cols}")
    print("✅ No missing values detected")


data = {
    "CustomerID": [101, 102, 103, 104],
    "Name": ["Alice", "Bob", None, "David"],
    "Balance": [5000, None, 3000, None]      
}

df = pd.DataFrame(data)

try:
    check_missing_values(df)
except MissingValueError as e:
    print(e)


#6.Write a program that handles exceptions while saving a model to disk.



#7.Write a program that catches exceptions during multi-threaded execution.


#8.Write a program that demonstrates a global exception handler for a Python script.


#9.Write a program that raises custom exceptions for invalid file formats (.csv, .json, .xml).

# Base Exception
class InvalidFileFormat(Exception): 
    pass

# Specific Exceptions
class InvalidCSVError(InvalidFileFormat): pass
class InvalidJSONError(InvalidFileFormat): pass
class InvalidXMLError(InvalidFileFormat): pass

def open_file(filename):
    if filename.endswith(".csv"):
        print("✅ CSV file accepted:", filename)
    elif filename.endswith(".json"):
        print("✅ JSON file accepted:", filename)
    elif filename.endswith(".xml"):
        print("✅ XML file accepted:", filename)
    else:
        raise InvalidFileFormat(f"❌ Unsupported file format: {filename}")

# Example usage
try:
    print("\nQ9. Invalid File Format")
    open_file("data.txt")   # Invalid
except InvalidCSVError as e:
    print("CSV Error:", e)
except InvalidJSONError as e:
    print("JSON Error:", e)
except InvalidXMLError as e:
    print("XML Error:", e)
except InvalidFileFormat as e:
    print("General File Error:", e)



#10.Write a program to implement centralized exception logging for a Python application.