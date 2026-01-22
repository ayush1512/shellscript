#!/bin/bash

# COMMAND LINE ARGUMENTS IN SHELL SCRIPTING
# Arguments are values passed to a script when it's executed
# Syntax: ./script.sh arg1 arg2 arg3 ...

# SPECIAL VARIABLES FOR ARGUMENTS

# $0 - Script name
echo "Script name: $0"

# $1, $2, $3, ... - Individual arguments
echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"

# $# - Number of arguments
echo "Number of arguments: $#"

# $@ - All arguments as separate words
echo "All arguments (\$@): $@"

# $* - All arguments as a single string
echo "All arguments (\$*): $*"

# CHECKING IF ARGUMENTS ARE PROVIDED

echo ""
echo "=== CHECKING ARGUMENTS ==="

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "Usage: $0 <arg1> <arg2> ..."
    exit 1
fi

# Check specific argument
if [ -z "$1" ]; then
    echo "First argument is empty"
else
    echo "First argument is: $1"
fi

# ITERATING THROUGH ARGUMENTS

echo ""
echo "=== ITERATING THROUGH ARGUMENTS ==="

# Method 1: Using $@
echo "Using \$@:"
for arg in "$@"; do
    echo "  Argument: $arg"
done

# Method 2: Using $*
echo "Using \$*:"
for arg in "$*"; do
    echo "  All arguments as one: $arg"
done

# Method 3: Using array indexing
echo "Using array indexing:"
for (( i=1; i<=$#; i++ )); do
    echo "  Argument $i: ${!i}"
done

# SHIFTING ARGUMENTS
# shift command moves arguments left, removing $1

echo ""
echo "=== SHIFTING ARGUMENTS ==="
echo "Before shift: \$1=$1, \$2=$2, \$3=$3"
shift
echo "After shift 1: \$1=$1, \$2=$2, \$3=$3"
shift 2
echo "After shift 2: \$1=$1, \$2=$2, \$3=$3"

# Note: Original arguments are restored when script reruns
# This demonstration would need actual arguments to show changes

# PROCESSING ARGUMENTS WITH OPTIONS

echo ""
echo "=== PROCESSING OPTIONS ==="

# Example of processing flags/options
# Usage: ./script.sh -a -b value -c

# Reset OPTIND for demonstration
OPTIND=1

# Note: getopts would need actual arguments to parse
# This is just showing the syntax
: '
while getopts ":a:b:c:" opt; do
    case $opt in
        a)
            echo "Option -a with value: $OPTARG"
            ;;
        b)
            echo "Option -b with value: $OPTARG"
            ;;
        c)
            echo "Option -c with value: $OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument"
            exit 1
            ;;
    esac
done

# Shift past the options
shift $((OPTIND-1))
'

# DEFAULT VALUES FOR ARGUMENTS

echo ""
echo "=== DEFAULT VALUES ==="

# Set default if argument not provided
arg1=${1:-"default_value"}
arg2=${2:-"another_default"}

echo "arg1 (with default): $arg1"
echo "arg2 (with default): $arg2"

# VALIDATING ARGUMENTS

echo ""
echo "=== VALIDATING ARGUMENTS ==="

# Check minimum number of arguments
MIN_ARGS=1
if [ $# -lt $MIN_ARGS ]; then
    echo "Error: At least $MIN_ARGS argument(s) required"
    echo "Usage: $0 <arg1> [arg2] [arg3]"
    exit 1
fi

# Check maximum number of arguments
MAX_ARGS=5
if [ $# -gt $MAX_ARGS ]; then
    echo "Error: Too many arguments (max: $MAX_ARGS)"
    exit 1
fi

# Validate argument type (numeric)
if [ -n "$1" ]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "$1 is a valid number"
    else
        echo "$1 is not a number"
    fi
fi

# PRACTICAL EXAMPLES

echo ""
echo "=== PRACTICAL EXAMPLES ==="

# Example 1: Simple calculator
# Usage: ./script.sh 5 + 3
if [ $# -ge 3 ]; then
    num1=$1
    operator=$2
    num2=$3
    
    case $operator in
        +)
            result=$((num1 + num2))
            echo "$num1 + $num2 = $result"
            ;;
        -)
            result=$((num1 - num2))
            echo "$num1 - $num2 = $result"
            ;;
        *)
            result=$((num1 * num2))
            echo "$num1 * $num2 = $result"
            ;;
        /)
            if [ $num2 -eq 0 ]; then
                echo "Error: Division by zero"
            else
                result=$((num1 / num2))
                echo "$num1 / $num2 = $result"
            fi
            ;;
        *)
            echo "Unknown operator: $operator"
            ;;
    esac
fi

# Example 2: File operation based on arguments
# Usage: ./script.sh create filename.txt
if [ $# -ge 2 ]; then
    action=$1
    filename=$2
    
    case $action in
        create)
            touch "$filename" 2>/dev/null && echo "Created: $filename" || echo "Failed to create: $filename"
            ;;
        delete)
            rm "$filename" 2>/dev/null && echo "Deleted: $filename" || echo "Failed to delete: $filename"
            ;;
        show)
            [ -f "$filename" ] && cat "$filename" || echo "File not found: $filename"
            ;;
        *)
            echo "Unknown action: $action"
            echo "Available actions: create, delete, show"
            ;;
    esac
fi

# ACCESSING ARGUMENTS IN FUNCTIONS

function show_function_args() {
    echo ""
    echo "=== FUNCTION ARGUMENTS ==="
    echo "Function name: $0"
    echo "Function arg 1: $1"
    echo "Function arg 2: $2"
    echo "Number of function args: $#"
}

# Call function with arguments
show_function_args "first" "second" "third"

# QUOTED vs UNQUOTED $@ and $*

echo ""
echo "=== QUOTED vs UNQUOTED ==="

# "$@" - Each argument as separate quoted string (preserves spaces)
# "$*" - All arguments as single quoted string (joins with space)
# $@ - Each argument as separate unquoted string (word splitting)
# $* - All arguments as separate unquoted strings (word splitting)

# To see the difference, you'd need to pass arguments with spaces
# Example: ./script.sh "arg with spaces" "another arg"

echo "Total arguments provided: $#"
echo ""
echo "Script demonstration complete!"
echo "Try running: $0 arg1 arg2 arg3 to see arguments in action"
