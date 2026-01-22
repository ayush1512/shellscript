#!/bin/bash

# BREAK AND CONTINUE STATEMENTS IN SHELL SCRIPTING
# Used to control loop flow
# break: Exit the loop completely
# continue: Skip current iteration and move to next one

# BREAK STATEMENT
# Exits the innermost loop immediately

echo "=== BASIC BREAK STATEMENT ==="

# Break in for loop
for i in {1..10}; do
    echo "Number: $i"
    
    if [ $i -eq 5 ]; then
        echo "Breaking at 5"
        break
    fi
done

echo "Loop ended"

# BREAK IN WHILE LOOP

echo ""
echo "=== BREAK IN WHILE LOOP ==="

counter=1

while true; do
    echo "Counter: $counter"
    
    if [ $counter -eq 5 ]; then
        echo "Breaking out of infinite loop"
        break
    fi
    
    ((counter++))
done

# BREAK IN UNTIL LOOP

echo ""
echo "=== BREAK IN UNTIL LOOP ==="

value=1

until [ $value -gt 20 ]; do
    echo "Value: $value"
    
    if [ $value -eq 7 ]; then
        echo "Breaking at 7"
        break
    fi
    
    ((value++))
done

# CONTINUE STATEMENT
# Skips the rest of the current iteration and continues with the next

echo ""
echo "=== BASIC CONTINUE STATEMENT ==="

# Continue in for loop
for i in {1..10}; do
    # Skip even numbers
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    
    echo "Odd number: $i"
done

# CONTINUE IN WHILE LOOP

echo ""
echo "=== CONTINUE IN WHILE LOOP ==="

num=0

while [ $num -lt 10 ]; do
    ((num++))
    
    # Skip multiples of 3
    if [ $((num % 3)) -eq 0 ]; then
        continue
    fi
    
    echo "Not a multiple of 3: $num"
done

# CONTINUE IN UNTIL LOOP

echo ""
echo "=== CONTINUE IN UNTIL LOOP ==="

count=0

until [ $count -ge 10 ]; do
    ((count++))
    
    # Skip numbers divisible by 4
    if [ $((count % 4)) -eq 0 ]; then
        continue
    fi
    
    echo "Not divisible by 4: $count"
done

# BREAK IN NESTED LOOPS
# break only exits the innermost loop

echo ""
echo "=== BREAK IN NESTED LOOPS ==="

for outer in {1..3}; do
    echo "Outer loop: $outer"
    
    for inner in {1..5}; do
        echo "  Inner: $inner"
        
        if [ $inner -eq 3 ]; then
            echo "  Breaking inner loop"
            break
        fi
    done
    
    echo "Back to outer loop"
done

# CONTINUE IN NESTED LOOPS
# continue only affects the innermost loop

echo ""
echo "=== CONTINUE IN NESTED LOOPS ==="

for i in {1..3}; do
    echo "Outer: $i"
    
    for j in {1..5}; do
        if [ $j -eq 3 ]; then
            continue  # Skips only inner iteration
        fi
        echo "  Inner: $j"
    done
done

# BREAK N (BREAKING MULTIPLE LEVELS)
# break n exits n levels of loops

echo ""
echo "=== BREAK MULTIPLE LEVELS ==="

for a in {1..3}; do
    echo "Level 1: $a"
    
    for b in {1..3}; do
        echo "  Level 2: $b"
        
        for c in {1..3}; do
            echo "    Level 3: $c"
            
            if [ $c -eq 2 ]; then
                echo "    Breaking 2 levels"
                break 2  # Breaks out of 2 loops
            fi
        done
        
        echo "  After inner loop"
    done
    
    echo "After middle loop"
done

# CONTINUE N (CONTINUING MULTIPLE LEVELS)
# continue n skips to next iteration n levels up

echo ""
echo "=== CONTINUE MULTIPLE LEVELS ==="

for x in {1..2}; do
    echo "Outer: $x"
    
    for y in {1..3}; do
        echo "  Middle: $y"
        
        for z in {1..3}; do
            if [ $z -eq 2 ]; then
                echo "    Continuing outer loop"
                continue 2  # Continues outer loop
            fi
            echo "    Inner: $z"
        done
    done
done

# PRACTICAL EXAMPLE 1: SKIP ERRORS

echo ""
echo "=== PRACTICAL EXAMPLE 1: SKIP ERRORS ==="

function process_files() {
    local files=("file1.txt" "file2.txt" "badfile" "file3.txt")
    
    for file in "${files[@]}"; do
        # Skip files that don't have .txt extension
        if [[ ! "$file" == *.txt ]]; then
            echo "Skipping non-txt file: $file"
            continue
        fi
        
        echo "Processing: $file"
        # Process file here
    done
}

process_files

# PRACTICAL EXAMPLE 2: FIND AND STOP

echo ""
echo "=== PRACTICAL EXAMPLE 2: FIND AND STOP ==="

function find_in_array() {
    local target="orange"
    local items=("apple" "banana" "orange" "grape" "mango")
    
    echo "Looking for: $target"
    
    for item in "${items[@]}"; do
        echo "Checking: $item"
        
        if [ "$item" = "$target" ]; then
            echo "Found: $target"
            break
        fi
    done
}

find_in_array

# PRACTICAL EXAMPLE 3: VALIDATE INPUT

echo ""
echo "=== PRACTICAL EXAMPLE 3: VALIDATE AND SKIP ==="

function validate_numbers() {
    local inputs=("10" "abc" "20" "xyz" "30" "40")
    
    echo "Processing numbers:"
    
    for input in "${inputs[@]}"; do
        # Skip non-numeric inputs
        if ! [[ "$input" =~ ^[0-9]+$ ]]; then
            echo "Skipping invalid input: $input"
            continue
        fi
        
        echo "Valid number: $input"
        result=$((input * 2))
        echo "  Double: $result"
    done
}

validate_numbers

# PRACTICAL EXAMPLE 4: SEARCH WITH LIMIT

echo ""
echo "=== PRACTICAL EXAMPLE 4: SEARCH WITH LIMIT ==="

function search_with_limit() {
    local max_checks=100
    local found=false
    
    echo "Searching for target value..."
    
    for i in {1..1000}; do
        # Limit number of checks
        if [ $i -gt $max_checks ]; then
            echo "Reached maximum checks ($max_checks)"
            break
        fi
        
        # Simulate finding target
        if [ $i -eq 42 ]; then
            echo "Found target at position: $i"
            found=true
            break
        fi
    done
    
    if [ "$found" = false ]; then
        echo "Target not found in first $max_checks items"
    fi
}

search_with_limit

# PRACTICAL EXAMPLE 5: RETRY WITH BACKOFF

echo ""
echo "=== PRACTICAL EXAMPLE 5: RETRY WITH BACKOFF ==="

function retry_with_backoff() {
    local max_retries=5
    local retry=0
    
    while [ $retry -lt $max_retries ]; do
        ((retry++))
        echo "Attempt $retry..."
        
        # Simulate operation (succeeds on attempt 3)
        if [ $retry -eq 3 ]; then
            echo "Operation succeeded!"
            break
        fi
        
        echo "Failed, waiting before retry..."
        sleep $retry  # Exponential backoff
    done
    
    if [ $retry -eq $max_retries ]; then
        echo "Failed after $max_retries attempts"
    fi
}

retry_with_backoff

# PRACTICAL EXAMPLE 6: FILE PROCESSING WITH SKIP

echo ""
echo "=== PRACTICAL EXAMPLE 6: FILE PROCESSING ==="

function process_log_files() {
    # Create sample files
    touch /tmp/app.log /tmp/error.log /tmp/backup.log
    
    echo "Processing log files:"
    
    for file in /tmp/*.log; do
        # Skip backup files
        if [[ "$file" == *backup* ]]; then
            echo "Skipping backup: $file"
            continue
        fi
        
        echo "Processing: $file"
        # Process file here
    done
    
    # Cleanup
    rm -f /tmp/*.log
}

process_log_files

# PRACTICAL EXAMPLE 7: MENU WITH EXIT

echo ""
echo "=== PRACTICAL EXAMPLE 7: MENU WITH EXIT ==="

function interactive_menu() {
    while true; do
        echo ""
        echo "=== Menu ==="
        echo "1. Option 1"
        echo "2. Option 2"
        echo "3. Exit"
        
        # Simulate user input
        choice=3
        
        case $choice in
            1)
                echo "Selected Option 1"
                ;;
            2)
                echo "Selected Option 2"
                ;;
            3)
                echo "Exiting..."
                break
                ;;
            *)
                echo "Invalid choice"
                continue
                ;;
        esac
        
        # Break for demo (would normally continue loop)
        break
    done
}

interactive_menu

# PRACTICAL EXAMPLE 8: DATA FILTERING

echo ""
echo "=== PRACTICAL EXAMPLE 8: DATA FILTERING ==="

function filter_data() {
    local data=("10" "25" "30" "45" "50" "65" "70")
    local threshold=50
    
    echo "Values above $threshold:"
    
    for value in "${data[@]}"; do
        # Skip values below threshold
        if [ $value -le $threshold ]; then
            continue
        fi
        
        echo "  $value"
    done
}

filter_data

# PRACTICAL EXAMPLE 9: EARLY EXIT ON ERROR

echo ""
echo "=== PRACTICAL EXAMPLE 9: EARLY EXIT ON ERROR ==="

function process_with_error_check() {
    local items=("item1" "item2" "error" "item3" "item4")
    
    echo "Processing items:"
    
    for item in "${items[@]}"; do
        echo "Processing: $item"
        
        # Check for error condition
        if [ "$item" = "error" ]; then
            echo "ERROR encountered! Stopping processing."
            break
        fi
        
        echo "  Completed: $item"
    done
}

process_with_error_check

# PRACTICAL EXAMPLE 10: SKIP WEEKENDS

echo ""
echo "=== PRACTICAL EXAMPLE 10: SKIP WEEKENDS ==="

function process_weekdays() {
    local days=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")
    
    echo "Processing weekdays only:"
    
    for day in "${days[@]}"; do
        # Skip weekends
        if [ "$day" = "Sat" ] || [ "$day" = "Sun" ]; then
            echo "Skipping weekend: $day"
            continue
        fi
        
        echo "Processing: $day"
    done
}

process_weekdays

# BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Use break when you need to exit a loop early
2. Use continue when you need to skip specific iterations
3. Be careful with break/continue in nested loops
4. Use break n or continue n to control multiple loop levels
5. Document why you are using break/continue
6. Avoid overusing break/continue - sometimes restructuring is better
7. Consider using functions with return instead of break for clarity
8. Test edge cases when using break/continue in nested loops
'

echo ""
echo "Break and continue tutorial complete!"
