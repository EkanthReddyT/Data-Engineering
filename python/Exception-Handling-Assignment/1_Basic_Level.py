#1.Write a program to handle division by zero using try-except.  

try:
    a,b = 10,0
    result = a/b
    print("The result is:", result)
except ZeroDivisionError:
    print("Error: Division by zero is not allowed.")

#2.Write a program to handle invalid user input (string instead of number).
try:
    user_input = int(input("Enter a number: "))
    print("Input is Valid",user_input)
except ValueError:
    print("Invalid Input.Enter a Number")

#3.Write a program that catches IndexError when accessing a list element.
try:
    num = [1,2,3,4,6,7,8,9]
    print(num[15])
except IndexError as e:
    print("Error",e)

#4.Write a program to open a file and handle FileNotFoundError.
try:
    with open("sample.txt",'r')as file:
        content = file.read()
        print(content)
except FileNotFoundError as e:
    print("Error",e)

#5.Write a program that handles multiple exceptions (ZeroDivisionError, ValueError).
try:
    a = int(input("Enter a Number: "))
    b = int(input("Enter a Number: "))
    result = a/b
    print("Result",result)
except ZeroDivisionError as e:
    print("Error",e)
except ValueError as e:
    print("Error",e)

#6.Write a program using try-except-else to check if a number is even.
try:
    a = int(input("Enter a Number: "))
except ValueError as e:
    print("Error",e)
else:
    if a%2 ==0:
        print("Number is Even")
    else:
        print("Number is Odd")

#7.Write a program with finally block to always display "Execution Completed".
try:
    num = int("7")
except ValueError:
    print("Invalid integer")
else:
    print("Converted:", num+ 3)
finally:
    print("Execution Completed\n")

#8.Write a program to demonstrate nested try-except blocks.
try:
    a = int(input("Enter a number: "))
    b = int(input("Enter a number: "))
    try:
        result = a/b
    except ZeroDivisionError as e:
        print("Error",e)
    else:
        print(result)
except ValueError as e:
    print("Error",e)

#9.Write a program that asks for two numbers and handles both division and conversion errors.
try:
    x = int(input("Enter a number: "))
    y = int(input("Enter a number: "))
    result = x/y
except ValueError as e:
    print("Error",e)
except ZeroDivisionError as e:
    print("Error",e)
else:
    print(result)

#10.Write a program that raises and handles a TypeError.
try:
    res = "Raghu"+5
except TypeError as e:
    print("Error",e)