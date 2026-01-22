#!/bin/bash

# FILE OPERATIONS IN SHELL SCRIPTING
# Various operations for working with files

# CREATING FILES

echo "=== CREATING FILES ==="

# Method 1: Using touch
touch /tmp/test1.txt
echo "Created with touch: /tmp/test1.txt"

# Method 2: Using echo with redirection
echo "Hello World" > /tmp/test2.txt
echo "Created with echo: /tmp/test2.txt"

# Method 3: Using cat with heredoc
cat > /tmp/test3.txt << 'EOF'
Line 1
Line 2
Line 3
EOF
echo "Created with cat: /tmp/test3.txt"

# Method 4: Using printf
printf "Name: %s\nAge: %d\n" "John" 30 > /tmp/test4.txt
echo "Created with printf: /tmp/test4.txt"

# READING FILES

echo ""
echo "=== READING FILES ==="

# Method 1: Using cat
echo "Reading with cat:"
cat /tmp/test2.txt

# Method 2: Using while read loop
echo "Reading with while loop:"
while IFS= read -r line; do
    echo "  Line: $line"
done < /tmp/test3.txt

# Method 3: Read entire file into variable
content=$(<  /tmp/test2.txt)
echo "File content: $content"

# Method 4: Read line by line into array
mapfile -t lines < /tmp/test3.txt
echo "Number of lines: ${#lines[@]}"

# WRITING TO FILES

echo ""
echo "=== WRITING TO FILES ==="

# Overwrite file (>)
echo "New content" > /tmp/write_test.txt
echo "Written to file (overwrite)"

# Append to file (>>)
echo "Additional line" >> /tmp/write_test.txt
echo "Appended to file"

cat /tmp/write_test.txt

# COPYING FILES

echo ""
echo "=== COPYING FILES ==="

# Copy file
cp /tmp/test1.txt /tmp/test1_copy.txt
echo "Copied test1.txt to test1_copy.txt"

# Copy with preserve attributes
cp -p /tmp/test2.txt /tmp/test2_copy.txt
echo "Copied with preserved attributes"

# Copy multiple files
cp /tmp/test1.txt /tmp/test2.txt /tmp/backup/
echo "Copied multiple files (would need backup dir)"

# MOVING/RENAMING FILES

echo ""
echo "=== MOVING/RENAMING FILES ==="

# Rename file
mv /tmp/test1_copy.txt /tmp/renamed.txt 2>/dev/null
echo "Renamed file"

# Move file
mkdir -p /tmp/moved_files
mv /tmp/test2_copy.txt /tmp/moved_files/ 2>/dev/null
echo "Moved file to different directory"

# DELETING FILES

echo ""
echo "=== DELETING FILES ==="

# Delete single file
rm -f /tmp/renamed.txt
echo "Deleted file"

# Delete multiple files
rm -f /tmp/test1.txt /tmp/test2.txt /tmp/test3.txt /tmp/test4.txt
echo "Deleted multiple files"

# Delete with pattern
rm -f /tmp/test*.txt 2>/dev/null
echo "Deleted files matching pattern"

# CHECKING FILE EXISTENCE

echo ""
echo "=== CHECKING FILE EXISTENCE ==="

# Check if file exists
if [ -f "/etc/passwd" ]; then
    echo "/etc/passwd exists"
fi

# Check if file doesn't exist
if [ ! -f "/tmp/nonexistent.txt" ]; then
    echo "/tmp/nonexistent.txt does not exist"
fi

# FILE PROPERTIES

echo ""
echo "=== FILE PROPERTIES ==="

test_file="/etc/passwd"

# File size
size=$(stat -c%s "$test_file" 2>/dev/null)
echo "Size: $size bytes"

# Last modified time
mtime=$(stat -c%y "$test_file" 2>/dev/null)
echo "Last modified: $mtime"

# File type
file_type=$(file -b "$test_file" 2>/dev/null)
echo "Type: $file_type"

# File permissions
perms=$(stat -c%A "$test_file" 2>/dev/null)
echo "Permissions: $perms"

# File owner
owner=$(stat -c%U "$test_file" 2>/dev/null)
echo "Owner: $owner"

# COMPARING FILES

echo ""
echo "=== COMPARING FILES ==="

# Create test files
echo "content1" > /tmp/file1.txt
echo "content1" > /tmp/file2.txt
echo "content2" > /tmp/file3.txt

# Compare files
if cmp -s /tmp/file1.txt /tmp/file2.txt; then
    echo "file1 and file2 are identical"
fi

if ! cmp -s /tmp/file1.txt /tmp/file3.txt; then
    echo "file1 and file3 are different"
fi

# Show differences
diff /tmp/file1.txt /tmp/file3.txt || true

# FINDING FILES

echo ""
echo "=== FINDING FILES ==="

# Find files by name
echo "Shell scripts in current directory:"
find /home/runner/work/shellscript/shellscript -name "*.sh" -type f | head -5

# Find files modified in last day
echo "Recently modified:"
find /tmp -name "*.txt" -mtime -1 -type f 2>/dev/null | head -5

# Find files by size
echo "Large files (>1MB):"
find /tmp -size +1M -type f 2>/dev/null | head -3

# FILE PERMISSIONS

echo ""
echo "=== FILE PERMISSIONS ==="

# Create test file
touch /tmp/perm_test.txt

# Set permissions using chmod
chmod 644 /tmp/perm_test.txt
echo "Set permissions to 644"

# Make executable
chmod +x /tmp/perm_test.txt
echo "Made executable"

# Remove write permission
chmod -w /tmp/perm_test.txt
echo "Removed write permission"

# Restore permissions
chmod 644 /tmp/perm_test.txt

# FILE LINKS

echo ""
echo "=== FILE LINKS ==="

# Create file
echo "Original content" > /tmp/original.txt

# Create hard link
ln /tmp/original.txt /tmp/hardlink.txt 2>/dev/null
echo "Created hard link"

# Create symbolic link
ln -s /tmp/original.txt /tmp/symlink.txt
echo "Created symbolic link"

# Check if symlink
if [ -L /tmp/symlink.txt ]; then
    echo "/tmp/symlink.txt is a symbolic link"
fi

# PRACTICAL EXAMPLE 1: FILE BACKUP

echo ""
echo "=== PRACTICAL EXAMPLE 1: FILE BACKUP ==="

backup_file() {
    local source=$1
    local backup_dir="/tmp/backups"
    
    mkdir -p "$backup_dir"
    
    if [ -f "$source" ]; then
        local filename=$(basename "$source")
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup="$backup_dir/${filename}.${timestamp}.bak"
        
        cp "$source" "$backup"
        echo "Backed up $source to $backup"
        return 0
    else
        echo "Source file not found: $source"
        return 1
    fi
}

# Create test file and backup
echo "Test content" > /tmp/important.txt
backup_file /tmp/important.txt

# PRACTICAL EXAMPLE 2: FILE ROTATION

echo ""
echo "=== PRACTICAL EXAMPLE 2: LOG ROTATION ==="

rotate_log() {
    local logfile=$1
    local max_versions=3
    
    if [ ! -f "$logfile" ]; then
        echo "Log file not found"
        return 1
    fi
    
    # Rotate existing logs
    for ((i=max_versions-1; i>=1; i--)); do
        if [ -f "${logfile}.${i}" ]; then
            mv "${logfile}.${i}" "${logfile}.$((i+1))"
        fi
    done
    
    # Move current log
    mv "$logfile" "${logfile}.1"
    
    # Create new empty log
    touch "$logfile"
    
    echo "Log rotated"
}

# Create and rotate log
echo "Log entry 1" > /tmp/app.log
rotate_log /tmp/app.log
echo "New log entry" > /tmp/app.log

# PRACTICAL EXAMPLE 3: FILE VALIDATION

echo ""
echo "=== PRACTICAL EXAMPLE 3: FILE VALIDATION ==="

validate_file() {
    local file=$1
    
    # Check existence
    if [ ! -f "$file" ]; then
        echo "Error: File does not exist"
        return 1
    fi
    
    # Check if readable
    if [ ! -r "$file" ]; then
        echo "Error: File is not readable"
        return 2
    fi
    
    # Check if not empty
    if [ ! -s "$file" ]; then
        echo "Error: File is empty"
        return 3
    fi
    
    echo "File is valid"
    return 0
}

validate_file "/etc/passwd"
validate_file "/tmp/nonexistent.txt"

# PRACTICAL EXAMPLE 4: BATCH FILE PROCESSING

echo ""
echo "=== PRACTICAL EXAMPLE 4: BATCH PROCESSING ==="

process_files() {
    local pattern=$1
    local operation=$2
    
    for file in $pattern; do
        if [ -f "$file" ]; then
            case $operation in
                count)
                    lines=$(wc -l < "$file")
                    echo "$file: $lines lines"
                    ;;
                size)
                    size=$(stat -c%s "$file")
                    echo "$file: $size bytes"
                    ;;
                *)
                    echo "Unknown operation"
                    ;;
            esac
        fi
    done
}

# Create test files
for i in {1..3}; do
    echo "Line 1" > "/tmp/batch_$i.txt"
    echo "Line 2" >> "/tmp/batch_$i.txt"
done

process_files "/tmp/batch_*.txt" "count"

# PRACTICAL EXAMPLE 5: FILE MONITORING

echo ""
echo "=== PRACTICAL EXAMPLE 5: FILE MONITORING ==="

monitor_file_changes() {
    local file=$1
    local interval=2
    local iterations=3
    
    if [ ! -f "$file" ]; then
        echo "File not found"
        return 1
    fi
    
    echo "Monitoring $file..."
    local last_size=$(stat -c%s "$file")
    
    for ((i=1; i<=iterations; i++)); do
        sleep $interval
        
        if [ -f "$file" ]; then
            local current_size=$(stat -c%s "$file")
            
            if [ $current_size -ne $last_size ]; then
                echo "File changed! Old: $last_size, New: $current_size"
                last_size=$current_size
            else
                echo "No changes detected"
            fi
        else
            echo "File no longer exists"
            break
        fi
    done
}

# Create and monitor file (would need background process for real monitoring)
echo "Initial content" > /tmp/monitor.txt
# monitor_file_changes /tmp/monitor.txt  # Commented for speed

# PRACTICAL EXAMPLE 6: FILE SORTING

echo ""
echo "=== PRACTICAL EXAMPLE 6: FILE SORTING ==="

sort_files_by_size() {
    local dir=${1:-.}
    
    echo "Files sorted by size:"
    find "$dir" -maxdepth 1 -type f -exec ls -lh {} \; 2>/dev/null | \
        sort -k5 -h | head -5
}

sort_files_by_size /tmp

# CLEANUP

echo ""
echo "=== CLEANUP ==="

# Clean up test files
rm -f /tmp/test*.txt /tmp/write_test.txt /tmp/file*.txt
rm -f /tmp/perm_test.txt /tmp/original.txt /tmp/hardlink.txt /tmp/symlink.txt
rm -f /tmp/important.txt /tmp/app.log* /tmp/batch_*.txt /tmp/monitor.txt
rm -rf /tmp/moved_files /tmp/backups

echo "Cleanup complete"

echo ""
echo "File operations tutorial complete!"
