#!/bin/bash

# COMPARISON OPERATORS IN SHELL SCRIPTING
# Used to compare values in conditional statements

# INTEGER COMPARISON OPERATORS (for numbers)
# These are used with [ ] or [[ ]] or (( ))

# Operator | Description
# ---------|-------------
# -eq      | Equal to
# -ne      | Not equal to
# -gt      | Greater than
# -ge      | Greater than or equal to
# -lt      | Less than
# -le      | Less than or equal to

a=10
b=20

echo "=== INTEGER COMPARISONS ==="
echo "a = $a, b = $b"

# Equal to
if [ $a -eq $b ]; then
    echo "$a is equal to $b"
else
    echo "$a is not equal to $b"
fi

# Not equal to
if [ $a -ne $b ]; then
    echo "$a is not equal to $b"
fi

# Greater than
if [ $b -gt $a ]; then
    echo "$b is greater than $a"
fi

# Greater than or equal to
if [ $b -ge $a ]; then
    echo "$b is greater than or equal to $a"
fi

# Less than
if [ $a -lt $b ]; then
    echo "$a is less than $b"
fi

# Less than or equal to
if [ $a -le $b ]; then
    echo "$a is less than or equal to $b"
fi

# ARITHMETIC COMPARISON (using (( )))
# In (( )), you can use familiar operators: ==, !=, <, >, <=, >=

echo ""
echo "=== ARITHMETIC STYLE COMPARISONS ==="

if (( a < b )); then
    echo "$a is less than $b (using (( )))"
fi

if (( a == 10 )); then
    echo "a equals 10"
fi

if (( a >= 5 && a <= 15 )); then
    echo "a is between 5 and 15"
fi

# STRING COMPARISON OPERATORS
# Used to compare strings

# Operator | Description
# ---------|-------------
# =        | Equal to (in [ ])
# ==       | Equal to (in [[ ]])
# !=       | Not equal to
# <        | Less than (lexicographically)
# >        | Greater than (lexicographically)
# -z       | String is empty (zero length)
# -n       | String is not empty

str1="hello"
str2="world"
str3="hello"
str4=""

echo ""
echo "=== STRING COMPARISONS ==="

# Equal to
if [ "$str1" = "$str3" ]; then
    echo "'$str1' is equal to '$str3'"
fi

# Equal to (with double brackets - recommended)
if [[ "$str1" == "$str3" ]]; then
    echo "'$str1' equals '$str3' (using [[ ]])"
fi

# Not equal to
if [ "$str1" != "$str2" ]; then
    echo "'$str1' is not equal to '$str2'"
fi

# Less than (lexicographically)
# Note: In [ ], < and > must be escaped with \
if [ "$str1" \< "$str2" ]; then
    echo "'$str1' comes before '$str2' alphabetically"
fi

# Greater than (lexicographically)
# In [[ ]], no need to escape
if [[ "$str2" > "$str1" ]]; then
    echo "'$str2' comes after '$str1' alphabetically"
fi

# Check if string is empty
if [ -z "$str4" ]; then
    echo "str4 is empty"
fi

# Check if string is not empty
if [ -n "$str1" ]; then
    echo "str1 is not empty"
fi

# Check if variable is set and not empty
name="John"
if [ -n "${name}" ]; then
    echo "Name is set: $name"
fi

# SINGLE [ ] vs DOUBLE [[ ]]
# [[ ]] is more modern and has some advantages:

echo ""
echo "=== SINGLE [ ] vs DOUBLE [[ ]] ==="

# 1. [[ ]] doesn't require quotes around variables
var="hello world"
if [[ $var == "hello world" ]]; then
    echo "Works without quotes in [[ ]]"
fi

# 2. [[ ]] supports pattern matching
if [[ $var == hello* ]]; then
    echo "Pattern matching works in [[ ]]"
fi

# 3. [[ ]] supports regex matching
if [[ $var =~ ^hello ]]; then
    echo "Regex matching works in [[ ]]"
fi

# 4. [[ ]] doesn't perform word splitting
# This is safer with variables containing spaces

# PRACTICAL EXAMPLES

echo ""
echo "=== PRACTICAL EXAMPLES ==="

# Check if a number is in a range
age=25
if [ $age -ge 18 ] && [ $age -le 65 ]; then
    echo "Age $age is in working age range"
fi

# Or using (( ))
if (( age >= 18 && age <= 65 )); then
    echo "Age $age is in working age range (using (( )))"
fi

# Validate user input
echo ""
read -p "Enter a number between 1 and 10: " number
if [[ $number =~ ^[0-9]+$ ]]; then
    if (( number >= 1 && number <= 10 )); then
        echo "Valid input: $number"
    else
        echo "Number out of range"
    fi
else
    echo "Invalid input: not a number"
fi

# Compare command output
current_user=$(whoami)
if [ "$current_user" = "root" ]; then
    echo "Running as root"
else
    echo "Running as $current_user"
fi
