#!/bin/bash

# LOCAL VS GLOBAL VARIABLES IN SHELL SCRIPTING
# Understanding variable scope is crucial for writing maintainable code

# GLOBAL VARIABLES
# Variables declared outside functions are global
# Accessible anywhere in the script

echo "=== GLOBAL VARIABLES ==="

# Global variable
global_var="I am global"
counter=0

echo "Global variable: $global_var"

function display_global() {
    echo "Accessing global from function: $global_var"
    
    # Modifying global variable
    global_var="Modified inside function"
    ((counter++))
}

display_global
echo "After function: $global_var"
echo "Counter: $counter"

# LOCAL VARIABLES
# Variables declared with 'local' keyword inside functions
# Only accessible within that function

echo ""
echo "=== LOCAL VARIABLES ==="

function test_local() {
    local local_var="I am local"
    echo "Inside function: $local_var"
}

test_local
echo "Outside function: $local_var"  # This will be empty

# LOCAL VS GLOBAL COMPARISON

echo ""
echo "=== LOCAL VS GLOBAL COMPARISON ==="

name="Global Name"

function modify_variables() {
    local name="Local Name"  # Local variable shadows global
    age=25  # This becomes global (no 'local' keyword)
    
    echo "Inside function:"
    echo "  name (local): $name"
    echo "  age (global): $age"
}

echo "Before function:"
echo "  name: $name"
echo "  age: ${age:-not set}"

modify_variables

echo "After function:"
echo "  name: $name"  # Still global value
echo "  age: $age"    # Now set globally

# VARIABLE SHADOWING
# Local variables can have the same name as global variables

echo ""
echo "=== VARIABLE SHADOWING ==="

value="outer"

function shadow_test() {
    echo "Start of function: $value"  # Accesses global
    
    local value="inner"  # Creates local variable with same name
    echo "After local declaration: $value"  # Accesses local
    
    value="modified inner"
    echo "After modification: $value"
}

echo "Before function: $value"
shadow_test
echo "After function: $value"  # Global unchanged

# NESTED FUNCTION SCOPES

echo ""
echo "=== NESTED FUNCTION SCOPES ==="

outer_function() {
    local outer_var="outer"
    echo "Outer function: $outer_var"
    
    inner_function() {
        local inner_var="inner"
        echo "Inner function: $inner_var"
        echo "Accessing outer: $outer_var"  # Can access outer function's local
        
        outer_var="modified from inner"
    }
    
    inner_function
    echo "After inner: $outer_var"
}

outer_function

# READONLY VARIABLES
# Variables that cannot be modified

echo ""
echo "=== READONLY VARIABLES ==="

readonly CONSTANT="This cannot change"
echo "Constant: $CONSTANT"

# This would cause an error:
# CONSTANT="new value"

function try_modify_readonly() {
    # This would also cause an error:
    # CONSTANT="attempt to modify"
    echo "Readonly variable: $CONSTANT"
}

try_modify_readonly

# ENVIRONMENT VARIABLES
# Available to child processes

echo ""
echo "=== ENVIRONMENT VARIABLES ==="

# Regular variable (not exported)
regular_var="regular"

# Environment variable (exported)
export exported_var="exported"

function check_export() {
    echo "Regular: $regular_var"
    echo "Exported: $exported_var"
}

check_export

# UNSETTING VARIABLES

echo ""
echo "=== UNSETTING VARIABLES ==="

temp_var="temporary"
echo "Before unset: $temp_var"

unset temp_var
echo "After unset: ${temp_var:-empty}"

function test_unset() {
    local func_var="local value"
    echo "Before unset: $func_var"
    
    unset func_var
    echo "After unset: ${func_var:-empty}"
}

test_unset

# VARIABLE SCOPE IN LOOPS

echo ""
echo "=== VARIABLE SCOPE IN LOOPS ==="

# Variables in loops are not automatically local
for i in {1..3}; do
    loop_var="iteration $i"
done

echo "After loop: $loop_var"  # Still accessible

# Using local in function with loop
function loop_with_local() {
    local loop_var
    
    for i in {1..3}; do
        loop_var="iteration $i"
        echo "In loop: $loop_var"
    done
    
    echo "After loop (inside function): $loop_var"
}

loop_with_local
echo "After function: ${loop_var:-from outside}"

# PRACTICAL EXAMPLE 1: CONFIGURATION MANAGER

echo ""
echo "=== PRACTICAL EXAMPLE 1: CONFIGURATION ==="

# Global configuration
CONFIG_FILE="/tmp/app.conf"
DEBUG_MODE=false

function load_config() {
    local line
    
    if [ -f "$CONFIG_FILE" ]; then
        while read -r line; do
            echo "Loading: $line"
        done < "$CONFIG_FILE"
    else
        echo "Config file not found, using defaults"
    fi
}

function set_debug() {
    DEBUG_MODE=$1
    echo "Debug mode set to: $DEBUG_MODE"
}

load_config
set_debug true
echo "Debug mode: $DEBUG_MODE"

# PRACTICAL EXAMPLE 2: COUNTER PATTERN

echo ""
echo "=== PRACTICAL EXAMPLE 2: COUNTER ==="

# Global counter
request_count=0

function increment_counter() {
    ((request_count++))
}

function get_counter() {
    echo $request_count
}

function reset_counter() {
    request_count=0
}

increment_counter
increment_counter
increment_counter
echo "Total requests: $(get_counter)"

reset_counter
echo "After reset: $(get_counter)"

# PRACTICAL EXAMPLE 3: TEMPORARY VARIABLES

echo ""
echo "=== PRACTICAL EXAMPLE 3: TEMPORARY VARIABLES ==="

function process_data() {
    local temp_result
    local temp_value
    
    # These are automatically cleaned up when function exits
    temp_value=100
    temp_result=$((temp_value * 2))
    
    echo "Processing result: $temp_result"
    
    # Return only what's needed
    echo $temp_result
}

final_result=$(process_data)
echo "Final: $final_result"

# temp_value and temp_result are not accessible here
echo "Temp value outside: ${temp_value:-not accessible}"

# PRACTICAL EXAMPLE 4: NAMESPACE PATTERN

echo ""
echo "=== PRACTICAL EXAMPLE 4: NAMESPACE PATTERN ==="

# Using prefixes to create namespaces
APP_NAME="MyApp"
APP_VERSION="1.0"
APP_AUTHOR="John Doe"

function app_info() {
    local prefix="APP"
    
    echo "Application Information:"
    echo "  Name: ${APP_NAME}"
    echo "  Version: ${APP_VERSION}"
    echo "  Author: ${APP_AUTHOR}"
}

function app_set_name() {
    APP_NAME=$1
}

app_info
app_set_name "NewApp"
app_info

# PRACTICAL EXAMPLE 5: STATE MANAGEMENT

echo ""
echo "=== PRACTICAL EXAMPLE 5: STATE MANAGEMENT ==="

# Global state
current_state="idle"

function set_state() {
    local new_state=$1
    local old_state=$current_state
    
    current_state=$new_state
    echo "State transition: $old_state -> $new_state"
}

function get_state() {
    echo $current_state
}

set_state "running"
set_state "paused"
set_state "stopped"
echo "Current state: $(get_state)"

# PRACTICAL EXAMPLE 6: FUNCTION RETURN VALUES

echo ""
echo "=== PRACTICAL EXAMPLE 6: COMPLEX RETURN ==="

function calculate_stats() {
    local numbers=("$@")
    local sum=0
    local count=${#numbers[@]}
    
    # Calculate sum
    for num in "${numbers[@]}"; do
        ((sum += num))
    done
    
    # Calculate average
    local avg=$((sum / count))
    
    # Return multiple values via echo
    echo "$sum $avg $count"
}

# Capture multiple return values
read -r total average num_items <<< $(calculate_stats 10 20 30 40 50)

echo "Total: $total"
echo "Average: $average"
echo "Count: $num_items"

# PRACTICAL EXAMPLE 7: ERROR STATE

echo ""
echo "=== PRACTICAL EXAMPLE 7: ERROR HANDLING ==="

# Global error state
last_error=""
error_count=0

function set_error() {
    last_error=$1
    ((error_count++))
}

function clear_error() {
    last_error=""
}

function get_error() {
    echo "$last_error"
}

function risky_operation() {
    local input=$1
    
    if [ -z "$input" ]; then
        set_error "Input cannot be empty"
        return 1
    fi
    
    clear_error
    echo "Operation successful"
    return 0
}

risky_operation ""
echo "Error: $(get_error)"
echo "Error count: $error_count"

risky_operation "valid"
echo "Error: $(get_error)"

# VARIABLE SCOPE BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Always use local for function variables
2. Use meaningful names for global variables
3. Minimize use of global variables
4. Use uppercase for constants/environment variables
5. Use lowercase for local/temporary variables
6. Avoid modifying global variables in functions when possible
7. Pass values as parameters instead of using globals
8. Return values via echo, not by modifying globals
9. Use readonly for true constants
10. Document global variables at the top of script
'

# DEMONSTRATION OF BEST PRACTICE

function good_practice() {
    local input=$1  # Parameter, not global
    local result    # Local variable
    
    # Process using local variables
    result=$((input * 2))
    
    # Return via echo, not global
    echo $result
}

# Use function
output=$(good_practice 5)
echo "Good practice result: $output"

echo ""
echo "Local and global variables tutorial complete!"
