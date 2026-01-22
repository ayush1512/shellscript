#!/bin/bash

# VARIABLES IN SHELL SCRIPTING
# Variables store data that can be used and manipulated throughout the script

# VARIABLE DECLARATION
# Syntax: variable_name=value
# Rules:
# - No spaces around the = sign
# - Variable names are case-sensitive
# - Can contain letters, numbers, and underscores
# - Cannot start with a number

name="John"              # String variable
age=25                   # Numeric variable
PI=3.14159              # Constant (by convention, use uppercase)
_temp="temporary"       # Valid: starts with underscore

# ACCESSING VARIABLES
# Syntax: $variable_name or ${variable_name}
# The ${} syntax is preferred when concatenating with other text

echo "Name: $name"
echo "Age: $age"
echo "PI value: $PI"

# Using curly braces for clarity
echo "Hello, ${name}!"
echo "Next year, age will be ${age}1"  # Without braces, this would try to access $age1

# TYPES OF VARIABLES

# 1. Local Variables (available only in current shell)
local_var="I am local"

# 2. Environment Variables (available to child processes)
export GLOBAL_VAR="I am global"

# 3. Built-in/Special Variables
echo "Script name: $0"           # Name of the script
echo "Process ID: $$"            # PID of current shell
echo "Home directory: $HOME"     # User's home directory
echo "Current user: $USER"       # Current username
echo "Current shell: $SHELL"     # Current shell
echo "Path: $PATH"              # System PATH

# VARIABLE OPERATIONS

# String concatenation
first_name="John"
last_name="Doe"
full_name="$first_name $last_name"
echo "Full name: $full_name"

# Command substitution (store command output in variable)
# Syntax: variable=$(command) or variable=`command`
current_date=$(date)
echo "Current date: $current_date"

current_dir=$(pwd)
echo "Current directory: $current_dir"

# Read-only variables (cannot be changed)
readonly CONSTANT="This cannot be changed"
echo "Constant: $CONSTANT"
# CONSTANT="New value"  # This would cause an error

# Unsetting variables (removing them)
temp_var="temporary"
echo "Before unset: $temp_var"
unset temp_var
echo "After unset: $temp_var"  # Will be empty

# Variable length
text="Hello World"
echo "Length of text: ${#text}"  # Outputs: 11
