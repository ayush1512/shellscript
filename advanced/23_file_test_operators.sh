#!/bin/bash

# FILE TEST OPERATORS IN SHELL SCRIPTING
# Test conditions for files and directories
# Used extensively in conditional statements

# FILE TYPE TESTS

echo "=== FILE TYPE TESTS ==="

# Create test files
touch /tmp/regular_file.txt
mkdir /tmp/test_directory
ln -s /tmp/regular_file.txt /tmp/symlink_file

# -f : True if file exists and is a regular file
if [ -f /tmp/regular_file.txt ]; then
    echo "✓ /tmp/regular_file.txt is a regular file"
fi

# -d : True if file exists and is a directory
if [ -d /tmp/test_directory ]; then
    echo "✓ /tmp/test_directory is a directory"
fi

# -L : True if file exists and is a symbolic link
if [ -L /tmp/symlink_file ]; then
    echo "✓ /tmp/symlink_file is a symbolic link"
fi

# -e : True if file exists (any type)
if [ -e /tmp/regular_file.txt ]; then
    echo "✓ /tmp/regular_file.txt exists"
fi

# -b : True if file is a block device
if [ -b /dev/sda ] 2>/dev/null; then
    echo "✓ /dev/sda is a block device"
else
    echo "✗ /dev/sda is not a block device (or doesn't exist)"
fi

# -c : True if file is a character device
if [ -c /dev/null ]; then
    echo "✓ /dev/null is a character device"
fi

# -p : True if file is a named pipe (FIFO)
mkfifo /tmp/test_pipe 2>/dev/null
if [ -p /tmp/test_pipe ]; then
    echo "✓ /tmp/test_pipe is a named pipe"
fi

# -S : True if file is a socket
# Socket example would require creating one

# FILE PERMISSION TESTS

echo ""
echo "=== FILE PERMISSION TESTS ==="

# Create test file
echo "test content" > /tmp/perm_test.txt
chmod 644 /tmp/perm_test.txt

# -r : True if file is readable
if [ -r /tmp/perm_test.txt ]; then
    echo "✓ File is readable"
fi

# -w : True if file is writable
if [ -w /tmp/perm_test.txt ]; then
    echo "✓ File is writable"
fi

# -x : True if file is executable
chmod +x /tmp/perm_test.txt
if [ -x /tmp/perm_test.txt ]; then
    echo "✓ File is executable"
fi

# -u : True if file has SUID bit set
chmod u+s /tmp/perm_test.txt 2>/dev/null
if [ -u /tmp/perm_test.txt ]; then
    echo "✓ File has SUID bit"
else
    echo "✗ File doesn't have SUID bit (may need privileges)"
fi

# -g : True if file has SGID bit set
# Similar to SUID

# -k : True if file has sticky bit set
# Commonly used on directories like /tmp

# FILE SIZE AND AGE TESTS

echo ""
echo "=== FILE SIZE AND AGE TESTS ==="

# -s : True if file exists and has size greater than zero
echo "non-empty" > /tmp/nonempty.txt
if [ -s /tmp/nonempty.txt ]; then
    echo "✓ File is non-empty"
fi

touch /tmp/empty.txt
if [ ! -s /tmp/empty.txt ]; then
    echo "✓ File is empty"
fi

# FILE COMPARISON TESTS

echo ""
echo "=== FILE COMPARISON TESTS ==="

# Create test files
echo "v1" > /tmp/file1.txt
sleep 1
echo "v2" > /tmp/file2.txt

# -nt : True if file1 is newer than file2
if [ /tmp/file2.txt -nt /tmp/file1.txt ]; then
    echo "✓ file2.txt is newer than file1.txt"
fi

# -ot : True if file1 is older than file2
if [ /tmp/file1.txt -ot /tmp/file2.txt ]; then
    echo "✓ file1.txt is older than file2.txt"
fi

# -ef : True if files have same device and inode (hard links)
ln /tmp/file1.txt /tmp/hardlink.txt 2>/dev/null
if [ /tmp/file1.txt -ef /tmp/hardlink.txt ]; then
    echo "✓ file1.txt and hardlink.txt are the same file"
fi

# FILE OWNERSHIP TESTS

echo ""
echo "=== FILE OWNERSHIP TESTS ==="

# -O : True if file is owned by effective UID
touch /tmp/owned_file.txt
if [ -O /tmp/owned_file.txt ]; then
    echo "✓ File is owned by current user"
fi

# -G : True if file is owned by effective GID
if [ -G /tmp/owned_file.txt ]; then
    echo "✓ File belongs to current group"
fi

# COMBINING FILE TESTS

echo ""
echo "=== COMBINING TESTS ==="

# Using && (AND)
if [ -f /tmp/file1.txt ] && [ -r /tmp/file1.txt ]; then
    echo "✓ File exists and is readable"
fi

# Using || (OR)
if [ -f /tmp/file1.txt ] || [ -d /tmp/file1.txt ]; then
    echo "✓ Path exists as file or directory"
fi

# Using ! (NOT)
if [ ! -f /tmp/nonexistent.txt ]; then
    echo "✓ File does not exist"
fi

# Using [[ ]] for complex conditions
if [[ -f /tmp/file1.txt && -r /tmp/file1.txt && -w /tmp/file1.txt ]]; then
    echo "✓ File exists and is readable and writable"
fi

# PRACTICAL EXAMPLE 1: FILE VALIDATION

echo ""
echo "=== PRACTICAL EXAMPLE 1: FILE VALIDATION ==="

validate_file() {
    local file=$1
    
    echo "Validating: $file"
    
    # Check existence
    if [ ! -e "$file" ]; then
        echo "  ✗ File does not exist"
        return 1
    fi
    
    # Check if regular file
    if [ ! -f "$file" ]; then
        echo "  ✗ Not a regular file"
        return 2
    fi
    
    # Check if readable
    if [ ! -r "$file" ]; then
        echo "  ✗ File is not readable"
        return 3
    fi
    
    # Check if not empty
    if [ ! -s "$file" ]; then
        echo "  ⚠ File is empty"
    fi
    
    echo "  ✓ File is valid"
    return 0
}

validate_file "/etc/passwd"
validate_file "/tmp/nonempty.txt"
validate_file "/tmp/nonexistent.txt"

# PRACTICAL EXAMPLE 2: SAFE FILE OPERATIONS

echo ""
echo "=== PRACTICAL EXAMPLE 2: SAFE FILE OPERATIONS ==="

safe_copy() {
    local source=$1
    local dest=$2
    
    # Check if source exists
    if [ ! -f "$source" ]; then
        echo "Error: Source file not found: $source"
        return 1
    fi
    
    # Check if source is readable
    if [ ! -r "$source" ]; then
        echo "Error: Source file is not readable"
        return 2
    fi
    
    # Check if destination exists
    if [ -e "$dest" ]; then
        echo "Warning: Destination exists, creating backup..."
        cp "$dest" "${dest}.bak"
    fi
    
    # Check if destination directory is writable
    local dest_dir=$(dirname "$dest")
    if [ ! -w "$dest_dir" ]; then
        echo "Error: Destination directory is not writable"
        return 3
    fi
    
    # Perform copy
    cp "$source" "$dest"
    echo "Copied successfully"
    return 0
}

safe_copy "/tmp/file1.txt" "/tmp/copy_dest.txt"

# PRACTICAL EXAMPLE 3: DIRECTORY CHECKS

echo ""
echo "=== PRACTICAL EXAMPLE 3: DIRECTORY CHECKS ==="

check_directory() {
    local dir=$1
    
    echo "Checking: $dir"
    
    # Exists and is directory
    if [ -d "$dir" ]; then
        echo "  ✓ Is a directory"
    else
        echo "  ✗ Not a directory or doesn't exist"
        return 1
    fi
    
    # Readable
    if [ -r "$dir" ]; then
        echo "  ✓ Readable"
    else
        echo "  ✗ Not readable"
    fi
    
    # Writable
    if [ -w "$dir" ]; then
        echo "  ✓ Writable"
    else
        echo "  ✗ Not writable"
    fi
    
    # Executable (can cd into it)
    if [ -x "$dir" ]; then
        echo "  ✓ Executable (accessible)"
    else
        echo "  ✗ Not accessible"
    fi
    
    return 0
}

check_directory "/tmp"
check_directory "/root"

# PRACTICAL EXAMPLE 4: FILE AGE CHECK

echo ""
echo "=== PRACTICAL EXAMPLE 4: FILE AGE CHECK ==="

check_file_age() {
    local file=$1
    local max_age_days=${2:-7}
    
    if [ ! -f "$file" ]; then
        echo "File not found"
        return 1
    fi
    
    local file_age=$(find "$file" -mtime +$max_age_days -print)
    
    if [ -n "$file_age" ]; then
        echo "File is older than $max_age_days days"
        return 0
    else
        echo "File is within $max_age_days days"
        return 1
    fi
}

# Create old file
touch -d "10 days ago" /tmp/old_file.txt
check_file_age "/tmp/old_file.txt" 7

# PRACTICAL EXAMPLE 5: BACKUP VALIDATION

echo ""
echo "=== PRACTICAL EXAMPLE 5: BACKUP VALIDATION ==="

validate_backup() {
    local original=$1
    local backup=$2
    
    # Both must exist
    if [ ! -f "$original" ] || [ ! -f "$backup" ]; then
        echo "Error: One or both files don't exist"
        return 1
    fi
    
    # Backup must not be older than original
    if [ "$backup" -ot "$original" ]; then
        echo "Warning: Backup is older than original"
        return 2
    fi
    
    # Compare sizes
    local orig_size=$(stat -c%s "$original")
    local back_size=$(stat -c%s "$backup")
    
    if [ $orig_size -ne $back_size ]; then
        echo "Warning: File sizes differ"
        return 3
    fi
    
    echo "Backup is valid"
    return 0
}

echo "test" > /tmp/original.txt
cp /tmp/original.txt /tmp/backup.txt
validate_backup "/tmp/original.txt" "/tmp/backup.txt"

# PRACTICAL EXAMPLE 6: CONFIG FILE CHECK

echo ""
echo "=== PRACTICAL EXAMPLE 6: CONFIG FILE CHECK ==="

check_config() {
    local config_file=$1
    
    # Must exist
    if [ ! -f "$config_file" ]; then
        echo "Config file not found: $config_file"
        return 1
    fi
    
    # Must be readable
    if [ ! -r "$config_file" ]; then
        echo "Config file is not readable"
        return 2
    fi
    
    # Should not be writable by others
    local perms=$(stat -c%a "$config_file")
    if [ ${perms:2:1} -ne 0 ]; then
        echo "Warning: Config file is world-writable"
        return 3
    fi
    
    # Should not be empty
    if [ ! -s "$config_file" ]; then
        echo "Warning: Config file is empty"
        return 4
    fi
    
    echo "Config file is valid"
    return 0
}

echo "setting=value" > /tmp/config.conf
chmod 644 /tmp/config.conf
check_config "/tmp/config.conf"

# PRACTICAL EXAMPLE 7: COMPREHENSIVE FILE INFO

echo ""
echo "=== PRACTICAL EXAMPLE 7: FILE INFO ==="

file_info() {
    local file=$1
    
    if [ ! -e "$file" ]; then
        echo "File does not exist"
        return 1
    fi
    
    echo "File Information: $file"
    echo "===================="
    
    # Type
    if [ -f "$file" ]; then echo "Type: Regular file"
    elif [ -d "$file" ]; then echo "Type: Directory"
    elif [ -L "$file" ]; then echo "Type: Symbolic link"
    elif [ -p "$file" ]; then echo "Type: Named pipe"
    elif [ -S "$file" ]; then echo "Type: Socket"
    elif [ -b "$file" ]; then echo "Type: Block device"
    elif [ -c "$file" ]; then echo "Type: Character device"
    fi
    
    # Permissions
    echo "Permissions:"
    [ -r "$file" ] && echo "  ✓ Readable" || echo "  ✗ Not readable"
    [ -w "$file" ] && echo "  ✓ Writable" || echo "  ✗ Not writable"
    [ -x "$file" ] && echo "  ✓ Executable" || echo "  ✗ Not executable"
    
    # Size
    if [ -f "$file" ]; then
        [ -s "$file" ] && echo "Size: Non-empty" || echo "Size: Empty"
    fi
    
    # Ownership
    [ -O "$file" ] && echo "Owned by: Current user"
    [ -G "$file" ] && echo "Group: Current user's group"
}

file_info "/tmp/file1.txt"

# CLEANUP

echo ""
echo "=== CLEANUP ==="

rm -f /tmp/regular_file.txt /tmp/symlink_file /tmp/perm_test.txt
rm -f /tmp/nonempty.txt /tmp/empty.txt /tmp/file1.txt /tmp/file2.txt
rm -f /tmp/hardlink.txt /tmp/owned_file.txt /tmp/copy_dest.txt
rm -f /tmp/old_file.txt /tmp/original.txt /tmp/backup.txt /tmp/config.conf
rm -rf /tmp/test_directory
rm -f /tmp/test_pipe

echo "Cleanup complete"

echo ""
echo "File test operators tutorial complete!"
