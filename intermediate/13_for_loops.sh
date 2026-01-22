#!/bin/bash

# FOR LOOPS IN SHELL SCRIPTING
# For loops iterate over a list of items and execute commands for each item

# BASIC FOR LOOP
# Syntax:
# for variable in list; do
#     commands
# done

echo "=== BASIC FOR LOOP ==="

# Iterate over a list of items
for item in apple banana orange grape; do
    echo "Fruit: $item"
done

# FOR LOOP WITH NUMBERS

echo ""
echo "=== FOR LOOP WITH NUMBERS ==="

# Using sequence
for num in 1 2 3 4 5; do
    echo "Number: $num"
done

# FOR LOOP WITH RANGE (using seq)
# seq generates sequence of numbers
# Syntax: seq [start] [step] [end]

echo ""
echo "=== FOR LOOP WITH RANGE (seq) ==="

# From 1 to 5
for i in $(seq 1 5); do
    echo "Count: $i"
done

# From 1 to 10 with step 2
for i in $(seq 1 2 10); do
    echo "Odd number: $i"
done

# From 10 to 1 (countdown)
for i in $(seq 10 -1 1); do
    echo "Countdown: $i"
done

# FOR LOOP WITH BRACE EXPANSION

echo ""
echo "=== FOR LOOP WITH BRACE EXPANSION ==="

# Using {start..end}
for i in {1..5}; do
    echo "Using braces: $i"
done

# With step (bash 4+)
for i in {0..10..2}; do
    echo "Even number: $i"
done

# Character range
for letter in {a..e}; do
    echo "Letter: $letter"
done

# C-STYLE FOR LOOP
# Syntax:
# for ((initialization; condition; increment)); do
#     commands
# done

echo ""
echo "=== C-STYLE FOR LOOP ==="

for ((i=1; i<=5; i++)); do
    echo "Iteration: $i"
done

# Countdown
for ((i=10; i>=1; i--)); do
    echo "Countdown: $i"
done

# Step by 2
for ((i=0; i<=10; i+=2)); do
    echo "Even: $i"
done

# ITERATING OVER ARRAYS

echo ""
echo "=== ITERATING OVER ARRAYS ==="

# Declare array
fruits=("apple" "banana" "orange" "grape")

# Method 1: Using array elements
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done

# Method 2: Using array indices
for i in "${!fruits[@]}"; do
    echo "Index $i: ${fruits[$i]}"
done

# ITERATING OVER FILES

echo ""
echo "=== ITERATING OVER FILES ==="

# List all .sh files in current directory
echo "Shell scripts in basic directory:"
for file in /home/runner/work/shellscript/shellscript/basic/*.sh; do
    if [ -f "$file" ]; then
        echo "  $(basename "$file")"
    fi
done

# ITERATING OVER COMMAND OUTPUT

echo ""
echo "=== ITERATING OVER COMMAND OUTPUT ==="

# Iterate over lines from command
echo "First 5 lines of /etc/passwd:"
count=0
for line in $(head -5 /etc/passwd); do
    ((count++))
    echo "$count: $line"
done

# Better way using while read (shown in while loop section)

# ITERATING OVER STRINGS

echo ""
echo "=== ITERATING OVER STRINGS ==="

# Split string by spaces
text="Hello World from Bash"
for word in $text; do
    echo "Word: $word"
done

# Split string by custom delimiter
IFS=',' read -ra items <<< "apple,banana,orange"
for item in "${items[@]}"; do
    echo "Item: $item"
done

# NESTED FOR LOOPS

echo ""
echo "=== NESTED FOR LOOPS ==="

# Multiplication table
echo "Multiplication table (3x3):"
for i in {1..3}; do
    for j in {1..3}; do
        result=$((i * j))
        echo -n "$i x $j = $result  "
    done
    echo ""  # New line after inner loop
done

# BREAK AND CONTINUE

echo ""
echo "=== BREAK STATEMENT ==="

# Break exits the loop
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Breaking at $i"
        break
    fi
    echo "Number: $i"
done

echo ""
echo "=== CONTINUE STATEMENT ==="

# Continue skips current iteration
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue  # Skip even numbers
    fi
    echo "Odd number: $i"
done

# FOR LOOP WITH CONDITIONAL

echo ""
echo "=== FOR LOOP WITH CONDITIONAL ==="

# Process only specific items
for i in {1..10}; do
    if [ $i -gt 5 ]; then
        echo "Number greater than 5: $i"
    fi
done

# PRACTICAL EXAMPLE 1: FILE OPERATIONS

echo ""
echo "=== PRACTICAL EXAMPLE 1: BATCH FILE OPERATIONS ==="

# Create multiple files
echo "Creating test files..."
for i in {1..5}; do
    filename="/tmp/test_file_$i.txt"
    echo "This is test file $i" > "$filename"
    echo "Created: $filename"
done

# List created files
echo ""
echo "Listing created files:"
for file in /tmp/test_file_*.txt; do
    if [ -f "$file" ]; then
        echo "File: $(basename "$file"), Size: $(stat -c%s "$file") bytes"
    fi
done

# Cleanup
echo ""
echo "Cleaning up..."
for i in {1..5}; do
    rm -f "/tmp/test_file_$i.txt"
done

# PRACTICAL EXAMPLE 2: SYSTEM INFORMATION

echo ""
echo "=== PRACTICAL EXAMPLE 2: SYSTEM INFORMATION ==="

# Check disk usage for multiple paths
echo "Disk usage:"
for path in / /tmp /home; do
    if [ -d "$path" ]; then
        usage=$(df -h "$path" | awk 'NR==2 {print $5}')
        echo "  $path: $usage"
    fi
done

# PRACTICAL EXAMPLE 3: BACKUP FILES

echo ""
echo "=== PRACTICAL EXAMPLE 3: BACKUP SCRIPT ==="

function backup_files() {
    local source_dir="/tmp"
    local backup_dir="/tmp/backup_demo"
    
    mkdir -p "$backup_dir"
    
    echo "Backing up files from $source_dir..."
    count=0
    for file in "$source_dir"/*.txt; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            cp "$file" "$backup_dir/${filename}.backup"
            ((count++))
        fi
    done
    echo "Backed up $count files"
    
    # Cleanup
    rm -rf "$backup_dir"
}

backup_files

# PRACTICAL EXAMPLE 4: PROCESS MONITORING

echo ""
echo "=== PRACTICAL EXAMPLE 4: PROCESS CHECK ==="

# Check if specific processes are running
processes=("bash" "systemd" "sshd")

echo "Checking processes:"
for proc in "${processes[@]}"; do
    if pgrep "$proc" > /dev/null; then
        echo "  ✓ $proc is running"
    else
        echo "  ✗ $proc is not running"
    fi
done

# PRACTICAL EXAMPLE 5: STRING PROCESSING

echo ""
echo "=== PRACTICAL EXAMPLE 5: STRING PROCESSING ==="

# Convert strings to uppercase
names=("john" "jane" "bob" "alice")

echo "Original names:"
for name in "${names[@]}"; do
    echo "  $name"
done

echo ""
echo "Uppercase names:"
for name in "${names[@]}"; do
    echo "  ${name^^}"
done

# PRACTICAL EXAMPLE 6: VALIDATION

echo ""
echo "=== PRACTICAL EXAMPLE 6: INPUT VALIDATION ==="

# Validate multiple inputs
inputs=("123" "abc" "456" "xyz" "789")

echo "Validating inputs:"
for input in "${inputs[@]}"; do
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        echo "  $input: Valid number"
    else
        echo "  $input: Not a number"
    fi
done

# PRACTICAL EXAMPLE 7: COUNTDOWN TIMER

echo ""
echo "=== PRACTICAL EXAMPLE 7: COUNTDOWN TIMER ==="

function countdown() {
    local seconds=$1
    for ((i=seconds; i>0; i--)); do
        echo -ne "Time remaining: $i seconds\r"
        sleep 1
    done
    echo -e "\nTime's up!"
}

echo "Starting 3 second countdown:"
countdown 3

# PRACTICAL EXAMPLE 8: REPORT GENERATION

echo ""
echo "=== PRACTICAL EXAMPLE 8: REPORT GENERATION ==="

# Generate a simple report
echo "System Report"
echo "============="
echo ""

items=("Hostname" "Kernel" "Uptime" "User")
commands=("hostname" "uname -r" "uptime -p" "whoami")

for i in "${!items[@]}"; do
    echo "${items[$i]}: $(${commands[$i]} 2>/dev/null || echo 'N/A')"
done

# PERFORMANCE TIP
# For large iterations, prefer:
# - C-style loops over seq
# - Built-in commands over external commands
# - Arrays over command substitution

echo ""
echo "For loop tutorial complete!"
