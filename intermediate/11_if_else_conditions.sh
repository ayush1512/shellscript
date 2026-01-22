#!/bin/bash

# IF-ELSE CONDITIONAL STATEMENTS IN SHELL SCRIPTING
# Used to make decisions and execute code based on conditions

# IF STATEMENT
# Syntax:
# if [ condition ]; then
#     commands
# fi

echo "=== SIMPLE IF STATEMENT ==="

age=20

if [ $age -ge 18 ]; then
    echo "You are an adult"
fi

# IF-ELSE STATEMENT
# Syntax:
# if [ condition ]; then
#     commands
# else
#     commands
# fi

echo ""
echo "=== IF-ELSE STATEMENT ==="

number=15

if [ $number -gt 20 ]; then
    echo "Number is greater than 20"
else
    echo "Number is not greater than 20"
fi

# IF-ELIF-ELSE STATEMENT
# Syntax:
# if [ condition1 ]; then
#     commands
# elif [ condition2 ]; then
#     commands
# elif [ condition3 ]; then
#     commands
# else
#     commands
# fi

echo ""
echo "=== IF-ELIF-ELSE STATEMENT ==="

score=75

if [ $score -ge 90 ]; then
    echo "Grade: A"
elif [ $score -ge 80 ]; then
    echo "Grade: B"
elif [ $score -ge 70 ]; then
    echo "Grade: C"
elif [ $score -ge 60 ]; then
    echo "Grade: D"
else
    echo "Grade: F"
fi

# NESTED IF STATEMENTS
# You can nest if statements inside each other

echo ""
echo "=== NESTED IF STATEMENTS ==="

age=25
has_license=true

if [ $age -ge 18 ]; then
    echo "Age requirement met"
    if [ "$has_license" = true ]; then
        echo "You can drive"
    else
        echo "You need a license"
    fi
else
    echo "You are too young to drive"
fi

# DIFFERENT CONDITIONAL SYNTAXES

echo ""
echo "=== DIFFERENT SYNTAXES ==="

# Single brackets [ ]
if [ $age -gt 18 ]; then
    echo "Using [ ]: Age is greater than 18"
fi

# Double brackets [[ ]] (recommended - more features)
if [[ $age -gt 18 ]]; then
    echo "Using [[ ]]: Age is greater than 18"
fi

# Double parentheses (( )) for arithmetic
if (( age > 18 )); then
    echo "Using (( )): Age is greater than 18"
fi

# Test command (equivalent to [ ])
if test $age -gt 18; then
    echo "Using test: Age is greater than 18"
fi

# MULTIPLE CONDITIONS

echo ""
echo "=== MULTIPLE CONDITIONS ==="

username="admin"
password="secret"

# Using && (AND)
if [ "$username" = "admin" ] && [ "$password" = "secret" ]; then
    echo "Login successful (using &&)"
fi

# Using -a (AND) - older syntax
if [ "$username" = "admin" -a "$password" = "secret" ]; then
    echo "Login successful (using -a)"
fi

# Using || (OR)
if [ "$username" = "admin" ] || [ "$username" = "root" ]; then
    echo "Username is valid (using ||)"
fi

# Using -o (OR) - older syntax
if [ "$username" = "admin" -o "$username" = "root" ]; then
    echo "Username is valid (using -o)"
fi

# Using [[ ]] with && and ||
if [[ "$username" = "admin" && "$password" = "secret" ]]; then
    echo "Login successful (using [[ ]] with &&)"
fi

# NEGATION

echo ""
echo "=== NEGATION ==="

is_locked=false

# Using ! to negate
if [ ! "$is_locked" = true ]; then
    echo "Account is not locked"
fi

# Using != for not equal
if [ "$is_locked" != true ]; then
    echo "Account is not locked (using !=)"
fi

# FILE TEST CONDITIONS

echo ""
echo "=== FILE TEST CONDITIONS ==="

file="/etc/passwd"

# Check if file exists
if [ -f "$file" ]; then
    echo "File exists: $file"
fi

# Check if file is readable
if [ -r "$file" ]; then
    echo "File is readable"
fi

# Check if file is writable
if [ -w "$file" ]; then
    echo "File is writable"
else
    echo "File is not writable"
fi

# Check if file is executable
if [ -x "$0" ]; then
    echo "Script is executable"
fi

# Check if directory exists
if [ -d "/tmp" ]; then
    echo "Directory /tmp exists"
fi

# Check if file is not empty
if [ -s "$file" ]; then
    echo "File is not empty"
fi

# STRING CONDITIONS

echo ""
echo "=== STRING CONDITIONS ==="

str1="hello"
str2="world"
empty=""

# String equality
if [ "$str1" = "hello" ]; then
    echo "String equals 'hello'"
fi

# String inequality
if [ "$str1" != "$str2" ]; then
    echo "Strings are different"
fi

# String is empty
if [ -z "$empty" ]; then
    echo "String is empty"
fi

# String is not empty
if [ -n "$str1" ]; then
    echo "String is not empty"
fi

# Pattern matching (only with [[ ]])
if [[ "$str1" == h* ]]; then
    echo "String starts with 'h'"
fi

# ARITHMETIC CONDITIONS

echo ""
echo "=== ARITHMETIC CONDITIONS ==="

x=10
y=20

# Equal to
if [ $x -eq 10 ]; then
    echo "x equals 10"
fi

# Not equal to
if [ $x -ne $y ]; then
    echo "x is not equal to y"
fi

# Greater than
if [ $y -gt $x ]; then
    echo "y is greater than x"
fi

# Greater than or equal to
if [ $y -ge $x ]; then
    echo "y is greater than or equal to x"
fi

# Less than
if [ $x -lt $y ]; then
    echo "x is less than y"
fi

# Less than or equal to
if [ $x -le $y ]; then
    echo "x is less than or equal to y"
fi

# PRACTICAL EXAMPLES

echo ""
echo "=== PRACTICAL EXAMPLE 1: User Age Validation ==="

read -p "Enter your age: " user_age

if [[ ! "$user_age" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number"
elif [ $user_age -lt 0 ]; then
    echo "Error: Age cannot be negative"
elif [ $user_age -lt 13 ]; then
    echo "You are a child"
elif [ $user_age -lt 18 ]; then
    echo "You are a teenager"
elif [ $user_age -lt 65 ]; then
    echo "You are an adult"
else
    echo "You are a senior citizen"
fi

echo ""
echo "=== PRACTICAL EXAMPLE 2: File Backup Check ==="

backup_file="/tmp/backup.tar.gz"

if [ -f "$backup_file" ]; then
    # Check file age (in days)
    age_days=$(( ($(date +%s) - $(stat -c %Y "$backup_file")) / 86400 ))
    
    if [ $age_days -gt 7 ]; then
        echo "Backup is older than 7 days"
        echo "Consider creating a new backup"
    else
        echo "Backup is recent (${age_days} days old)"
    fi
else
    echo "No backup file found"
    echo "Creating backup..."
    # touch "$backup_file"
fi

echo ""
echo "=== PRACTICAL EXAMPLE 3: System Resource Check ==="

# Check disk usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $disk_usage -gt 90 ]; then
    echo "WARNING: Disk usage is critical (${disk_usage}%)"
elif [ $disk_usage -gt 75 ]; then
    echo "WARNING: Disk usage is high (${disk_usage}%)"
else
    echo "Disk usage is normal (${disk_usage}%)"
fi

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    echo "Running as root user"
else
    echo "Running as regular user: $(whoami)"
fi

# ONE-LINE IF STATEMENTS

echo ""
echo "=== ONE-LINE IF STATEMENTS ==="

# Using && and ||
[ $age -ge 18 ] && echo "Adult" || echo "Minor"

# Ternary-like expression
result=$([ $age -ge 18 ] && echo "Adult" || echo "Minor")
echo "Status: $result"

# COMPACT SYNTAX

echo ""
echo "=== COMPACT SYNTAX ==="

# If on one line (note the semicolon before then)
if [ $age -ge 18 ]; then echo "You can vote"; fi

# If-else on one line
if [ $age -ge 18 ]; then echo "Adult"; else echo "Minor"; fi

echo ""
echo "If-else statement tutorial complete!"
