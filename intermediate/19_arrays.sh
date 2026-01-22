#!/bin/bash

# ARRAYS IN SHELL SCRIPTING
# Arrays store multiple values in a single variable
# Bash supports indexed (numeric) and associative (key-value) arrays

# ARRAY DECLARATION
# Syntax: array_name=(element1 element2 element3 ...)

echo "=== ARRAY DECLARATION ==="

# Method 1: Declare and initialize
fruits=("apple" "banana" "orange" "grape")
echo "Fruits array created"

# Method 2: Declare empty array
declare -a numbers
numbers=(1 2 3 4 5)
echo "Numbers array created"

# Method 3: Assign individual elements
colors[0]="red"
colors[1]="green"
colors[2]="blue"
echo "Colors array created"

# ACCESSING ARRAY ELEMENTS
# Syntax: ${array_name[index]}
# Indexing starts at 0

echo ""
echo "=== ACCESSING ARRAY ELEMENTS ==="

echo "First fruit: ${fruits[0]}"
echo "Second fruit: ${fruits[1]}"
echo "Third fruit: ${fruits[2]}"

# Accessing all elements
echo "All fruits: ${fruits[@]}"
echo "All fruits (alternative): ${fruits[*]}"

# ARRAY LENGTH
# Syntax: ${#array_name[@]}

echo ""
echo "=== ARRAY LENGTH ==="

echo "Number of fruits: ${#fruits[@]}"
echo "Number of colors: ${#colors[@]}"

# Get length of specific element
echo "Length of first fruit: ${#fruits[0]}"

# MODIFYING ARRAY ELEMENTS

echo ""
echo "=== MODIFYING ARRAYS ==="

# Change an element
fruits[1]="mango"
echo "Modified second fruit: ${fruits[1]}"

# Add element at specific index
fruits[4]="kiwi"
echo "Added fifth fruit: ${fruits[4]}"
echo "All fruits: ${fruits[@]}"

# Append element (add to end)
fruits+=("pear")
echo "After append: ${fruits[@]}"

# ARRAY INDICES
# Get all indices of an array

echo ""
echo "=== ARRAY INDICES ==="

sparse_array[0]="a"
sparse_array[5]="b"
sparse_array[10]="c"

echo "Sparse array elements: ${sparse_array[@]}"
echo "Sparse array indices: ${!sparse_array[@]}"

# ITERATING OVER ARRAYS

echo ""
echo "=== ITERATING OVER ARRAYS ==="

# Method 1: Iterate over elements
echo "Fruits:"
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done

# Method 2: Iterate using indices
echo "Numbered fruits:"
for i in "${!fruits[@]}"; do
    echo "  $i: ${fruits[$i]}"
done

# Method 3: C-style loop
echo "Colors:"
for ((i=0; i<${#colors[@]}; i++)); do
    echo "  Color $i: ${colors[$i]}"
done

# ARRAY SLICING
# Extract subset of array
# Syntax: ${array[@]:start:length}

echo ""
echo "=== ARRAY SLICING ==="

numbers=(1 2 3 4 5 6 7 8 9 10)
echo "Full array: ${numbers[@]}"

# Get elements from index 2, length 3
echo "Slice [2:5]: ${numbers[@]:2:3}"

# Get elements from index 5 to end
echo "From index 5: ${numbers[@]:5}"

# DELETING ARRAY ELEMENTS

echo ""
echo "=== DELETING ELEMENTS ==="

animals=("dog" "cat" "bird" "fish" "rabbit")
echo "Original: ${animals[@]}"

# Delete specific element
unset animals[2]
echo "After deleting index 2: ${animals[@]}"
echo "Indices: ${!animals[@]}"

# Delete entire array
unset animals
echo "After deleting array: ${animals[@]:-empty}"

# ARRAY OPERATIONS

echo ""
echo "=== ARRAY OPERATIONS ==="

arr1=(1 2 3)
arr2=(4 5 6)

# Concatenate arrays
combined=("${arr1[@]}" "${arr2[@]}")
echo "Combined: ${combined[@]}"

# Copy array
copy=("${combined[@]}")
echo "Copy: ${copy[@]}"

# SEARCHING IN ARRAYS

echo ""
echo "=== SEARCHING IN ARRAYS ==="

search_array=("apple" "banana" "orange" "grape")
search_term="orange"

echo "Searching for: $search_term"
found=false

for item in "${search_array[@]}"; do
    if [ "$item" = "$search_term" ]; then
        echo "Found: $search_term"
        found=true
        break
    fi
done

if [ "$found" = false ]; then
    echo "Not found: $search_term"
fi

# SORTING ARRAYS

echo ""
echo "=== SORTING ARRAYS ==="

unsorted=(5 2 8 1 9 3)
echo "Unsorted: ${unsorted[@]}"

# Sort array (creates new sorted array)
IFS=$'\n' sorted=($(sort -n <<<"${unsorted[*]}"))
unset IFS

echo "Sorted: ${sorted[@]}"

# Sort strings
words=("zebra" "apple" "mango" "banana")
echo "Unsorted words: ${words[@]}"

IFS=$'\n' sorted_words=($(sort <<<"${words[*]}"))
unset IFS

echo "Sorted words: ${sorted_words[@]}"

# ARRAY OF STRINGS WITH SPACES

echo ""
echo "=== ARRAYS WITH SPACES ==="

# Important: Use quotes to preserve spaces
sentences=(
    "Hello World"
    "Bash Scripting"
    "Array Tutorial"
)

echo "Sentences:"
for sentence in "${sentences[@]}"; do
    echo "  - $sentence"
done

# MULTIDIMENSIONAL ARRAYS (SIMULATED)
# Bash doesn't have true multidimensional arrays
# But we can simulate them

echo ""
echo "=== SIMULATED 2D ARRAY ==="

# Using naming convention
matrix_0_0=1
matrix_0_1=2
matrix_1_0=3
matrix_1_1=4

# Better approach: use associative arrays (shown in next script)

# Or use single array with calculation
matrix=(1 2 3 4 5 6 7 8 9)
rows=3
cols=3

echo "3x3 Matrix:"
for ((i=0; i<rows; i++)); do
    for ((j=0; j<cols; j++)); do
        index=$((i * cols + j))
        echo -n "${matrix[$index]} "
    done
    echo ""
done

# PRACTICAL EXAMPLE 1: STUDENT GRADES

echo ""
echo "=== PRACTICAL EXAMPLE 1: STUDENT GRADES ==="

students=("Alice" "Bob" "Charlie" "David")
grades=(85 92 78 95)

echo "Student Grades:"
for i in "${!students[@]}"; do
    echo "  ${students[$i]}: ${grades[$i]}"
done

# Calculate average
total=0
for grade in "${grades[@]}"; do
    ((total += grade))
done
average=$((total / ${#grades[@]}))
echo "Average grade: $average"

# PRACTICAL EXAMPLE 2: FILE PROCESSING

echo ""
echo "=== PRACTICAL EXAMPLE 2: FILE PROCESSING ==="

files=("file1.txt" "file2.txt" "file3.txt")

echo "Creating test files..."
for file in "${files[@]}"; do
    echo "Content of $file" > "/tmp/$file"
    echo "Created: /tmp/$file"
done

echo "Processing files..."
for file in "${files[@]}"; do
    if [ -f "/tmp/$file" ]; then
        word_count=$(wc -w < "/tmp/$file")
        echo "$file: $word_count words"
    fi
done

# Cleanup
for file in "${files[@]}"; do
    rm -f "/tmp/$file"
done

# PRACTICAL EXAMPLE 3: MENU SYSTEM

echo ""
echo "=== PRACTICAL EXAMPLE 3: MENU SYSTEM ==="

menu_items=(
    "Show Date"
    "Show Time"
    "Show User"
    "Exit"
)

echo "Menu Options:"
for i in "${!menu_items[@]}"; do
    echo "  $((i+1)). ${menu_items[$i]}"
done

# PRACTICAL EXAMPLE 4: DATA FILTERING

echo ""
echo "=== PRACTICAL EXAMPLE 4: FILTERING ==="

all_numbers=(5 12 8 23 4 17 9 31 6)
echo "All numbers: ${all_numbers[@]}"

# Filter even numbers
even_numbers=()
for num in "${all_numbers[@]}"; do
    if [ $((num % 2)) -eq 0 ]; then
        even_numbers+=($num)
    fi
done
echo "Even numbers: ${even_numbers[@]}"

# Filter numbers > 10
large_numbers=()
for num in "${all_numbers[@]}"; do
    if [ $num -gt 10 ]; then
        large_numbers+=($num)
    fi
done
echo "Numbers > 10: ${large_numbers[@]}"

# PRACTICAL EXAMPLE 5: UNIQUE ELEMENTS

echo ""
echo "=== PRACTICAL EXAMPLE 5: UNIQUE ELEMENTS ==="

with_duplicates=(1 2 3 2 4 1 5 3 6)
echo "With duplicates: ${with_duplicates[@]}"

# Remove duplicates (using associative array internally)
declare -A seen
unique=()

for item in "${with_duplicates[@]}"; do
    if [ -z "${seen[$item]}" ]; then
        seen[$item]=1
        unique+=($item)
    fi
done

echo "Unique elements: ${unique[@]}"

# PRACTICAL EXAMPLE 6: STACK OPERATIONS

echo ""
echo "=== PRACTICAL EXAMPLE 6: STACK ==="

stack=()

# Push
push() {
    stack+=("$1")
    echo "Pushed: $1"
}

# Pop
pop() {
    if [ ${#stack[@]} -eq 0 ]; then
        echo "Stack is empty"
        return 1
    fi
    local last_index=$((${#stack[@]} - 1))
    local value="${stack[$last_index]}"
    unset stack[$last_index]
    echo "Popped: $value"
}

# Peek
peek() {
    if [ ${#stack[@]} -eq 0 ]; then
        echo "Stack is empty"
        return 1
    fi
    local last_index=$((${#stack[@]} - 1))
    echo "Top: ${stack[$last_index]}"
}

push "A"
push "B"
push "C"
echo "Stack: ${stack[@]}"
peek
pop
pop
echo "Stack: ${stack[@]}"

# PRACTICAL EXAMPLE 7: BATCH OPERATIONS

echo ""
echo "=== PRACTICAL EXAMPLE 7: BATCH OPERATIONS ==="

servers=("server1" "server2" "server3")
ports=(8080 8081 8082)

echo "Server configurations:"
for i in "${!servers[@]}"; do
    server="${servers[$i]}"
    port="${ports[$i]}"
    echo "  $server is running on port $port"
done

# ARRAY BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Always quote array expansions: "${array[@]}"
2. Use [@] to get all elements as separate words
3. Use [*] to get all elements as single word
4. Use local for arrays inside functions
5. Check array length before accessing
6. Use meaningful variable names
7. Initialize arrays before use
8. Be careful with spaces in array elements
9. Use appropriate loop type for your needs
10. Consider associative arrays for key-value pairs
'

# COMMON PITFALLS

echo ""
echo "=== COMMON PITFALLS ==="

test_array=("one" "two three" "four")

# WRONG: Without quotes
echo "Wrong (splits on spaces):"
for item in ${test_array[@]}; do
    echo "  - $item"
done

# CORRECT: With quotes
echo "Correct (preserves spaces):"
for item in "${test_array[@]}"; do
    echo "  - $item"
done

echo ""
echo "Arrays tutorial complete!"
