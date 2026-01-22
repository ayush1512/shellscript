#!/bin/bash

# WHILE LOOPS IN SHELL SCRIPTING
# While loops execute commands as long as a condition is true
# Syntax:
# while [ condition ]; do
#     commands
# done

# BASIC WHILE LOOP

echo "=== BASIC WHILE LOOP ==="

counter=1

while [ $counter -le 5 ]; do
    echo "Counter: $counter"
    ((counter++))
done

# WHILE LOOP WITH ARITHMETIC CONDITION

echo ""
echo "=== WHILE LOOP WITH ARITHMETIC CONDITION ==="

num=1

while (( num <= 5 )); do
    echo "Number: $num"
    ((num++))
done

# INFINITE WHILE LOOP
# while true or while : or while [ 1 ]

echo ""
echo "=== INFINITE LOOP (with break) ==="

count=0

while true; do
    ((count++))
    echo "Iteration: $count"
    
    if [ $count -eq 3 ]; then
        echo "Breaking out of infinite loop"
        break
    fi
done

# WHILE LOOP READING FROM USER INPUT

echo ""
echo "=== WHILE LOOP WITH USER INPUT ==="

# Read input until user enters 'quit'
: '
while true; do
    read -p "Enter a command (type quit to exit): " cmd
    
    if [ "$cmd" = "quit" ]; then
        echo "Exiting..."
        break
    fi
    
    echo "You entered: $cmd"
done
'
echo "(User input example - commented out for demo)"

# WHILE LOOP READING FROM FILE

echo ""
echo "=== WHILE LOOP READING FROM FILE ==="

# Create a test file
echo "Creating test file..."
cat > /tmp/test_file.txt << 'EOF'
Line 1: Hello
Line 2: World
Line 3: From
Line 4: Bash
Line 5: Script
EOF

# Method 1: Using input redirection
echo "Reading file (method 1):"
line_num=0
while read -r line; do
    ((line_num++))
    echo "$line_num: $line"
done < /tmp/test_file.txt

# Method 2: Using pipe
echo ""
echo "Reading file (method 2):"
cat /tmp/test_file.txt | while read -r line; do
    echo "  -> $line"
done

# Cleanup
rm -f /tmp/test_file.txt

# WHILE LOOP WITH MULTIPLE CONDITIONS

echo ""
echo "=== WHILE LOOP WITH MULTIPLE CONDITIONS ==="

x=1
y=10

while [ $x -le 5 ] && [ $y -gt 5 ]; do
    echo "x=$x, y=$y"
    ((x++))
    ((y--))
done

# WHILE LOOP WITH COUNTER

echo ""
echo "=== WHILE LOOP WITH COUNTER ==="

# Count from 10 to 1
countdown=10

while [ $countdown -gt 0 ]; do
    echo "Countdown: $countdown"
    ((countdown--))
done
echo "Blast off!"

# CONTINUE STATEMENT IN WHILE LOOP

echo ""
echo "=== CONTINUE IN WHILE LOOP ==="

number=0

while [ $number -lt 10 ]; do
    ((number++))
    
    # Skip even numbers
    if [ $((number % 2)) -eq 0 ]; then
        continue
    fi
    
    echo "Odd number: $number"
done

# BREAK STATEMENT IN WHILE LOOP

echo ""
echo "=== BREAK IN WHILE LOOP ==="

value=1

while [ $value -le 20 ]; do
    echo "Value: $value"
    
    # Break when value reaches 5
    if [ $value -eq 5 ]; then
        echo "Breaking at 5"
        break
    fi
    
    ((value++))
done

# NESTED WHILE LOOPS

echo ""
echo "=== NESTED WHILE LOOPS ==="

outer=1

while [ $outer -le 3 ]; do
    echo "Outer loop: $outer"
    
    inner=1
    while [ $inner -le 3 ]; do
        echo "  Inner loop: $inner"
        ((inner++))
    done
    
    ((outer++))
done

# WHILE LOOP WITH SLEEP (POLLING)

echo ""
echo "=== WHILE LOOP WITH SLEEP ==="

# Wait for a condition (simulated)
attempts=0
max_attempts=5

while [ $attempts -lt $max_attempts ]; do
    ((attempts++))
    echo "Attempt $attempts of $max_attempts"
    
    # Simulate checking something
    if [ $attempts -eq 3 ]; then
        echo "Condition met!"
        break
    fi
    
    sleep 1
done

# PRACTICAL EXAMPLE 1: MENU SYSTEM

echo ""
echo "=== PRACTICAL EXAMPLE 1: MENU SYSTEM ==="

function show_menu() {
    local choice="0"
    
    while [ "$choice" != "4" ]; do
        echo ""
        echo "===== Menu ====="
        echo "1. Show date"
        echo "2. Show time"
        echo "3. Show user"
        echo "4. Exit"
        read -p "Select option: " choice
        
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
                ;;
            *)
                echo "Invalid option"
                ;;
        esac
        
        # Limit iterations for demo
        break
    done
}

show_menu

# PRACTICAL EXAMPLE 2: FILE MONITORING

echo ""
echo "=== PRACTICAL EXAMPLE 2: FILE MONITORING ==="

function monitor_file() {
    local file="/tmp/monitor_test.txt"
    local iterations=3
    local count=0
    
    echo "Monitoring file: $file"
    echo "Initial content" > "$file"
    
    while [ $count -lt $iterations ]; do
        ((count++))
        
        if [ -f "$file" ]; then
            size=$(stat -c%s "$file")
            echo "Check $count: File exists, size: $size bytes"
        else
            echo "Check $count: File does not exist"
        fi
        
        # Add more content
        echo "Line $count" >> "$file"
        sleep 1
    done
    
    # Cleanup
    rm -f "$file"
}

monitor_file

# PRACTICAL EXAMPLE 3: RETRY LOGIC

echo ""
echo "=== PRACTICAL EXAMPLE 3: RETRY LOGIC ==="

function retry_command() {
    local max_retries=3
    local retry_count=0
    local success=false
    
    while [ $retry_count -lt $max_retries ] && [ "$success" = false ]; do
        ((retry_count++))
        echo "Attempt $retry_count of $max_retries..."
        
        # Simulate a command that might fail
        if [ $retry_count -ge 2 ]; then
            echo "Command succeeded!"
            success=true
        else
            echo "Command failed, retrying..."
            sleep 1
        fi
    done
    
    if [ "$success" = false ]; then
        echo "Command failed after $max_retries attempts"
        return 1
    fi
    
    return 0
}

retry_command

# PRACTICAL EXAMPLE 4: PROCESSING QUEUE

echo ""
echo "=== PRACTICAL EXAMPLE 4: PROCESSING QUEUE ==="

function process_queue() {
    # Simulate a queue
    queue=("task1" "task2" "task3" "task4" "task5")
    index=0
    
    while [ $index -lt ${#queue[@]} ]; do
        task="${queue[$index]}"
        echo "Processing: $task"
        
        # Simulate processing time
        sleep 1
        
        echo "Completed: $task"
        ((index++))
    done
    
    echo "All tasks completed!"
}

process_queue

# PRACTICAL EXAMPLE 5: WAITING FOR CONDITION

echo ""
echo "=== PRACTICAL EXAMPLE 5: WAIT FOR CONDITION ==="

function wait_for_file() {
    local file="/tmp/wait_test.txt"
    local timeout=5
    local elapsed=0
    
    echo "Waiting for file: $file"
    
    while [ ! -f "$file" ] && [ $elapsed -lt $timeout ]; do
        echo "Waiting... ($elapsed seconds)"
        sleep 1
        ((elapsed++))
        
        # Create file after 2 seconds (simulating)
        if [ $elapsed -eq 2 ]; then
            echo "Creating file..." > "$file"
        fi
    done
    
    if [ -f "$file" ]; then
        echo "File found!"
        rm -f "$file"
    else
        echo "Timeout: File not found"
    fi
}

wait_for_file

# PRACTICAL EXAMPLE 6: BATCH PROCESSING

echo ""
echo "=== PRACTICAL EXAMPLE 6: BATCH PROCESSING ==="

function batch_process() {
    files=("file1.txt" "file2.txt" "file3.txt")
    index=0
    
    while [ $index -lt ${#files[@]} ]; do
        file="${files[$index]}"
        echo "Processing $file..."
        
        # Create and process file
        echo "Content of $file" > "/tmp/$file"
        wc -w "/tmp/$file"
        rm -f "/tmp/$file"
        
        ((index++))
    done
}

batch_process

# PRACTICAL EXAMPLE 7: LOG MONITORING

echo ""
echo "=== PRACTICAL EXAMPLE 7: LOG MONITORING ==="

function monitor_log() {
    local log_file="/tmp/app.log"
    local max_checks=3
    local check_count=0
    
    # Create sample log
    cat > "$log_file" << 'EOF'
2024-01-01 10:00:00 INFO Application started
2024-01-01 10:05:00 WARNING High memory usage
2024-01-01 10:10:00 ERROR Connection failed
EOF
    
    echo "Monitoring log file for errors..."
    
    while read -r line; do
        if [[ "$line" == *"ERROR"* ]]; then
            echo "Found error: $line"
        fi
    done < "$log_file"
    
    # Cleanup
    rm -f "$log_file"
}

monitor_log

# WHILE LOOP VS FOR LOOP
# Use WHILE when:
# - Number of iterations is unknown
# - Looping until a condition is met
# - Reading from files or streams
# - Implementing retry logic
#
# Use FOR when:
# - Iterating over a known list
# - Number of iterations is known
# - Iterating over arrays or ranges

echo ""
echo "While loop tutorial complete!"
