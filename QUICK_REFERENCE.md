# Shell Scripting Quick Reference

## Quick Start

```bash
# Make script executable
chmod +x script.sh

# Run script
./script.sh

# Run with bash
bash script.sh
```

## Essential Syntax

### Variables
```bash
name="value"              # Assign
echo $name                # Access
echo ${name}              # Preferred
readonly CONST="value"    # Constant
```

### Conditionals
```bash
if [ condition ]; then
    commands
elif [ condition ]; then
    commands
else
    commands
fi
```

### Loops
```bash
# For loop
for i in {1..10}; do
    echo $i
done

# While loop
while [ condition ]; do
    commands
done

# Until loop
until [ condition ]; do
    commands
done
```

### Functions
```bash
function_name() {
    local var="value"
    echo "result"
    return 0
}

result=$(function_name)
```

### Arrays
```bash
# Indexed array
arr=(1 2 3 4 5)
echo ${arr[0]}
echo ${arr[@]}

# Associative array
declare -A map
map[key]="value"
```

## Common Operators

### Comparison (Numbers)
```bash
-eq    # Equal
-ne    # Not equal
-gt    # Greater than
-ge    # Greater or equal
-lt    # Less than
-le    # Less or equal
```

### Comparison (Strings)
```bash
=      # Equal
!=     # Not equal
-z     # Empty
-n     # Not empty
```

### File Tests
```bash
-f     # Regular file exists
-d     # Directory exists
-e     # Path exists
-r     # Readable
-w     # Writable
-x     # Executable
-s     # Not empty
```

### Logical Operators
```bash
&&     # AND
||     # OR
!      # NOT
```

## Input/Output

### Redirection
```bash
cmd > file         # Redirect stdout
cmd >> file        # Append stdout
cmd 2> file        # Redirect stderr
cmd > file 2>&1    # Redirect both
cmd < file         # Read from file
```

### Here Documents
```bash
cat << EOF
Multiple
Lines
EOF
```

### Pipes
```bash
cmd1 | cmd2        # Pipe output
cmd1 | tee file    # Save and display
```

## Common Patterns

### Error Handling
```bash
set -e             # Exit on error
set -u             # Error on undefined
set -o pipefail    # Pipe failure

trap cleanup EXIT  # Cleanup handler
```

### Loop Through Files
```bash
for file in *.txt; do
    echo "Processing $file"
done
```

### Read File Line by Line
```bash
while IFS= read -r line; do
    echo "$line"
done < file.txt
```

### Parse Arguments
```bash
while getopts "a:b:" opt; do
    case $opt in
        a) arg_a=$OPTARG ;;
        b) arg_b=$OPTARG ;;
    esac
done
```

### Check Command Exists
```bash
if command -v cmd &> /dev/null; then
    echo "cmd exists"
fi
```

## Debugging

```bash
set -x             # Print commands
bash -x script.sh  # Debug mode
shellcheck script.sh  # Static analysis
```

## Best Practices

1. ✅ Use `#!/bin/bash` shebang
2. ✅ Quote variables: `"$var"`
3. ✅ Use `local` in functions
4. ✅ Check exit codes
5. ✅ Handle errors
6. ✅ Add comments
7. ✅ Use meaningful names
8. ✅ Keep functions small
9. ✅ Test edge cases
10. ✅ Use shellcheck

## Useful Commands

```bash
grep pattern file      # Search
sed 's/old/new/' file  # Replace
awk '{print $1}' file  # Extract columns
cut -d: -f1 file       # Cut fields
sort file              # Sort
uniq file              # Remove duplicates
wc -l file             # Count lines
find . -name "*.sh"    # Find files
```

## Special Variables

```bash
$0     # Script name
$1-$9  # Arguments
$@     # All arguments
$#     # Argument count
$?     # Exit status
$$     # Process ID
$!     # Last background PID
```

## Directory Navigation

```bash
cd dir             # Change directory
pwd                # Print working dir
pushd dir          # Push to stack
popd               # Pop from stack
dirs               # Show stack
```

## File Operations

```bash
touch file         # Create file
cp src dest        # Copy
mv src dest        # Move
rm file            # Delete
mkdir dir          # Create directory
rmdir dir          # Remove directory
```

## Permission Management

```bash
chmod 755 file     # Set permissions
chmod +x file      # Make executable
chown user file    # Change owner
chgrp group file   # Change group
```

## Process Management

```bash
cmd &              # Run in background
jobs               # List jobs
fg %1              # Foreground job
bg %1              # Background job
kill PID           # Kill process
killall name       # Kill by name
```

---

For complete examples and explanations, see the tutorial scripts in:
- `basic/` - Fundamental concepts
- `intermediate/` - Control structures
- `advanced/` - Advanced techniques
