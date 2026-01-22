#!/bin/bash

# USER INPUT IN SHELL SCRIPTING
# The 'read' command is used to take input from the user

# BASIC READ COMMAND
# Syntax: read variable_name

echo "What is your name?"
read name
echo "Hello, $name!"

# READ WITH PROMPT
# Syntax: read -p "prompt message" variable_name
# The -p option allows you to display a prompt on the same line

read -p "Enter your age: " age
echo "You are $age years old."

# READING MULTIPLE VALUES
# You can read multiple values in a single read command
# Values should be separated by spaces

read -p "Enter your first name and last name: " first_name last_name
echo "First name: $first_name"
echo "Last name: $last_name"

# SILENT INPUT (for passwords)
# Syntax: read -s variable_name
# The -s option hides the input (silent mode)

read -sp "Enter your password: " password
echo ""  # New line after password input
echo "Password saved (hidden)"

# READ WITH TIMEOUT
# Syntax: read -t seconds variable_name
# The -t option sets a timeout in seconds

echo "Quick! You have 5 seconds to enter your favorite color:"
if read -t 5 color; then
    echo "Your favorite color is $color"
else
    echo ""
    echo "Too slow! Timeout occurred."
fi

# READ WITH DEFAULT VALUE
# Syntax: read -e -i "default" variable_name
# The -e enables readline editing
# The -i sets initial/default text

read -p "Enter your country [USA]: " -e -i "USA" country
echo "Country: $country"

# READ ARRAY
# Reading multiple values into an array

echo "Enter 3 numbers separated by space:"
read -a numbers
echo "First number: ${numbers[0]}"
echo "Second number: ${numbers[1]}"
echo "Third number: ${numbers[2]}"

# READ ENTIRE LINE
# By default, read stops at whitespace
# To read an entire line including spaces, use IFS

echo "Enter a sentence:"
IFS= read -r sentence
echo "You entered: $sentence"

# READ FROM FILE
# You can read lines from a file using read in a loop
# This will be covered in more detail in intermediate/advanced sections
