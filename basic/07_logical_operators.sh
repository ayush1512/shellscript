#!/bin/bash

# LOGICAL OPERATORS IN SHELL SCRIPTING
# Used to combine multiple conditions

# LOGICAL OPERATORS
# && : Logical AND (both conditions must be true)
# || : Logical OR (at least one condition must be true)
# !  : Logical NOT (negates a condition)

# METHOD 1: Using && and || with [ ] or [[ ]]
# Syntax: [ condition1 ] && [ condition2 ]
# Syntax: [ condition1 ] || [ condition2 ]

a=10
b=20
c=30

echo "=== LOGICAL AND (&&) ==="
echo "a = $a, b = $b, c = $c"

# AND operator - both conditions must be true
if [ $a -lt $b ] && [ $b -lt $c ]; then
    echo "$a < $b < $c (both conditions are true)"
fi

# Can also write it as:
if [ $a -lt $b -a $b -lt $c ]; then
    echo "Using -a: $a < $b < $c"
fi

# With double brackets (recommended)
if [[ $a -lt $b && $b -lt $c ]]; then
    echo "Using [[ ]]: $a < $b < $c"
fi

echo ""
echo "=== LOGICAL OR (||) ==="

# OR operator - at least one condition must be true
if [ $a -gt 100 ] || [ $b -eq 20 ]; then
    echo "At least one condition is true"
fi

# Can also write it as:
if [ $a -gt 100 -o $b -eq 20 ]; then
    echo "Using -o: At least one condition is true"
fi

# With double brackets (recommended)
if [[ $a -gt 100 || $b -eq 20 ]]; then
    echo "Using [[ ]]: At least one condition is true"
fi

echo ""
echo "=== LOGICAL NOT (!) ==="

# NOT operator - negates a condition
if [ ! $a -eq 100 ]; then
    echo "$a is not equal to 100"
fi

# With double brackets
if [[ ! $a -eq 100 ]]; then
    echo "Using [[ ]]: $a is not equal to 100"
fi

# COMBINING MULTIPLE LOGICAL OPERATORS

echo ""
echo "=== COMPLEX CONDITIONS ==="

age=25
country="USA"

# Complex condition with AND and OR
if [[ $age -ge 18 && $age -le 65 ]] && [[ $country == "USA" || $country == "Canada" ]]; then
    echo "Eligible: Age $age in $country"
fi

# Using parentheses for grouping
score=85
attendance=90

if [[ ($score -ge 80 && $attendance -ge 85) || $score -ge 95 ]]; then
    echo "Passed: Score=$score, Attendance=$attendance"
fi

# METHOD 2: Using && and || as command separators
# These work at the command level, not just in tests

echo ""
echo "=== COMMAND LEVEL OPERATORS ==="

# && : Execute second command only if first succeeds
mkdir /tmp/test_dir 2>/dev/null && echo "Directory created successfully"

# || : Execute second command only if first fails
mkdir /tmp/test_dir 2>/dev/null || echo "Directory already exists or creation failed"

# Chaining commands
cd /tmp && ls -la && echo "Listed /tmp directory"

# Using both && and ||
# Syntax: command1 && command2 || command3
# If command1 succeeds, run command2; if command1 fails, run command3
grep "root" /etc/passwd > /dev/null && echo "Root user found" || echo "Root user not found"

# METHOD 3: Using (( )) for arithmetic conditions
# In (( )), you can use C-style operators: &&, ||, !

echo ""
echo "=== ARITHMETIC LOGICAL OPERATORS ==="

x=5
y=10
z=15

if (( x < y && y < z )); then
    echo "x < y < z is true"
fi

if (( x > 20 || y == 10 )); then
    echo "At least one condition is true"
fi

if (( !(x > 10) )); then
    echo "x is not greater than 10"
fi

# PRACTICAL EXAMPLES

echo ""
echo "=== PRACTICAL EXAMPLES ==="

# Example 1: Validate user input
read -p "Enter your age: " user_age

if [[ $user_age =~ ^[0-9]+$ ]] && (( user_age > 0 && user_age < 150 )); then
    echo "Valid age: $user_age"
    
    if (( user_age >= 18 )); then
        echo "You are an adult"
    elif (( user_age >= 13 )); then
        echo "You are a teenager"
    else
        echo "You are a child"
    fi
else
    echo "Invalid age input"
fi

# Example 2: Check file permissions
file="$0"  # Current script
if [ -r "$file" ] && [ -w "$file" ]; then
    echo "File $file is readable and writable"
fi

# Example 3: Multiple condition check
username="admin"
password="secret123"

read -p "Enter username: " input_user
read -sp "Enter password: " input_pass
echo ""

if [[ $input_user == $username && $input_pass == $password ]]; then
    echo "Login successful"
elif [[ $input_user != $username ]]; then
    echo "Invalid username"
else
    echo "Invalid password"
fi

# Example 4: Short-circuit evaluation
# With &&, if first condition is false, second is not evaluated
# With ||, if first condition is true, second is not evaluated

counter=0
echo ""
echo "Short-circuit demonstration:"

# This will not increment counter because first condition is false
[ $a -gt 100 ] && ((counter++))
echo "Counter after false && : $counter"

# This will increment counter because first condition is true
[ $a -lt 100 ] && ((counter++))
echo "Counter after true && : $counter"

# This will not increment counter because first condition is true
[ $a -lt 100 ] || ((counter++))
echo "Counter after true || : $counter"

# This will increment counter because first condition is false
[ $a -gt 100 ] || ((counter++))
echo "Counter after false || : $counter"
