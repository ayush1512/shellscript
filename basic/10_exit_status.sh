#!/bin/bash

# EXIT STATUS IN SHELL SCRIPTING
# Every command returns an exit status (exit code)
# 0 = Success, Non-zero = Failure/Error

# EXIT STATUS BASICS

# $? - Contains the exit status of the last executed command
echo "Hello World"
echo "Exit status of echo: $?"

# Successful command returns 0
ls /tmp > /dev/null
echo "Exit status of successful ls: $?"

# Failed command returns non-zero
ls /nonexistent_directory 2> /dev/null
echo "Exit status of failed ls: $?"

# COMMON EXIT CODES
# 0   - Success
# 1   - General errors
# 2   - Misuse of shell command
# 126 - Command cannot execute
# 127 - Command not found
# 128 - Invalid exit argument
# 130 - Script terminated by Ctrl+C

echo ""
echo "=== TESTING EXIT STATUS ==="

# Test if command succeeded
if ls /tmp > /dev/null 2>&1; then
    echo "Command succeeded"
fi

# Test if command failed
if ! ls /nonexistent 2> /dev/null; then
    echo "Command failed"
fi

# Using exit status in conditions
grep "root" /etc/passwd > /dev/null
if [ $? -eq 0 ]; then
    echo "Found 'root' in /etc/passwd"
else
    echo "Did not find 'root' in /etc/passwd"
fi

# SETTING EXIT STATUS
# Use 'exit' command to set script exit status
# Syntax: exit [n] where n is 0-255

echo ""
echo "=== SETTING EXIT STATUS ==="

# Function that returns exit status
function check_positive() {
    if [ $1 -gt 0 ]; then
        return 0  # Success
    else
        return 1  # Failure
    fi
}

# Call function and check its return value
check_positive 5
if [ $? -eq 0 ]; then
    echo "Number is positive"
fi

check_positive -3
if [ $? -eq 0 ]; then
    echo "Number is positive"
else
    echo "Number is not positive"
fi

# USING EXIT STATUS IN CONDITIONALS

echo ""
echo "=== CONDITIONAL EXECUTION ==="

# && operator: Execute second command only if first succeeds
echo "Testing && operator:"
ls /tmp > /dev/null && echo "Directory exists"

# || operator: Execute second command only if first fails
echo "Testing || operator:"
ls /nonexistent 2> /dev/null || echo "Directory does not exist"

# Combining && and ||
mkdir /tmp/test_exit 2> /dev/null && echo "Created directory" || echo "Directory already exists"

# Cleanup
rmdir /tmp/test_exit 2> /dev/null

# CHECKING MULTIPLE CONDITIONS

echo ""
echo "=== MULTIPLE CONDITIONS ==="

# All commands must succeed
if command1=$(echo "step1") && command2=$(echo "step2") && command3=$(echo "step3"); then
    echo "All steps completed successfully"
fi

# Any command can succeed
grep "root" /etc/passwd > /dev/null || grep "admin" /etc/passwd > /dev/null
if [ $? -eq 0 ]; then
    echo "Found at least one user"
fi

# PRACTICAL EXAMPLES

echo ""
echo "=== PRACTICAL EXAMPLE 1: File Validation ==="

function validate_file() {
    local file=$1
    
    # Check if file exists
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' does not exist"
        return 1
    fi
    
    # Check if file is readable
    if [ ! -r "$file" ]; then
        echo "Error: File '$file' is not readable"
        return 2
    fi
    
    # Check if file is not empty
    if [ ! -s "$file" ]; then
        echo "Error: File '$file' is empty"
        return 3
    fi
    
    echo "File '$file' is valid"
    return 0
}

# Test the function
validate_file "/etc/passwd"
status=$?
echo "Validation exit status: $status"

validate_file "/nonexistent"
status=$?
echo "Validation exit status: $status"

echo ""
echo "=== PRACTICAL EXAMPLE 2: Error Handling ==="

function safe_divide() {
    local num1=$1
    local num2=$2
    
    # Check if arguments are provided
    if [ $# -lt 2 ]; then
        echo "Error: Two arguments required"
        return 1
    fi
    
    # Check if arguments are numbers
    if ! [[ "$num1" =~ ^[0-9]+$ ]] || ! [[ "$num2" =~ ^[0-9]+$ ]]; then
        echo "Error: Arguments must be numbers"
        return 2
    fi
    
    # Check for division by zero
    if [ $num2 -eq 0 ]; then
        echo "Error: Division by zero"
        return 3
    fi
    
    # Perform division
    result=$((num1 / num2))
    echo "Result: $result"
    return 0
}

# Test with valid input
safe_divide 10 2
echo "Exit status: $?"

# Test with division by zero
safe_divide 10 0
echo "Exit status: $?"

# Test with invalid input
safe_divide 10 abc
echo "Exit status: $?"

echo ""
echo "=== PRACTICAL EXAMPLE 3: Command Chain ==="

# Create a series of commands that depend on previous success
function deploy_app() {
    echo "Starting deployment..."
    
    # Step 1: Check dependencies
    command -v git > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Error: git is not installed"
        return 1
    fi
    
    # Step 2: Run tests (simulated)
    echo "Running tests..."
    test_result=0  # Simulated success
    if [ $test_result -ne 0 ]; then
        echo "Error: Tests failed"
        return 2
    fi
    
    # Step 3: Build (simulated)
    echo "Building application..."
    build_result=0  # Simulated success
    if [ $build_result -ne 0 ]; then
        echo "Error: Build failed"
        return 3
    fi
    
    echo "Deployment successful!"
    return 0
}

deploy_app
deployment_status=$?

if [ $deployment_status -eq 0 ]; then
    echo "Deployment completed successfully"
else
    echo "Deployment failed with exit code: $deployment_status"
fi

# TRAP AND EXIT
# trap command can execute code when script exits

echo ""
echo "=== TRAP ON EXIT ==="

# Set up cleanup function
function cleanup() {
    echo "Cleaning up before exit..."
    # Remove temporary files, close connections, etc.
}

# Register cleanup function to run on exit
trap cleanup EXIT

# Script continues normally...
echo "Script is running..."

# EXIT BEST PRACTICES

echo ""
echo "=== EXIT STATUS BEST PRACTICES ==="

: '
1. Always return 0 for success
2. Use non-zero values for different error types
3. Document your exit codes
4. Check exit status of critical commands
5. Use meaningful exit codes (1-255)
6. Common convention:
   - 0: Success
   - 1: General error
   - 2: Misuse of command
   - Other: Specific error codes
'

# EXPLICIT EXIT
# Note: This would end the script, so it's commented for tutorial

: '
# Exit with success
exit 0

# Exit with error
exit 1

# Exit with custom error code
exit 42
'

echo ""
echo "Script completed successfully"
echo "Final exit status will be: 0"

# When script ends naturally, exit status is 0
# Or the status of the last executed command
