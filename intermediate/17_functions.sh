#!/bin/bash

# FUNCTIONS IN SHELL SCRIPTING
# Functions are reusable blocks of code that perform specific tasks
# Help organize code and avoid repetition

# BASIC FUNCTION DECLARATION
# Syntax 1: function function_name { commands; }
# Syntax 2: function_name() { commands; }

echo "=== BASIC FUNCTION ==="

# Method 1: Using 'function' keyword
function greet {
    echo "Hello from function!"
}

# Method 2: Using parentheses (more common)
goodbye() {
    echo "Goodbye from function!"
}

# Calling functions
greet
goodbye

# FUNCTIONS WITH PARAMETERS
# Functions can accept arguments
# $1, $2, $3, ... are parameters inside function
# $@ and $* represent all parameters
# $# is the number of parameters

echo ""
echo "=== FUNCTIONS WITH PARAMETERS ==="

greet_person() {
    echo "Hello, $1!"
}

greet_person "John"
greet_person "Alice"

# Multiple parameters
add_numbers() {
    local num1=$1
    local num2=$2
    local sum=$((num1 + num2))
    echo "$num1 + $num2 = $sum"
}

add_numbers 5 3
add_numbers 10 20

# RETURN VALUES
# Functions can return exit status (0-255)
# Use 'return' to set exit status
# Use echo/printf to output values (not return)

echo ""
echo "=== RETURN VALUES ==="

is_even() {
    local number=$1
    if [ $((number % 2)) -eq 0 ]; then
        return 0  # Success (true)
    else
        return 1  # Failure (false)
    fi
}

# Check return value
is_even 4
if [ $? -eq 0 ]; then
    echo "4 is even"
fi

is_even 7
if [ $? -eq 0 ]; then
    echo "7 is even"
else
    echo "7 is odd"
fi

# RETURNING OUTPUT
# To return actual values, use echo and command substitution

echo ""
echo "=== RETURNING OUTPUT ==="

multiply() {
    local result=$(($1 * $2))
    echo $result
}

# Capture output
product=$(multiply 6 7)
echo "6 * 7 = $product"

# FUNCTIONS WITH DEFAULT PARAMETERS

echo ""
echo "=== DEFAULT PARAMETERS ==="

greet_with_default() {
    local name=${1:-"Guest"}
    local greeting=${2:-"Hello"}
    echo "$greeting, $name!"
}

greet_with_default "John" "Hi"
greet_with_default "Alice"
greet_with_default

# VARIABLE NUMBER OF ARGUMENTS

echo ""
echo "=== VARIABLE ARGUMENTS ==="

print_all() {
    echo "Number of arguments: $#"
    echo "All arguments: $@"
    
    local count=1
    for arg in "$@"; do
        echo "  Argument $count: $arg"
        ((count++))
    done
}

print_all apple banana orange
print_all one two three four five

# LOCAL VARIABLES IN FUNCTIONS
# Use 'local' keyword to create function-scoped variables

echo ""
echo "=== LOCAL VARIABLES ==="

global_var="I am global"

test_scope() {
    local local_var="I am local"
    global_var="Modified global"
    
    echo "Inside function:"
    echo "  Local: $local_var"
    echo "  Global: $global_var"
}

echo "Before function:"
echo "  Global: $global_var"
# echo "  Local: $local_var"  # This would be empty

test_scope

echo "After function:"
echo "  Global: $global_var"
# echo "  Local: $local_var"  # This would be empty

# RECURSIVE FUNCTIONS

echo ""
echo "=== RECURSIVE FUNCTIONS ==="

# Calculate factorial
factorial() {
    local n=$1
    
    if [ $n -le 1 ]; then
        echo 1
    else
        local prev=$(factorial $((n - 1)))
        echo $((n * prev))
    fi
}

result=$(factorial 5)
echo "Factorial of 5: $result"

# Calculate Fibonacci
fibonacci() {
    local n=$1
    
    if [ $n -le 1 ]; then
        echo $n
    else
        local a=$(fibonacci $((n - 1)))
        local b=$(fibonacci $((n - 2)))
        echo $((a + b))
    fi
}

echo "Fibonacci sequence (first 10):"
for i in {0..9}; do
    echo -n "$(fibonacci $i) "
done
echo ""

# FUNCTION OVERRIDING
# Functions can be redefined

echo ""
echo "=== FUNCTION OVERRIDING ==="

say_hello() {
    echo "Version 1: Hello"
}

say_hello

# Redefine function
say_hello() {
    echo "Version 2: Hi there!"
}

say_hello

# FUNCTIONS CALLING OTHER FUNCTIONS

echo ""
echo "=== FUNCTIONS CALLING FUNCTIONS ==="

validate_input() {
    local input=$1
    if [[ ! "$input" =~ ^[0-9]+$ ]]; then
        return 1
    fi
    return 0
}

process_number() {
    local num=$1
    
    if validate_input "$num"; then
        echo "Processing: $num"
        echo "Square: $((num * num))"
    else
        echo "Error: Invalid input '$num'"
    fi
}

process_number 5
process_number "abc"

# PRACTICAL EXAMPLE 1: STRING UTILITIES

echo ""
echo "=== PRACTICAL EXAMPLE 1: STRING UTILITIES ==="

to_uppercase() {
    echo "${1^^}"
}

to_lowercase() {
    echo "${1,,}"
}

string_length() {
    echo "${#1}"
}

text="Hello World"
echo "Original: $text"
echo "Uppercase: $(to_uppercase "$text")"
echo "Lowercase: $(to_lowercase "$text")"
echo "Length: $(string_length "$text")"

# PRACTICAL EXAMPLE 2: FILE UTILITIES

echo ""
echo "=== PRACTICAL EXAMPLE 2: FILE UTILITIES ==="

file_exists() {
    [ -f "$1" ]
}

file_size() {
    if file_exists "$1"; then
        stat -c%s "$1"
    else
        echo "0"
    fi
}

file_info() {
    local file=$1
    
    if file_exists "$file"; then
        echo "File: $file"
        echo "  Size: $(file_size "$file") bytes"
        echo "  Type: $(file -b "$file")"
    else
        echo "File does not exist: $file"
    fi
}

file_info "/etc/passwd"

# PRACTICAL EXAMPLE 3: MATH UTILITIES

echo ""
echo "=== PRACTICAL EXAMPLE 3: MATH UTILITIES ==="

is_prime() {
    local n=$1
    
    if [ $n -lt 2 ]; then
        return 1
    fi
    
    for ((i=2; i*i<=n; i++)); do
        if [ $((n % i)) -eq 0 ]; then
            return 1
        fi
    done
    
    return 0
}

gcd() {
    local a=$1
    local b=$2
    
    while [ $b -ne 0 ]; do
        local temp=$b
        b=$((a % b))
        a=$temp
    done
    
    echo $a
}

echo "Prime numbers from 1 to 20:"
for i in {1..20}; do
    if is_prime $i; then
        echo -n "$i "
    fi
done
echo ""

echo "GCD of 48 and 18: $(gcd 48 18)"

# PRACTICAL EXAMPLE 4: VALIDATION FUNCTIONS

echo ""
echo "=== PRACTICAL EXAMPLE 4: VALIDATION ==="

is_valid_email() {
    local email=$1
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    fi
    return 1
}

is_valid_ip() {
    local ip=$1
    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        return 0
    fi
    return 1
}

validate_input_data() {
    local email=$1
    local ip=$2
    
    echo "Validating email: $email"
    if is_valid_email "$email"; then
        echo "  ✓ Valid email"
    else
        echo "  ✗ Invalid email"
    fi
    
    echo "Validating IP: $ip"
    if is_valid_ip "$ip"; then
        echo "  ✓ Valid IP"
    else
        echo "  ✗ Invalid IP"
    fi
}

validate_input_data "user@example.com" "192.168.1.1"
validate_input_data "invalid-email" "999.999.999.999"

# PRACTICAL EXAMPLE 5: ERROR HANDLING

echo ""
echo "=== PRACTICAL EXAMPLE 5: ERROR HANDLING ==="

log_error() {
    echo "ERROR: $1" >&2
}

log_warning() {
    echo "WARNING: $1" >&2
}

log_info() {
    echo "INFO: $1"
}

divide() {
    local numerator=$1
    local denominator=$2
    
    if [ $# -lt 2 ]; then
        log_error "Insufficient arguments"
        return 1
    fi
    
    if ! [[ "$numerator" =~ ^[0-9]+$ ]] || ! [[ "$denominator" =~ ^[0-9]+$ ]]; then
        log_error "Arguments must be numbers"
        return 2
    fi
    
    if [ $denominator -eq 0 ]; then
        log_error "Division by zero"
        return 3
    fi
    
    log_info "Calculating $numerator / $denominator"
    echo $((numerator / denominator))
    return 0
}

result=$(divide 10 2)
echo "Result: $result"

divide 10 0

# PRACTICAL EXAMPLE 6: MENU SYSTEM

echo ""
echo "=== PRACTICAL EXAMPLE 6: MENU SYSTEM ==="

display_menu() {
    echo "========== Menu =========="
    echo "1. Show date"
    echo "2. Show time"
    echo "3. Show user"
    echo "4. Exit"
    echo "========================="
}

handle_choice() {
    local choice=$1
    
    case $choice in
        1)
            echo "Date: $(date +%Y-%m-%d)"
            ;;
        2)
            echo "Time: $(date +%H:%M:%S)"
            ;;
        3)
            echo "User: $(whoami)"
            ;;
        4)
            echo "Goodbye!"
            return 1
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
    
    return 0
}

run_menu() {
    display_menu
    # Simulate choice for demo
    handle_choice 1
    handle_choice 2
}

run_menu

# FUNCTION BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Use descriptive function names (verb_noun pattern)
2. Keep functions small and focused (do one thing)
3. Use local variables inside functions
4. Document complex functions with comments
5. Validate function parameters
6. Use return codes consistently (0=success, non-zero=error)
7. Use echo for returning values, return for exit status
8. Avoid global variables when possible
9. Group related functions together
10. Test functions independently
'

echo ""
echo "Functions tutorial complete!"
