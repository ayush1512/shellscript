#!/bin/bash

# SIGNALS AND TRAPS IN SHELL SCRIPTING
# Handle signals and perform cleanup operations

# UNDERSTANDING SIGNALS
# Signals are notifications sent to processes
# Common signals:
# SIGINT (2)  - Interrupt (Ctrl+C)
# SIGTERM (15) - Termination
# SIGKILL (9)  - Force kill (cannot be trapped)
# SIGHUP (1)   - Hangup
# SIGQUIT (3)  - Quit (Ctrl+\)

echo "=== UNDERSTANDING SIGNALS ==="
echo "Common signals:"
echo "  SIGINT (2)  - Ctrl+C"
echo "  SIGTERM (15) - Termination request"
echo "  SIGHUP (1)   - Hangup"
echo "  SIGQUIT (3)  - Quit"

# TRAP COMMAND
# Syntax: trap 'commands' SIGNAL1 SIGNAL2 ...
# Used to catch signals and execute commands

echo ""
echo "=== BASIC TRAP ==="

# Simple trap example
trap 'echo "Signal caught!"' SIGINT

# Note: In an interactive session, you would use sleep to test this
# echo "Try pressing Ctrl+C..."
# sleep 5  # Would wait for Ctrl+C in interactive session
echo "Trap set for SIGINT (demonstration - no interactive wait in this tutorial)"

# Reset trap
trap - SIGINT
echo "Trap reset"

# TRAP ON EXIT
# EXIT signal is triggered when script exits

echo ""
echo "=== TRAP ON EXIT ==="

cleanup() {
    echo "Performing cleanup..."
    # Remove temporary files
    rm -f /tmp/trap_test_*.txt
    echo "Cleanup complete"
}

# Set trap for EXIT
trap cleanup EXIT

# Create temporary files
touch /tmp/trap_test_1.txt /tmp/trap_test_2.txt
echo "Created temporary files"

# Files will be cleaned up automatically when script exits

# TRAP MULTIPLE SIGNALS

echo ""
echo "=== TRAP MULTIPLE SIGNALS ==="

multi_signal_handler() {
    echo "Caught signal: $1"
}

# Trap multiple signals
trap 'multi_signal_handler "SIGINT"' SIGINT
trap 'multi_signal_handler "SIGTERM"' SIGTERM

echo "Multiple signals trapped"

# TRAP WITH FUNCTION

echo ""
echo "=== TRAP WITH FUNCTION ==="

interrupt_handler() {
    echo ""
    echo "Interrupt received!"
    echo "Performing cleanup..."
    
    # Cleanup operations
    echo "Removing temporary files..."
    # rm -f /tmp/*.tmp
    
    echo "Exiting gracefully"
    exit 130  # Standard exit code for Ctrl+C
}

trap interrupt_handler SIGINT

echo "Interrupt handler set up"

# IGNORE SIGNALS

echo ""
echo "=== IGNORING SIGNALS ==="

# Ignore SIGINT (Ctrl+C won't work)
trap '' SIGINT

echo "SIGINT is now ignored"
# sleep 3

# Restore default behavior
trap - SIGINT
echo "SIGINT restored to default"

# TRAP FOR ERROR HANDLING

echo ""
echo "=== TRAP FOR ERROR HANDLING ==="

error_handler() {
    local line_no=$1
    echo "Error occurred on line: $line_no"
    echo "Last command: $BASH_COMMAND"
    echo "Exit code: $?"
}

# Trap ERR signal (triggered on command failure)
trap 'error_handler ${LINENO}' ERR

# Example command that will fail
# false

trap - ERR
echo "Error trap removed"

# TRAP FOR DEBUGGING

echo ""
echo "=== TRAP FOR DEBUGGING ==="

debug_handler() {
    echo "DEBUG: Executing line ${BASH_LINENO[0]}: $BASH_COMMAND"
}

# Trap DEBUG (executed before every command)
trap debug_handler DEBUG

# Some commands
x=10
y=20

# Disable debug trap
trap - DEBUG
echo "Debug trap removed"

# PRACTICAL EXAMPLE 1: CLEANUP ON EXIT

echo ""
echo "=== PRACTICAL EXAMPLE 1: CLEANUP ==="

temp_dir="/tmp/script_temp_$$"

setup() {
    mkdir -p "$temp_dir"
    echo "Working directory created: $temp_dir"
}

cleanup_on_exit() {
    echo "Cleaning up working directory..."
    rm -rf "$temp_dir"
    echo "Cleanup done"
}

trap cleanup_on_exit EXIT

setup
# Do work
echo "file content" > "$temp_dir/test.txt"
echo "Created file in temp directory"

# Directory will be cleaned up on exit

# PRACTICAL EXAMPLE 2: LOCK FILE

echo ""
echo "=== PRACTICAL EXAMPLE 2: LOCK FILE ==="

lockfile="/tmp/script.lock"

acquire_lock() {
    if [ -f "$lockfile" ]; then
        echo "Another instance is running"
        exit 1
    fi
    
    touch "$lockfile"
    echo "Lock acquired"
}

release_lock() {
    rm -f "$lockfile"
    echo "Lock released"
}

trap release_lock EXIT

acquire_lock
# Do work
echo "Doing work..."

# Lock will be released on exit

# PRACTICAL EXAMPLE 3: GRACEFUL SHUTDOWN

echo ""
echo "=== PRACTICAL EXAMPLE 3: GRACEFUL SHUTDOWN ==="

running=true

graceful_shutdown() {
    echo "Shutdown signal received"
    running=false
    echo "Finishing current work..."
    # Give time for current operations to complete
    sleep 1
    echo "Shutdown complete"
    exit 0
}

trap graceful_shutdown SIGTERM SIGINT

# Simulated long-running process
count=0
max_iterations=5

while $running && [ $count -lt $max_iterations ]; do
    echo "Working... iteration $count"
    sleep 1
    ((count++))
done

echo "Process completed"

# PRACTICAL EXAMPLE 4: SAVE STATE ON INTERRUPT

echo ""
echo "=== PRACTICAL EXAMPLE 4: SAVE STATE ==="

state_file="/tmp/script_state.txt"
current_progress=0

save_state() {
    echo "Saving state..."
    echo "$current_progress" > "$state_file"
    echo "State saved: progress=$current_progress"
    exit 0
}

load_state() {
    if [ -f "$state_file" ]; then
        current_progress=$(cat "$state_file")
        echo "Resumed from progress: $current_progress"
        rm -f "$state_file"
    fi
}

trap save_state SIGINT SIGTERM

load_state

# Simulate work
for ((i=current_progress; i<5; i++)); do
    current_progress=$i
    echo "Progress: $current_progress"
    sleep 1
done

echo "Work completed"

# PRACTICAL EXAMPLE 5: RESOURCE CLEANUP

echo ""
echo "=== PRACTICAL EXAMPLE 5: RESOURCE CLEANUP ==="

resources_cleanup() {
    echo "Cleaning up resources..."
    
    # Close open files
    exec 3>&-  2>/dev/null || true
    
    # Kill child processes
    jobs -p | xargs kill 2>/dev/null || true
    
    # Remove temp files
    rm -f /tmp/resource_*.tmp 2>/dev/null
    
    echo "Resources cleaned up"
}

trap resources_cleanup EXIT

# Open file descriptor
exec 3>/tmp/resource_fd.tmp
echo "data" >&3

# Create temp file
touch /tmp/resource_test.tmp

echo "Resources allocated"

# TRAP PATTERNS

echo ""
echo "=== TRAP PATTERNS ==="

: '
Pattern 1: Simple cleanup
trap "rm -f /tmp/tempfile" EXIT

Pattern 2: Multiple signals
trap "cleanup; exit" SIGINT SIGTERM

Pattern 3: Ignore signals
trap "" SIGINT  # Ignore
trap - SIGINT   # Restore default

Pattern 4: Chain traps
trap "trap1; trap2; trap3" EXIT

Pattern 5: Conditional trap
if [ condition ]; then
    trap "handler" SIGNAL
fi
'

# SIGNAL SAFETY

echo ""
echo "=== SIGNAL SAFETY TIPS ==="

: '
1. Always trap EXIT for cleanup
2. Use trap - SIGNAL to restore defaults
3. Be careful with SIGKILL (cannot be trapped)
4. Test your traps thoroughly
5. Keep trap handlers simple and fast
6. Avoid complex operations in traps
7. Use appropriate exit codes
8. Consider race conditions
9. Clean up all resources
10. Document your trap handlers
'

# BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Cleanup Function:
   - Always create a cleanup function
   - Trap EXIT signal for automatic cleanup
   - Make cleanup idempotent (safe to run multiple times)

2. Lock Files:
   - Use lock files for single-instance scripts
   - Always release locks in trap

3. Graceful Shutdown:
   - Handle SIGTERM and SIGINT
   - Allow current operations to complete
   - Save state if needed

4. Resource Management:
   - Close file descriptors
   - Kill child processes
   - Remove temporary files

5. Error Handling:
   - Trap ERR for error handling
   - Log errors appropriately
   - Use appropriate exit codes

6. Testing:
   - Test trap handlers
   - Test signal handling
   - Test cleanup operations
'

echo ""
echo "Signals and traps tutorial complete!"
