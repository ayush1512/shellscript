#!/bin/bash

# DIRECTORY OPERATIONS IN SHELL SCRIPTING
# Working with directories, navigation, and management

# CREATING DIRECTORIES

echo "=== CREATING DIRECTORIES ==="

# Create single directory
mkdir /tmp/test_dir
echo "Created: /tmp/test_dir"

# Create parent directories (-p flag)
mkdir -p /tmp/parent/child/grandchild
echo "Created nested: /tmp/parent/child/grandchild"

# Create multiple directories
mkdir /tmp/dir1 /tmp/dir2 /tmp/dir3
echo "Created multiple directories"

# Create with permissions
mkdir -m 755 /tmp/perm_dir
echo "Created with permissions: /tmp/perm_dir"

# CHECKING DIRECTORY EXISTENCE

echo ""
echo "=== CHECKING DIRECTORY EXISTENCE ==="

# Check if directory exists
if [ -d "/tmp" ]; then
    echo "/tmp exists"
fi

# Check if doesn't exist
if [ ! -d "/nonexistent" ]; then
    echo "/nonexistent does not exist"
fi

# LISTING DIRECTORIES

echo ""
echo "=== LISTING DIRECTORIES ==="

# List current directory
echo "Contents of /tmp (first 10):"
ls /tmp | head -10

# List with details
echo "Detailed listing:"
ls -lh /tmp | head -5

# List only directories
echo "Only directories:"
ls -d /tmp/*/ 2>/dev/null | head -5

# List hidden files
echo "Including hidden:"
ls -a /tmp | head -5

# NAVIGATING DIRECTORIES

echo ""
echo "=== NAVIGATING DIRECTORIES ==="

# Save current directory
original_dir=$(pwd)
echo "Current directory: $original_dir"

# Change directory
cd /tmp
echo "Changed to: $(pwd)"

# Go to previous directory
cd - > /dev/null
echo "Back to: $(pwd)"

# Go to home directory
cd ~
echo "Home directory: $(pwd)"

# Return to original
cd "$original_dir"
echo "Returned to: $(pwd)"

# COPYING DIRECTORIES

echo ""
echo "=== COPYING DIRECTORIES ==="

# Create source directory with files
mkdir -p /tmp/source_dir
echo "file1" > /tmp/source_dir/file1.txt
echo "file2" > /tmp/source_dir/file2.txt

# Copy directory
cp -r /tmp/source_dir /tmp/copied_dir
echo "Copied directory"

# Copy with preserve attributes
cp -rp /tmp/source_dir /tmp/copied_preserve
echo "Copied with preserved attributes"

# MOVING/RENAMING DIRECTORIES

echo ""
echo "=== MOVING/RENAMING DIRECTORIES ==="

# Rename directory
mv /tmp/copied_dir /tmp/renamed_dir 2>/dev/null
echo "Renamed directory"

# Move directory
mkdir -p /tmp/destination
mv /tmp/copied_preserve /tmp/destination/ 2>/dev/null
echo "Moved directory"

# DELETING DIRECTORIES

echo ""
echo "=== DELETING DIRECTORIES ==="

# Remove empty directory
mkdir /tmp/empty_dir
rmdir /tmp/empty_dir
echo "Removed empty directory"

# Remove directory with contents
rm -rf /tmp/test_dir
echo "Removed directory with contents"

# Remove multiple directories
rm -rf /tmp/dir1 /tmp/dir2 /tmp/dir3
echo "Removed multiple directories"

# DIRECTORY SIZE

echo ""
echo "=== DIRECTORY SIZE ==="

# Get directory size
size=$(du -sh /tmp 2>/dev/null | cut -f1)
echo "/tmp size: $size"

# Detailed size of subdirectories
echo "Top subdirectories by size:"
du -h --max-depth=1 /tmp 2>/dev/null | sort -hr | head -5

# DIRECTORY PERMISSIONS

echo ""
echo "=== DIRECTORY PERMISSIONS ==="

# Create test directory
mkdir /tmp/perm_test

# Set permissions
chmod 755 /tmp/perm_test
echo "Set permissions to 755"

# Check permissions
perms=$(stat -c%a /tmp/perm_test)
echo "Current permissions: $perms"

# Change owner (requires root, will fail gracefully)
# chown user:group /tmp/perm_test

# FINDING DIRECTORIES

echo ""
echo "=== FINDING DIRECTORIES ==="

# Find directories by name
echo "Directories named 'bin':"
find /usr -name "bin" -type d 2>/dev/null | head -3

# Find empty directories
echo "Empty directories in /tmp:"
find /tmp -type d -empty 2>/dev/null | head -3

# Find directories by permission
echo "Directories with 755 permissions:"
find /tmp -type d -perm 755 2>/dev/null | head -3

# DIRECTORY TREE

echo ""
echo "=== DIRECTORY TREE ==="

# Create a sample tree
mkdir -p /tmp/tree_test/{dir1,dir2,dir3}/{subdir1,subdir2}
touch /tmp/tree_test/dir1/file1.txt
touch /tmp/tree_test/dir2/subdir1/file2.txt

# List tree (if tree command available)
if command -v tree &> /dev/null; then
    tree /tmp/tree_test
else
    # Fallback using find
    find /tmp/tree_test -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
fi

# DIRECTORY COMPARISON

echo ""
echo "=== DIRECTORY COMPARISON ==="

# Create two directories
mkdir -p /tmp/dir_a /tmp/dir_b
echo "content1" > /tmp/dir_a/file1.txt
echo "content1" > /tmp/dir_b/file1.txt
echo "content2" > /tmp/dir_a/file2.txt

# Compare directories
echo "Comparing directories:"
diff -r /tmp/dir_a /tmp/dir_b || echo "Directories differ"

# DIRECTORY STACK

echo ""
echo "=== DIRECTORY STACK (pushd/popd) ==="

# Push directory onto stack
echo "Current: $(pwd)"
pushd /tmp > /dev/null
echo "Pushed to: $(pwd)"

pushd /etc > /dev/null
echo "Pushed to: $(pwd)"

# Show directory stack
echo "Directory stack: $(dirs)"

# Pop directory from stack
popd > /dev/null
echo "Popped to: $(pwd)"

popd > /dev/null
echo "Popped to: $(pwd)"

# PRACTICAL EXAMPLE 1: DIRECTORY BACKUP

echo ""
echo "=== PRACTICAL EXAMPLE 1: DIRECTORY BACKUP ==="

backup_directory() {
    local source=$1
    local backup_base="/tmp/backups"
    
    if [ ! -d "$source" ]; then
        echo "Source directory not found"
        return 1
    fi
    
    mkdir -p "$backup_base"
    local dirname=$(basename "$source")
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup="$backup_base/${dirname}_${timestamp}"
    
    cp -r "$source" "$backup"
    echo "Backed up $source to $backup"
    
    return 0
}

# Create and backup directory
mkdir -p /tmp/my_project
echo "data" > /tmp/my_project/data.txt
backup_directory /tmp/my_project

# PRACTICAL EXAMPLE 2: DIRECTORY CLEANUP

echo ""
echo "=== PRACTICAL EXAMPLE 2: CLEANUP OLD FILES ==="

cleanup_old_files() {
    local dir=$1
    local days=${2:-7}
    
    if [ ! -d "$dir" ]; then
        echo "Directory not found"
        return 1
    fi
    
    echo "Cleaning files older than $days days in $dir"
    
    # Find and delete old files
    find "$dir" -type f -mtime +$days -print -delete 2>/dev/null
    
    return 0
}

# Create old test files
mkdir -p /tmp/cleanup_test
touch -d "10 days ago" /tmp/cleanup_test/old_file.txt
touch /tmp/cleanup_test/new_file.txt

echo "Before cleanup:"
ls -l /tmp/cleanup_test

cleanup_old_files /tmp/cleanup_test 7

echo "After cleanup:"
ls -l /tmp/cleanup_test

# PRACTICAL EXAMPLE 3: DIRECTORY SYNCHRONIZATION

echo ""
echo "=== PRACTICAL EXAMPLE 3: DIRECTORY SYNC ==="

sync_directories() {
    local source=$1
    local destination=$2
    
    if [ ! -d "$source" ]; then
        echo "Source directory not found"
        return 1
    fi
    
    mkdir -p "$destination"
    
    # Copy only newer files
    rsync -av --update "$source/" "$destination/" 2>/dev/null || \
    cp -ru "$source/." "$destination/"
    
    echo "Synchronized $source to $destination"
}

mkdir -p /tmp/sync_source /tmp/sync_dest
echo "v1" > /tmp/sync_source/file.txt
sync_directories /tmp/sync_source /tmp/sync_dest

# PRACTICAL EXAMPLE 4: CREATE PROJECT STRUCTURE

echo ""
echo "=== PRACTICAL EXAMPLE 4: PROJECT STRUCTURE ==="

create_project() {
    local project_name=$1
    local base_dir="/tmp"
    local project_dir="$base_dir/$project_name"
    
    mkdir -p "$project_dir"/{src,tests,docs,config,data}
    
    # Create initial files
    touch "$project_dir/README.md"
    touch "$project_dir/.gitignore"
    touch "$project_dir/src/main.sh"
    touch "$project_dir/tests/test_main.sh"
    
    echo "Created project structure for: $project_name"
    
    # Show structure
    find "$project_dir" -print | sed -e 's;[^/]*/;  ;g'
}

create_project "my_shell_project"

# PRACTICAL EXAMPLE 5: DIRECTORY MONITORING

echo ""
echo "=== PRACTICAL EXAMPLE 5: DIRECTORY WATCH ==="

watch_directory() {
    local dir=$1
    local interval=2
    local iterations=3
    
    if [ ! -d "$dir" ]; then
        echo "Directory not found"
        return 1
    fi
    
    echo "Monitoring $dir for changes..."
    local last_count=$(find "$dir" -type f | wc -l)
    echo "Initial file count: $last_count"
    
    for ((i=1; i<=iterations; i++)); do
        sleep $interval
        local current_count=$(find "$dir" -type f | wc -l)
        
        if [ $current_count -ne $last_count ]; then
            echo "Change detected! Files: $last_count -> $current_count"
            last_count=$current_count
        else
            echo "No changes detected"
        fi
    done
}

# Would be used like: watch_directory /tmp/watch_test

# PRACTICAL EXAMPLE 6: DISK USAGE REPORT

echo ""
echo "=== PRACTICAL EXAMPLE 6: DISK USAGE REPORT ==="

directory_report() {
    local dir=$1
    
    if [ ! -d "$dir" ]; then
        echo "Directory not found"
        return 1
    fi
    
    echo "Directory Report for: $dir"
    echo "================================"
    echo "Total size: $(du -sh "$dir" 2>/dev/null | cut -f1)"
    echo "File count: $(find "$dir" -type f 2>/dev/null | wc -l)"
    echo "Directory count: $(find "$dir" -type d 2>/dev/null | wc -l)"
    echo "Largest files:"
    find "$dir" -type f -exec ls -lh {} \; 2>/dev/null | \
        sort -k5 -hr | head -3 | awk '{print "  " $9 " - " $5}'
}

directory_report /tmp

# CLEANUP

echo ""
echo "=== CLEANUP ==="

# Clean up all test directories
rm -rf /tmp/source_dir /tmp/renamed_dir /tmp/destination
rm -rf /tmp/parent /tmp/perm_dir /tmp/perm_test
rm -rf /tmp/tree_test /tmp/dir_a /tmp/dir_b
rm -rf /tmp/backups /tmp/my_project /tmp/cleanup_test
rm -rf /tmp/sync_source /tmp/sync_dest /tmp/my_shell_project

echo "Cleanup complete"

echo ""
echo "Directory operations tutorial complete!"
