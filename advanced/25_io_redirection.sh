#!/bin/bash

# INPUT/OUTPUT REDIRECTION IN SHELL SCRIPTING
# Control where input comes from and output goes to

# STANDARD STREAMS
# stdin (0)  - Standard input
# stdout (1) - Standard output
# stderr (2) - Standard error

echo "=== STANDARD STREAMS ==="
echo "stdin (0)  - Standard input"
echo "stdout (1) - Standard output"
echo "stderr (2) - Standard error"

# OUTPUT REDIRECTION

echo ""
echo "=== OUTPUT REDIRECTION ==="

# Redirect stdout to file (overwrite)
echo "Hello World" > /tmp/output.txt
echo "Written to file with >"
cat /tmp/output.txt

# Redirect stdout to file (append)
echo "Second line" >> /tmp/output.txt
echo "Appended to file with >>"
cat /tmp/output.txt

# Redirect stderr to file
ls /nonexistent 2> /tmp/errors.txt 2>&1
echo "Errors redirected to file"
cat /tmp/errors.txt 2>/dev/null || echo "(No errors)"

# Redirect both stdout and stderr
ls /tmp /nonexistent > /tmp/combined.txt 2>&1
echo "Both streams redirected"

# INPUT REDIRECTION

echo ""
echo "=== INPUT REDIRECTION ==="

# Create input file
cat > /tmp/input.txt << 'EOF'
line1
line2
line3
EOF

# Read from file
echo "Reading from file:"
while read -r line; do
    echo "  Read: $line"
done < /tmp/input.txt

# HERE DOCUMENT (<<)
# Multi-line input

echo ""
echo "=== HERE DOCUMENT ==="

cat << 'EOF'
This is a here document
Multiple lines can be written
Without escaping quotes or special chars
EOF

# Here document with variable expansion
name="John"
cat << EOF
Hello, $name
Current directory: $(pwd)
EOF

# Here document without variable expansion (quoted delimiter)
cat << 'EOF'
Name variable: $name (not expanded)
Command: $(pwd) (not executed)
EOF

# HERE STRING (<<<)
# Single-line input

echo ""
echo "=== HERE STRING ==="

# Pass string as input
read -r var1 var2 var3 <<< "one two three"
echo "var1=$var1, var2=$var2, var3=$var3"

# Use with command
grep "o" <<< "hello world"

# FILE DESCRIPTORS

echo ""
echo "=== FILE DESCRIPTORS ==="

# Open file for reading (fd 3)
exec 3< /tmp/input.txt

# Read from fd 3
echo "Reading from fd 3:"
read -r line <&3
echo "  $line"

# Close fd 3
exec 3<&-

# Open file for writing (fd 4)
exec 4> /tmp/fd_output.txt

# Write to fd 4
echo "Writing to fd 4" >&4

# Close fd 4
exec 4>&-

echo "Content of fd_output.txt:"
cat /tmp/fd_output.txt

# REDIRECTING MULTIPLE STREAMS

echo ""
echo "=== MULTIPLE STREAM REDIRECTION ==="

# Separate stdout and stderr
{
    echo "Normal output"
    echo "Error output" >&2
} > /tmp/stdout.txt 2> /tmp/stderr.txt

echo "stdout:"
cat /tmp/stdout.txt
echo "stderr:"
cat /tmp/stderr.txt

# Swap stdout and stderr
{
    echo "This goes to stderr" >&2
    echo "This goes to stdout"
} 3>&1 1>&2 2>&3

# DISCARDING OUTPUT

echo ""
echo "=== DISCARDING OUTPUT ==="

# Discard stdout
echo "This is hidden" > /dev/null

# Discard stderr
ls /nonexistent 2> /dev/null

# Discard both
ls /tmp /nonexistent > /dev/null 2>&1

# Alternative syntax for both
ls /tmp /nonexistent &> /dev/null

# TEE COMMAND
# Send output to both file and stdout

echo ""
echo "=== TEE COMMAND ==="

echo "Hello" | tee /tmp/tee_output.txt
echo "File content:"
cat /tmp/tee_output.txt

# Append with tee
echo "World" | tee -a /tmp/tee_output.txt
echo "Updated content:"
cat /tmp/tee_output.txt

# PIPES
# Connect stdout of one command to stdin of another

echo ""
echo "=== PIPES ==="

# Simple pipe
echo "hello world" | tr '[:lower:]' '[:upper:]'

# Multiple pipes
cat /tmp/input.txt | grep "line" | wc -l

# Pipe with stderr
ls /tmp /nonexistent 2>&1 | grep "tmp"

# PROCESS SUBSTITUTION

echo ""
echo "=== PROCESS SUBSTITUTION ==="

# <(command) - Treat command output as file for input
diff <(echo "content1") <(echo "content2") || true

# >(command) - Treat command input as file for output
echo "test" > >(cat > /tmp/proc_sub.txt)
sleep 1  # Give time for process substitution
cat /tmp/proc_sub.txt 2>/dev/null || echo "File created"

# PRACTICAL EXAMPLE 1: LOGGING

echo ""
echo "=== PRACTICAL EXAMPLE 1: LOGGING ==="

log_file="/tmp/script.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

log "Script started"
log "Processing data"
log "Script completed"

echo "Log file:"
cat "$log_file"

# PRACTICAL EXAMPLE 2: ERROR HANDLING

echo ""
echo "=== PRACTICAL EXAMPLE 2: ERROR HANDLING ==="

error_log="/tmp/errors.log"

run_command() {
    local cmd=$1
    
    if ! $cmd >> /tmp/command_output.log 2>> "$error_log"; then
        echo "Command failed: $cmd"
        return 1
    fi
    
    echo "Command succeeded: $cmd"
    return 0
}

run_command "echo 'Success test'"
run_command "ls /nonexistent"

echo "Errors logged:"
cat "$error_log" 2>/dev/null || echo "(No errors)"

# PRACTICAL EXAMPLE 3: INPUT VALIDATION

echo ""
echo "=== PRACTICAL EXAMPLE 3: INPUT VALIDATION ==="

validate_input() {
    # Read from stdin
    while IFS= read -r line; do
        if [[ "$line" =~ ^[0-9]+$ ]]; then
            echo "Valid: $line"
        else
            echo "Invalid: $line" >&2
        fi
    done
}

# Test with here document
validate_input << 'EOF' 2>/dev/null
123
abc
456
xyz
EOF

# PRACTICAL EXAMPLE 4: CONFIG FILE GENERATION

echo ""
echo "=== PRACTICAL EXAMPLE 4: CONFIG GENERATION ==="

generate_config() {
    cat > /tmp/app.conf << 'EOF'
# Application Configuration
app_name=MyApp
version=1.0.0
debug=false
port=8080
database=localhost
EOF
    
    echo "Config file generated"
}

generate_config
cat /tmp/app.conf

# PRACTICAL EXAMPLE 5: BACKUP WITH LOGGING

echo ""
echo "=== PRACTICAL EXAMPLE 5: BACKUP SCRIPT ==="

backup_log="/tmp/backup.log"

backup_files() {
    local source=$1
    local dest=$2
    
    {
        echo "=== Backup started at $(date) ==="
        
        if [ ! -d "$source" ]; then
            echo "ERROR: Source directory not found" >&2
            return 1
        fi
        
        mkdir -p "$dest"
        
        # Perform backup
        cp -r "$source" "$dest" 2>&1
        
        if [ $? -eq 0 ]; then
            echo "SUCCESS: Backup completed"
        else
            echo "ERROR: Backup failed" >&2
        fi
        
        echo "=== Backup ended at $(date) ==="
        echo ""
    } | tee -a "$backup_log"
}

mkdir -p /tmp/backup_source
echo "data" > /tmp/backup_source/file.txt
backup_files /tmp/backup_source /tmp/backup_dest

# PRACTICAL EXAMPLE 6: DATA PROCESSING PIPELINE

echo ""
echo "=== PRACTICAL EXAMPLE 6: DATA PIPELINE ==="

# Create sample data
cat > /tmp/data.csv << 'EOF'
John,25,Engineer
Jane,30,Doctor
Bob,28,Teacher
Alice,35,Engineer
EOF

# Process data with pipeline
cat /tmp/data.csv | \
    grep "Engineer" | \
    cut -d',' -f1,2 | \
    sort | \
    tee /tmp/processed.csv

echo "Processed data:"
cat /tmp/processed.csv

# PRACTICAL EXAMPLE 7: COMMAND OUTPUT CAPTURE

echo ""
echo "=== PRACTICAL EXAMPLE 7: OUTPUT CAPTURE ==="

capture_output() {
    local cmd=$1
    local output_file="/tmp/capture_$$_$RANDOM.txt"
    
    # Execute and capture
    $cmd > "$output_file" 2>&1
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo "Command succeeded"
        cat "$output_file"
    else
        echo "Command failed with code: $exit_code"
        cat "$output_file" >&2
    fi
    
    rm -f "$output_file"
    return $exit_code
}

capture_output "echo 'Test command'"

# REDIRECTION PATTERNS

echo ""
echo "=== REDIRECTION PATTERNS ==="

: '
Pattern 1: Silent execution
command > /dev/null 2>&1

Pattern 2: Save output and errors
command > output.txt 2> errors.txt

Pattern 3: Combine streams
command > combined.txt 2>&1

Pattern 4: Append to log
command >> logfile.txt 2>&1

Pattern 5: Read from here document
command << EOF
content
EOF

Pattern 6: Pipeline
cmd1 | cmd2 | cmd3

Pattern 7: Tee to file and stdout
command | tee output.txt

Pattern 8: Process substitution
diff <(cmd1) <(cmd2)
'

# BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Always redirect stderr when needed
2. Use tee for logging and display
3. Close file descriptors when done
4. Be careful with > (overwrites) vs >> (appends)
5. Use here documents for multi-line input
6. Combine streams carefully (order matters)
7. Check command exit codes
8. Use meaningful file descriptor numbers (3-9)
9. Clean up temporary files
10. Quote here document delimiters to prevent expansion
'

# CLEANUP

echo ""
echo "=== CLEANUP ==="

rm -f /tmp/output.txt /tmp/errors.txt /tmp/combined.txt
rm -f /tmp/input.txt /tmp/fd_output.txt /tmp/stdout.txt /tmp/stderr.txt
rm -f /tmp/tee_output.txt /tmp/proc_sub.txt /tmp/script.log
rm -f /tmp/command_output.log /tmp/error_log /tmp/app.conf
rm -f /tmp/processed.csv /tmp/data.csv
rm -rf /tmp/backup_source /tmp/backup_dest

echo "Cleanup complete"

echo ""
echo "I/O redirection tutorial complete!"
