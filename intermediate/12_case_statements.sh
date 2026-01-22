#!/bin/bash

# CASE STATEMENTS IN SHELL SCRIPTING
# Case statements provide a cleaner way to handle multiple conditions
# Similar to switch-case in other languages

# BASIC CASE STATEMENT
# Syntax:
# case $variable in
#     pattern1)
#         commands
#         ;;
#     pattern2)
#         commands
#         ;;
#     *)
#         default commands
#         ;;
# esac

echo "=== BASIC CASE STATEMENT ==="

read -p "Enter a color (red/green/blue): " color

case $color in
    red)
        echo "You selected red"
        ;;
    green)
        echo "You selected green"
        ;;
    blue)
        echo "You selected blue"
        ;;
    *)
        echo "Unknown color"
        ;;
esac

# CASE WITH MULTIPLE PATTERNS
# Use | to match multiple patterns

echo ""
echo "=== MULTIPLE PATTERNS ==="

read -p "Enter a day (mon/tue/wed/...): " day

case $day in
    mon|Mon|MON|monday|Monday)
        echo "It's Monday - Start of the work week"
        ;;
    tue|Tue|TUE|tuesday|Tuesday)
        echo "It's Tuesday"
        ;;
    wed|Wed|WED|wednesday|Wednesday)
        echo "It's Wednesday - Mid week"
        ;;
    thu|Thu|THU|thursday|Thursday)
        echo "It's Thursday"
        ;;
    fri|Fri|FRI|friday|Friday)
        echo "It's Friday - Almost weekend!"
        ;;
    sat|Sat|SAT|saturday|Saturday|sun|Sun|SUN|sunday|Sunday)
        echo "It's the weekend!"
        ;;
    *)
        echo "Invalid day"
        ;;
esac

# CASE WITH PATTERNS (WILDCARDS)
# * matches any characters
# ? matches single character
# [abc] matches a, b, or c
# [a-z] matches any lowercase letter

echo ""
echo "=== PATTERN MATCHING ==="

read -p "Enter a filename: " filename

case $filename in
    *.txt)
        echo "This is a text file"
        ;;
    *.sh)
        echo "This is a shell script"
        ;;
    *.py)
        echo "This is a Python script"
        ;;
    *.jpg|*.png|*.gif)
        echo "This is an image file"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac

# CASE WITH COMMAND LINE OPTIONS

echo ""
echo "=== COMMAND LINE OPTIONS ==="

# Simulate command line argument
option=${1:-"-h"}

case $option in
    -h|--help)
        echo "Help: Display this help message"
        echo "Usage: $0 [option]"
        echo "Options:"
        echo "  -h, --help     Show help"
        echo "  -v, --version  Show version"
        echo "  -d, --debug    Enable debug mode"
        ;;
    -v|--version)
        echo "Version 1.0.0"
        ;;
    -d|--debug)
        echo "Debug mode enabled"
        set -x  # Enable debug mode
        ;;
    -*)
        echo "Error: Unknown option $option"
        echo "Use -h or --help for usage information"
        exit 1
        ;;
    *)
        echo "Processing file: $option"
        ;;
esac

# CASE WITH RANGES

echo ""
echo "=== NUMBER RANGES ==="

read -p "Enter a number (0-9): " number

case $number in
    [0-2])
        echo "Number is between 0 and 2"
        ;;
    [3-5])
        echo "Number is between 3 and 5"
        ;;
    [6-9])
        echo "Number is between 6 and 9"
        ;;
    *)
        echo "Number is out of range"
        ;;
esac

# NESTED CASE STATEMENTS

echo ""
echo "=== NESTED CASE STATEMENTS ==="

read -p "Enter category (fruit/vegetable): " category
read -p "Enter item name: " item

case $category in
    fruit)
        echo "You selected a fruit"
        case $item in
            apple|orange|banana)
                echo "$item is a common fruit"
                ;;
            mango|papaya)
                echo "$item is a tropical fruit"
                ;;
            *)
                echo "$item is some other fruit"
                ;;
        esac
        ;;
    vegetable)
        echo "You selected a vegetable"
        case $item in
            potato|tomato|onion)
                echo "$item is a common vegetable"
                ;;
            broccoli|cauliflower)
                echo "$item is a cruciferous vegetable"
                ;;
            *)
                echo "$item is some other vegetable"
                ;;
        esac
        ;;
    *)
        echo "Unknown category"
        ;;
esac

# CASE WITH FUNCTIONS

echo ""
echo "=== CASE IN FUNCTIONS ==="

function process_command() {
    local cmd=$1
    
    case $cmd in
        start)
            echo "Starting service..."
            return 0
            ;;
        stop)
            echo "Stopping service..."
            return 0
            ;;
        restart)
            echo "Restarting service..."
            return 0
            ;;
        status)
            echo "Checking status..."
            return 0
            ;;
        *)
            echo "Unknown command: $cmd"
            return 1
            ;;
    esac
}

process_command "start"
process_command "invalid"

# CASE WITHOUT BREAK (FALLTHROUGH)
# In bash, each pattern ends with ;;
# But you can use ;& for fallthrough to next pattern
# Or ;;& to test remaining patterns

echo ""
echo "=== FALLTHROUGH EXAMPLES ==="

number=2

case $number in
    1)
        echo "One"
        ;;
    2)
        echo "Two"
        ;&  # Fallthrough to next pattern
    3)
        echo "Two or Three"
        ;;
esac

# PRACTICAL EXAMPLE 1: MENU SYSTEM

echo ""
echo "=== PRACTICAL EXAMPLE: MENU SYSTEM ==="

function show_menu() {
    echo "==== Main Menu ===="
    echo "1. Create file"
    echo "2. Delete file"
    echo "3. List files"
    echo "4. Exit"
    read -p "Select an option: " choice
    
    case $choice in
        1)
            read -p "Enter filename: " fname
            touch "/tmp/$fname" 2>/dev/null && echo "Created: $fname" || echo "Failed to create"
            ;;
        2)
            read -p "Enter filename to delete: " fname
            rm "/tmp/$fname" 2>/dev/null && echo "Deleted: $fname" || echo "Failed to delete"
            ;;
        3)
            echo "Files in /tmp:"
            ls -lh /tmp | head -10
            ;;
        4)
            echo "Exiting..."
            return 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

show_menu

# PRACTICAL EXAMPLE 2: FILE TYPE PROCESSOR

echo ""
echo "=== PRACTICAL EXAMPLE: FILE TYPE PROCESSOR ==="

function process_file() {
    local file=$1
    
    # Check if file exists
    if [ ! -f "$file" ]; then
        echo "File does not exist: $file"
        return 1
    fi
    
    # Get file extension
    extension="${file##*.}"
    
    case $extension in
        txt|text)
            echo "Processing text file..."
            wc -l "$file"
            ;;
        log)
            echo "Processing log file..."
            tail -10 "$file"
            ;;
        sh|bash)
            echo "Processing shell script..."
            bash -n "$file" && echo "Syntax OK" || echo "Syntax Error"
            ;;
        tar|gz|zip)
            echo "Processing archive..."
            ls -lh "$file"
            ;;
        *)
            echo "Unknown file type: $extension"
            ;;
    esac
}

# Test with current script
process_file "$0"

# PRACTICAL EXAMPLE 3: SIMPLE CALCULATOR

echo ""
echo "=== PRACTICAL EXAMPLE: CALCULATOR ==="

function calculator() {
    local num1=$1
    local operator=$2
    local num2=$3
    
    case $operator in
        +|add)
            echo "$num1 + $num2 = $((num1 + num2))"
            ;;
        -|sub|subtract)
            echo "$num1 - $num2 = $((num1 - num2))"
            ;;
        *|mul|multiply)
            echo "$num1 * $num2 = $((num1 * num2))"
            ;;
        /|div|divide)
            if [ $num2 -eq 0 ]; then
                echo "Error: Division by zero"
            else
                echo "$num1 / $num2 = $((num1 / num2))"
            fi
            ;;
        %|mod|modulus)
            echo "$num1 % $num2 = $((num1 % num2))"
            ;;
        *)
            echo "Unknown operator: $operator"
            echo "Supported: +, -, *, /, %"
            ;;
    esac
}

calculator 10 + 5
calculator 20 / 4
calculator 15 % 7

# CASE VS IF-ELIF-ELSE
# Use CASE when:
# - Matching a single variable against multiple patterns
# - Pattern matching is needed
# - Code readability is important
# Use IF-ELIF-ELSE when:
# - Multiple different conditions need to be tested
# - Complex boolean logic is required
# - Comparing different variables

echo ""
echo "Case statement tutorial complete!"
