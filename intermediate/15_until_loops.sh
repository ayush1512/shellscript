#!/bin/bash

# UNTIL LOOPS IN SHELL SCRIPTING
# Until loops execute commands until a condition becomes true
# Opposite of while loop (while continues as long as condition is true)
# Syntax:
# until [ condition ]; do
#     commands
# done

# BASIC UNTIL LOOP

echo "=== BASIC UNTIL LOOP ==="

counter=1

# Loop until counter is greater than 5
until [ $counter -gt 5 ]; do
    echo "Counter: $counter"
    ((counter++))
done

# UNTIL LOOP WITH ARITHMETIC CONDITION

echo ""
echo "=== UNTIL LOOP WITH ARITHMETIC CONDITION ==="

num=1

until (( num > 5 )); do
    echo "Number: $num"
    ((num++))
done

# UNTIL LOOP VS WHILE LOOP COMPARISON

echo ""
echo "=== UNTIL vs WHILE COMPARISON ==="

# While loop: continues while condition is true
echo "While loop (condition: x <= 3):"
x=1
while [ $x -le 3 ]; do
    echo "  x = $x"
    ((x++))
done

# Until loop: continues until condition becomes true
echo "Until loop (condition: y > 3):"
y=1
until [ $y -gt 3 ]; do
    echo "  y = $y"
    ((y++))
done

# UNTIL LOOP WITH FILE OPERATIONS

echo ""
echo "=== UNTIL LOOP WITH FILE OPERATIONS ==="

file="/tmp/test_until.txt"

# Wait until file exists
echo "Waiting for file to be created..."

# Remove file if it exists
rm -f "$file"

count=0
until [ -f "$file" ]; do
    ((count++))
    echo "Attempt $count: File not found"
    
    # Create file after 3 attempts
    if [ $count -eq 3 ]; then
        echo "Creating file..."
        touch "$file"
    fi
    
    sleep 1
done

echo "File found!"
rm -f "$file"

# UNTIL LOOP WITH MULTIPLE CONDITIONS

echo ""
echo "=== UNTIL LOOP WITH MULTIPLE CONDITIONS ==="

a=1
b=10

# Loop until a > 5 OR b < 5
until [ $a -gt 5 ] || [ $b -lt 5 ]; do
    echo "a=$a, b=$b"
    ((a++))
    ((b--))
done

# BREAK IN UNTIL LOOP

echo ""
echo "=== BREAK IN UNTIL LOOP ==="

value=1

until [ $value -gt 10 ]; do
    echo "Value: $value"
    
    if [ $value -eq 5 ]; then
        echo "Breaking at 5"
        break
    fi
    
    ((value++))
done

# CONTINUE IN UNTIL LOOP

echo ""
echo "=== CONTINUE IN UNTIL LOOP ==="

number=0

until [ $number -ge 10 ]; do
    ((number++))
    
    # Skip even numbers
    if [ $((number % 2)) -eq 0 ]; then
        continue
    fi
    
    echo "Odd number: $number"
done

# NESTED UNTIL LOOPS

echo ""
echo "=== NESTED UNTIL LOOPS ==="

outer=1

until [ $outer -gt 3 ]; do
    echo "Outer loop: $outer"
    
    inner=1
    until [ $inner -gt 3 ]; do
        echo "  Inner loop: $inner"
        ((inner++))
    done
    
    ((outer++))
done

# INFINITE UNTIL LOOP

echo ""
echo "=== INFINITE UNTIL LOOP (with break) ==="

# until false will loop forever (false never becomes true)
iterations=0

until false; do
    ((iterations++))
    echo "Iteration: $iterations"
    
    if [ $iterations -eq 3 ]; then
        echo "Breaking out"
        break
    fi
done

# PRACTICAL EXAMPLE 1: WAIT FOR SERVICE

echo ""
echo "=== PRACTICAL EXAMPLE 1: WAIT FOR SERVICE ==="

function wait_for_service() {
    local max_attempts=5
    local attempts=0
    local service_ready=false
    
    echo "Waiting for service to be ready..."
    
    until [ "$service_ready" = true ] || [ $attempts -ge $max_attempts ]; do
        ((attempts++))
        echo "Attempt $attempts of $max_attempts"
        
        # Simulate checking service (successful after attempt 3)
        if [ $attempts -ge 3 ]; then
            service_ready=true
            echo "Service is ready!"
        else
            echo "Service not ready, waiting..."
            sleep 1
        fi
    done
    
    if [ "$service_ready" = false ]; then
        echo "Timeout: Service did not start"
        return 1
    fi
    
    return 0
}

wait_for_service

# PRACTICAL EXAMPLE 2: RETRY MECHANISM

echo ""
echo "=== PRACTICAL EXAMPLE 2: RETRY MECHANISM ==="

function connect_with_retry() {
    local max_retries=5
    local retry_count=0
    local connected=false
    
    echo "Attempting to connect..."
    
    until [ "$connected" = true ] || [ $retry_count -ge $max_retries ]; do
        ((retry_count++))
        echo "Connection attempt $retry_count..."
        
        # Simulate connection attempt (succeeds on attempt 3)
        if [ $retry_count -eq 3 ]; then
            connected=true
            echo "Connected successfully!"
        else
            echo "Connection failed, retrying in 2 seconds..."
            sleep 2
        fi
    done
    
    if [ "$connected" = false ]; then
        echo "Failed to connect after $max_retries attempts"
        return 1
    fi
    
    return 0
}

connect_with_retry

# PRACTICAL EXAMPLE 3: WAIT FOR USER INPUT

echo ""
echo "=== PRACTICAL EXAMPLE 3: WAIT FOR VALID INPUT ==="

function get_valid_number() {
    local input=""
    local valid=false
    
    echo "Enter a number between 1 and 10:"
    
    until [ "$valid" = true ]; do
        read -p "Your input: " input
        
        # Check if input is a number
        if [[ "$input" =~ ^[0-9]+$ ]]; then
            # Check if in range
            if [ $input -ge 1 ] && [ $input -le 10 ]; then
                valid=true
                echo "Valid input: $input"
            else
                echo "Error: Number must be between 1 and 10"
            fi
        else
            echo "Error: Please enter a valid number"
        fi
        
        # Break for demo purposes
        break
    done
}

# get_valid_number  # Commented out for non-interactive demo

echo "(User input example would be interactive)"

# PRACTICAL EXAMPLE 4: POLLING FOR CHANGES

echo ""
echo "=== PRACTICAL EXAMPLE 4: FILE CHANGE DETECTION ==="

function monitor_file_changes() {
    local file="/tmp/monitor.txt"
    local target_size=100
    local current_size=0
    
    echo "Monitoring file size..."
    echo "Waiting until file reaches $target_size bytes"
    
    # Create initial file
    echo "Initial content" > "$file"
    
    # Simulate file growth
    local iteration=0
    until [ $current_size -ge $target_size ] || [ $iteration -ge 5 ]; do
        ((iteration++))
        
        if [ -f "$file" ]; then
            current_size=$(stat -c%s "$file")
            echo "Check $iteration: Size = $current_size bytes"
        else
            echo "Check $iteration: File not found"
        fi
        
        # Add content to file
        echo "Additional line $iteration" >> "$file"
        sleep 1
    done
    
    echo "Monitoring complete"
    rm -f "$file"
}

monitor_file_changes

# PRACTICAL EXAMPLE 5: WAIT FOR RESOURCE

echo ""
echo "=== PRACTICAL EXAMPLE 5: RESOURCE AVAILABILITY ==="

function wait_for_resource() {
    local available=false
    local checks=0
    local max_checks=5
    
    echo "Checking resource availability..."
    
    until [ "$available" = true ] || [ $checks -ge $max_checks ]; do
        ((checks++))
        
        # Simulate resource check
        # Check if /tmp has enough space (always true, just demo)
        if [ -d "/tmp" ]; then
            available=true
            echo "Resource available!"
        else
            echo "Resource not available, waiting..."
            sleep 1
        fi
    done
}

wait_for_resource

# PRACTICAL EXAMPLE 6: BATCH PROCESSING WITH COMPLETION CHECK

echo ""
echo "=== PRACTICAL EXAMPLE 6: BATCH PROCESSING ==="

function process_batch() {
    local items=("item1" "item2" "item3" "item4" "item5")
    local processed=0
    local total=${#items[@]}
    
    echo "Processing batch of $total items..."
    
    until [ $processed -ge $total ]; do
        item="${items[$processed]}"
        echo "Processing: $item"
        
        # Simulate processing
        sleep 1
        
        echo "Completed: $item"
        ((processed++))
    done
    
    echo "All items processed!"
}

process_batch

# PRACTICAL EXAMPLE 7: COUNTDOWN WITH CONDITION

echo ""
echo "=== PRACTICAL EXAMPLE 7: COUNTDOWN ==="

function countdown_until() {
    local seconds=5
    
    echo "Countdown from $seconds..."
    
    until [ $seconds -le 0 ]; do
        echo "Time remaining: $seconds"
        sleep 1
        ((seconds--))
    done
    
    echo "Done!"
}

countdown_until

# WHEN TO USE UNTIL LOOP
# Use UNTIL when:
# - Waiting for a condition to become true
# - Logic is clearer with "do until true" rather than "while not true"
# - Implementing retry mechanisms
# - Polling for resource availability
# - Waiting for service startup
#
# Note: Any until loop can be rewritten as a while loop with negated condition
# Choose based on readability:
#   until [ $x -gt 10 ]  vs  while [ $x -le 10 ]

echo ""
echo "=== UNTIL vs WHILE: EQUIVALENT LOOPS ==="

# These are equivalent:
echo "Using until:"
n=1
until [ $n -gt 3 ]; do
    echo "  n = $n"
    ((n++))
done

echo "Using while with negated condition:"
n=1
while [ $n -le 3 ]; do
    echo "  n = $n"
    ((n++))
done

echo ""
echo "Until loop tutorial complete!"
