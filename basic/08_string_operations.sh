#!/bin/bash

# STRING OPERATIONS IN SHELL SCRIPTING
# Various ways to manipulate and work with strings

# STRING DECLARATION
str1="Hello"
str2="World"
str3="Hello World"
empty=""

echo "=== STRING BASICS ==="
echo "str1: $str1"
echo "str2: $str2"
echo "str3: $str3"

# STRING LENGTH
# Syntax: ${#string}
echo ""
echo "=== STRING LENGTH ==="
echo "Length of str1: ${#str1}"
echo "Length of str3: ${#str3}"
echo "Length of empty: ${#empty}"

# STRING CONCATENATION
echo ""
echo "=== STRING CONCATENATION ==="

# Method 1: Direct concatenation
concat1="$str1$str2"
echo "Direct: $concat1"

# Method 2: With space
concat2="$str1 $str2"
echo "With space: $concat2"

# Method 3: Appending to existing string
result="Hello"
result="$result World"
echo "Appending: $result"

# Method 4: Using +=
greeting="Hello"
greeting+=" World"
echo "Using +=: $greeting"

# STRING EXTRACTION (Substring)
# Syntax: ${string:position:length}
# position: starting index (0-based)
# length: number of characters to extract

echo ""
echo "=== SUBSTRING EXTRACTION ==="
text="Hello World"
echo "Original: $text"

# Extract from position 0, length 5
echo "First 5 chars: ${text:0:5}"

# Extract from position 6
echo "From position 6: ${text:6}"

# Extract from position 6, length 5
echo "From position 6, length 5: ${text:6:5}"

# Negative index (from end)
echo "Last 5 chars: ${text: -5}"
echo "Last char: ${text: -1}"

# STRING REPLACEMENT
# Syntax: ${string/pattern/replacement}
# / : Replace first occurrence
# // : Replace all occurrences

echo ""
echo "=== STRING REPLACEMENT ==="
sentence="I love cats and cats are great"
echo "Original: $sentence"

# Replace first occurrence
echo "Replace first 'cats': ${sentence/cats/dogs}"

# Replace all occurrences
echo "Replace all 'cats': ${sentence//cats/dogs}"

# Replace at beginning
# Syntax: ${string/#pattern/replacement}
echo "Replace at start: ${sentence/#I/You}"

# Replace at end
# Syntax: ${string/%pattern/replacement}
echo "Replace at end: ${sentence/%great/awesome}"

# STRING DELETION
# Syntax: ${string/pattern}
# Removes the pattern from string

echo ""
echo "=== STRING DELETION ==="
path="/home/user/documents/file.txt"
echo "Original path: $path"

# Delete first occurrence
echo "Delete first '/': ${path/\//}"

# Delete all occurrences
echo "Delete all '/': ${path//\//}"

# STRING TRIMMING

echo ""
echo "=== STRING TRIMMING ==="

# Remove from beginning
# Syntax: ${string#pattern}  - shortest match
# Syntax: ${string##pattern} - longest match
filename="backup.tar.gz"
echo "Filename: $filename"
echo "Remove shortest .* from start: ${filename#*.}"
echo "Remove longest .* from start: ${filename##*.}"

# Remove from end
# Syntax: ${string%pattern}  - shortest match
# Syntax: ${string%%pattern} - longest match
echo "Remove shortest .* from end: ${filename%.*}"
echo "Remove longest .* from end: ${filename%%.*}"

# Practical example: extract file extension
echo "Extension: ${filename##*.}"

# Practical example: remove extension
echo "Name without extension: ${filename%.*}"

# STRING CASE CONVERSION

echo ""
echo "=== CASE CONVERSION ==="
mixed="Hello World"
echo "Original: $mixed"

# Convert to uppercase
echo "Uppercase: ${mixed^^}"

# Convert to lowercase
echo "Lowercase: ${mixed,,}"

# Convert first character to uppercase
echo "Capitalize first: ${mixed^}"

# Convert first character to lowercase
echo "Lowercase first: ${mixed,}"

# Convert specific pattern
text="hello world"
echo "Uppercase 'o': ${text^^o}"

# STRING COMPARISON
echo ""
echo "=== STRING COMPARISON ==="
str_a="apple"
str_b="banana"

# Equality
if [ "$str_a" = "$str_b" ]; then
    echo "Strings are equal"
else
    echo "Strings are not equal"
fi

# Lexicographic comparison
if [[ "$str_a" < "$str_b" ]]; then
    echo "$str_a comes before $str_b"
fi

# Pattern matching
if [[ "$str_a" == app* ]]; then
    echo "$str_a starts with 'app'"
fi

# Contains substring
if [[ "$str_a" == *pp* ]]; then
    echo "$str_a contains 'pp'"
fi

# STRING SPLITTING
echo ""
echo "=== STRING SPLITTING ==="
csv="apple,banana,orange,grape"
echo "CSV: $csv"

# Using IFS (Internal Field Separator)
IFS=',' read -ra fruits <<< "$csv"
echo "Split into array:"
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done

# DEFAULT VALUES
echo ""
echo "=== DEFAULT VALUES ==="

# If variable is unset or empty, use default
# Syntax: ${variable:-default}
echo "Undefined var: ${undefined_var:-default_value}"

# Set variable if unset
# Syntax: ${variable:=default}
echo "Setting default: ${new_var:=default_value}"
echo "new_var is now: $new_var"

# Error if variable is unset
# Syntax: ${variable:?error_message}
# required_var=${required_var:?This variable is required}

# Use alternative value if variable is set
# Syntax: ${variable:+alternative}
set_var="value"
echo "Alternative: ${set_var:+variable_is_set}"

# PRACTICAL EXAMPLES

echo ""
echo "=== PRACTICAL EXAMPLES ==="

# Extract filename from path
full_path="/home/user/documents/report.pdf"
filename="${full_path##*/}"
echo "Filename: $filename"

# Extract directory from path
directory="${full_path%/*}"
echo "Directory: $directory"

# Extract base name (without extension)
basename="${filename%.*}"
echo "Base name: $basename"

# Extract extension
extension="${filename##*.}"
echo "Extension: $extension"

# URL parsing
url="https://www.example.com:8080/path/to/page.html"
protocol="${url%%://*}"
echo "Protocol: $protocol"

# Remove protocol
without_protocol="${url#*://}"
echo "Without protocol: $without_protocol"

# Padding strings
number="42"
padded=$(printf "%05d" $number)
echo "Padded number: $padded"

# Check if string starts with pattern
text="Hello World"
if [[ $text == Hello* ]]; then
    echo "Text starts with 'Hello'"
fi

# Check if string ends with pattern
if [[ $text == *World ]]; then
    echo "Text ends with 'World'"
fi
