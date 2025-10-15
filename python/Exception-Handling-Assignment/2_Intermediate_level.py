import pandas as pd
import json
import os



#1.Write a function to withdraw money and raise an exception if balance < withdrawal.
class withdrawalerror(Exception):
    pass
def withdrawal(balance,withdraw):
    if withdraw>balance:
        raise withdrawalerror("Withdraw Exceeding Balance")
    balance -= withdraw

try:
    print(withdrawal(1000,3500))
except withdrawalerror as e:
    print("Error",e)

#2.Write a function that validates age and raises an exception if age < 18.
class Agevalidationerror(Exception):
    pass
def age_validate(age):
    if age < 18:
        raise Agevalidationerror ("Minimum age should be 18")
    return "Age is valid."
try:
    age = int(input("Enter your age: "))
    result = age_validate(age)
    print(result)
except Agevalidationerror as e:
    print("Error:", e)
except ValueError:
    print("Error: Please enter a valid number.")

#3.Write a program to validate email format and raise a custom exception.
class Emailvalidationerror(Exception):
    pass
def email_validate(email):
    if not email.endswith("@gmail.com"):
        raise Emailvalidationerror("Email is not valid")
    return "Email is valid."
try:
    email = input("Enter your email: ")
    result = email_validate(email)
    print(result)
except Emailvalidationerror as e:
    print("Error",e)

#4.Write a custom exception NegativeNumberError and use it in a square root function.
class NegativeNumberError(Exception):
  pass
def squareroot(num):
  if num<0:
    raise NegativeNumberError("Cannot take square root of the negative number")
  else:
    return num**0.5
try:
    num = float(input("Enter a number: "))
    result = squareroot(num)
    print(result)
except NegativeNumberError as e:
    print("Error",e)
except ValueError as e:
    print("Error",e)

#5.Write a custom exception for InsufficientFundsError in a banking system.
class InsufficientFundsError(Exception):
    pass

def withdraw(balance, amount):
    if amount > balance:
        raise InsufficientFundsError(f"❌ Withdrawal of {amount} failed! Available balance: {balance}")
    balance -= amount
    return f"✅ Withdrawal of {amount} successful! Remaining balance: {balance}"

balance = 5000

try:
    print(withdraw(balance, 1000))
except InsufficientFundsError as e:
    print("Handled:", e)

try:
    print(withdraw(balance, 3000))
except InsufficientFundsError as e:
    print("Handled:", e)

#6.Write a program that handles exceptions while parsing JSON.

# Sample JSON data (as a string for demonstration)
json_string = '{"name": "Alice", "age": 30}'  # This is valid JSON
json_string = '{"name": "Alice", "age": 30'  

try:
    # Attempt to parse the JSON string
    data = json.loads(json_string)
    print("JSON parsed successfully!")
    print("Data:", data)
except json.JSONDecodeError as e:
    print("Error: Failed to parse JSON.")
    print("Details:", e)
except Exception as e:
    print("An unexpected error occurred.")
    print("Details:", e)


#7.Write a program to retry dividing two numbers 3 times if an error occurs.
attempts = 0
max_attempts = 3

while attempts < max_attempts:
    try:
        a = float(input("Enter a number: "))
        b = float(input("Enter a number: "))
        result = a / b 
    except ZeroDivisionError:
        print("Error: Division by zero is not allowed.")
    except ValueError:
        print("Error: Please enter valid numbers.")
    else:
        print(f"The result is: {result}")
        break  # Exit the loop if successful
    attempts += 1
    print(f"Attempt {attempts} of {max_attempts} failed.\n")

if attempts == max_attempts:
    print("Maximum attempts reached. Please try again later.")

#8.Write a program that uses assert to validate positive numbers and handle AssertionError.
try:
    num = float(input("Enter a positive number: "))
    assert num > 0 ,"The Number Must be positive"
    print("Entered a valid number")
except AssertionError as e:
    print("Error",e)
except ValueError as e:
    print("Error",e)

#9.Write a program that logs exceptions to a file using logging module.


#10.Write a program that raises multiple custom exceptions (InvalidPasswordError, InvalidUsernameError).
class InvalidUsernameError(Exception):
    pass

class InvalidPasswordError(Exception):
    pass

def login(username,password):
  if len(username) < 5 or not username.isalnum():
        raise InvalidUsernameError("Username must be at least 5 characters long and contain only letters and numbers.")
  if len(password) < 8:
        raise InvalidPasswordError("Password must be at least 8 characters long.")
  if password.islower() or password.isupper():
        raise InvalidPasswordError("Password must contain both uppercase and lowercase letters.")
  if password.isalnum():
        raise InvalidPasswordError("Password must contain at least one special character.")
  return "Login Successful"

try:
    username = input("Enter Username: ")
    password = input("Enter Password: ")
    result = login(username, password)
    print(result)
except InvalidUsernameError as e:
    print("Username Error: e")
except InvalidPasswordError as e:
    print("Password Error: e")