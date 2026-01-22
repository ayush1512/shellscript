#!/bin/bash

# SCRIPT DEBUGGING IN SHELL SCRIPTING
# Techniques and tools for debugging shell scripts

# DEBUGGING WITH SET OPTIONS

echo "=== SET OPTIONS FOR DEBUGGING ==="

# set -x : Print each command before executing (xtrace)
# set -e : Exit immediately if command fails
# set -u : Treat unset variables as errors
# set -o pipefail : Pipe fails if any command fails

echo "Available debugging options:"
echo "  -x : Print commands as they execute"
echo "  -e : Exit on error"
echo "  -u : Error on undefined variables"
echo "  -o pipefail : Fail pipe on any error"

# XTRACE MODE (-x)

echo ""
echo "=== XTRACE MODE ==="

# Enable xtrace
set -x

# These commands will be printed before execution
x=10
y=20
sum=$((x + y))
echo "Sum: $sum"

# Disable xtrace
set +x

echo "Xtrace disabled"

# EXIT ON ERROR (-e)

echo ""
echo "=== EXIT ON ERROR ==="

# Without -e
echo "Without -e:"
false
echo "This executes even after false"

# With -e (commented to not exit script)
: '
set -e
false
echo "This would not execute"
set +e
'

# UNDEFINED VARIABLE ERROR (-u)

echo ""
echo "=== UNDEFINED VARIABLE ERROR ==="

# Without -u
echo "Without -u:"
echo "Undefined: $undefined_var"  # Prints empty

# With -u (commented to not cause error)
: '
set -u
echo "$undefined_var"  # Would cause error
set +u
'

# PIPEFAIL

echo ""
echo "=== PIPEFAIL ==="

# Without pipefail
echo "Without pipefail:"
false | echo "This succeeds"
echo "Exit code: $?"

# With pipefail
set -o pipefail
false | echo "This succeeds"
echo "Exit code: $?"
set +o pipefail

# PS4 VARIABLE
# Customize xtrace output

echo ""
echo "=== CUSTOMIZE XTRACE OUTPUT ==="

# Set PS4 to show line numbers
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

set -x
echo "This shows line number in trace"
x=42
set +x

# Reset PS4
export PS4='+ '

# BASH BUILT-IN VARIABLES FOR DEBUGGING

echo ""
echo "=== DEBUG VARIABLES ==="

echo "Script name: $0"
echo "Script directory: $(dirname "$0")"
echo "Current line: $LINENO"
echo "Bash version: $BASH_VERSION"
echo "Number of arguments: $#"

# TRAP DEBUG

echo ""
echo "=== TRAP DEBUG ==="

# Function called before each command
debug_trap() {
    echo "DEBUG: Line $LINENO: $BASH_COMMAND"
}

# Enable debug trap for a section
trap debug_trap DEBUG

var1=100
var2=200

# Disable debug trap
trap - DEBUG

echo "Debug trap removed"

# LOGGING

echo ""
echo "=== LOGGING FOR DEBUGGING ==="

log_file="/tmp/debug.log"

# Logging function
log_debug() {
    echo "[DEBUG $(date '+%H:%M:%S')] $1" >> "$log_file"
}

log_info() {
    echo "[INFO  $(date '+%H:%M:%S')] $1" | tee -a "$log_file"
}

log_error() {
    echo "[ERROR $(date '+%H:%M:%S')] $1" | tee -a "$log_file" >&2
}

# Use logging
log_info "Script started"
log_debug "Debug information"
log_error "An error occurred"

echo "Log content:"
cat "$log_file"

# ASSERT FUNCTION

echo ""
echo "=== ASSERT FUNCTION ==="

assert() {
    local condition=$1
    local message=${2:-"Assertion failed"}
    
    if ! eval "$condition"; then
        echo "ASSERT FAILED: $message"
        echo "  Condition: $condition"
        echo "  Line: ${BASH_LINENO[0]}"
        exit 1
    fi
}

# Test assertions
x=10
assert '[ $x -eq 10 ]' "x should be 10"
echo "Assertion passed"

# This would fail:
# assert '[ $x -eq 20 ]' "x should be 20"

# STACK TRACE

echo ""
echo "=== STACK TRACE ==="

print_stack_trace() {
    local frame=0
    echo "Stack trace:"
    while caller $frame; do
        ((frame++))
    done
}

function_a() {
    function_b
}

function_b() {
    function_c
}

function_c() {
    print_stack_trace
}

echo "Calling nested functions:"
function_a

# SHELLCHECK INTEGRATION

echo ""
echo "=== SHELLCHECK ==="

echo "ShellCheck is a static analysis tool for shell scripts"
echo "Install: apt-get install shellcheck"
echo "Usage: shellcheck script.sh"
echo ""
echo "Common warnings:"
echo "  SC2086: Quote variables to prevent word splitting"
echo "  SC2046: Quote command substitution"
echo "  SC2155: Declare and assign separately"

# DEBUGGING TECHNIQUES

echo ""
echo "=== DEBUGGING TECHNIQUES ==="

# Technique 1: Print variable values
debug_var() {
    local var_name=$1
    local var_value="${!var_name}"
    echo "DEBUG: $var_name = '$var_value'"
}

test_var="hello world"
debug_var "test_var"

# Technique 2: Print function entry/exit
debug_function() {
    local func_name=${FUNCNAME[1]}
    local action=$1
    echo "DEBUG: Function '$func_name' $action"
}

example_function() {
    debug_function "entered"
    # Function code
    echo "Function executing"
    debug_function "exited"
}

example_function

# Technique 3: Conditional debugging
DEBUG=${DEBUG:-0}

debug_print() {
    if [ "$DEBUG" -eq 1 ]; then
        echo "DEBUG: $1"
    fi
}

debug_print "This only prints if DEBUG=1"
DEBUG=1
debug_print "This will print"
DEBUG=0

# PRACTICAL EXAMPLE 1: ERROR HANDLING

echo ""
echo "=== PRACTICAL EXAMPLE 1: ERROR HANDLING ==="

# Robust error handling
set -euo pipefail

error_handler() {
    local line_no=$1
    local error_code=$2
    echo "Error on line $line_no (exit code: $error_code)"
    echo "Command: $BASH_COMMAND"
    # Cleanup (note: trap EXIT will also run for final cleanup)
    rm -f /tmp/debug_test_*.txt
    # Exit with error code (trap EXIT will still execute)
    exit $error_code
}

trap 'error_handler ${LINENO} $?' ERR

# Reset for rest of script
set +euo pipefail

echo "Error handling demonstrated"

# PRACTICAL EXAMPLE 2: PERFORMANCE DEBUGGING

echo ""
echo "=== PRACTICAL EXAMPLE 2: PERFORMANCE DEBUGGING ==="

time_function() {
    local start=$(date +%s%N)
    
    # Execute function
    "$@"
    
    local end=$(date +%s%N)
    local duration=$(( (end - start) / 1000000 ))
    echo "Execution time: ${duration}ms"
}

slow_function() {
    sleep 0.1
    echo "Function completed"
}

time_function slow_function

# PRACTICAL EXAMPLE 3: STEP-BY-STEP DEBUGGING

echo ""
echo "=== PRACTICAL EXAMPLE 3: STEP DEBUGGING ==="

step_debug() {
    local enabled=${STEP_DEBUG:-0}
    
    if [ "$enabled" -eq 1 ]; then
        read -p "Press Enter to continue..." -r
    fi
}

echo "Step 1"
step_debug
echo "Step 2"
step_debug
echo "Step 3"

# PRACTICAL EXAMPLE 4: VERBOSE MODE

echo ""
echo "=== PRACTICAL EXAMPLE 4: VERBOSE MODE ==="

VERBOSE=${VERBOSE:-0}

verbose_echo() {
    if [ "$VERBOSE" -ge 1 ]; then
        echo "$1"
    fi
}

verbose_debug() {
    if [ "$VERBOSE" -ge 2 ]; then
        echo "DEBUG: $1"
    fi
}

verbose_echo "Verbose message (level 1)"
verbose_debug "Debug message (level 2)"

VERBOSE=2
verbose_echo "Now both show"
verbose_debug "Now both show"
VERBOSE=0

# PRACTICAL EXAMPLE 5: DRY RUN MODE

echo ""
echo "=== PRACTICAL EXAMPLE 5: DRY RUN MODE ==="

DRY_RUN=${DRY_RUN:-0}

execute() {
    local cmd=$1
    
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "[DRY RUN] Would execute: $cmd"
    else
        echo "Executing: $cmd"
        eval "$cmd"
    fi
}

execute "echo 'Real execution'"

DRY_RUN=1
execute "echo 'This would execute'"
DRY_RUN=0

# COMMON DEBUGGING PATTERNS

echo ""
echo "=== COMMON DEBUGGING PATTERNS ==="

: '
Pattern 1: Comprehensive error handling
set -euo pipefail
trap cleanup ERR EXIT

Pattern 2: Verbose logging
log() { echo "[$(date)] $*" >> logfile; }

Pattern 3: Debug mode
[ "$DEBUG" = "1" ] && set -x

Pattern 4: Trace specific section
set -x; section_code; set +x

Pattern 5: Assert conditions
assert_eq() { [ "$1" = "$2" ] || exit 1; }

Pattern 6: Stack trace on error
trap print_stack ERR
'

# BEST PRACTICES

echo ""
echo "=== DEBUGGING BEST PRACTICES ==="

: '
1. Use set -euo pipefail for strict mode
2. Always trap ERR and EXIT
3. Log important operations
4. Use meaningful variable names
5. Add comments for complex logic
6. Test error paths
7. Use shellcheck regularly
8. Enable debug mode during development
9. Add assertions for assumptions
10. Keep functions small and testable
11. Use consistent error handling
12. Clean up resources on exit
13. Log timestamps and context
14. Use version control
15. Document debugging flags
'

# DEBUGGING CHECKLIST

echo ""
echo "=== DEBUGGING CHECKLIST ==="

: '
Before releasing a script:
□ Run shellcheck
□ Test with set -euo pipefail
□ Test error paths
□ Verify cleanup on exit
□ Test with invalid inputs
□ Check for race conditions
□ Verify file permissions
□ Test on target systems
□ Add logging
□ Document usage
'

# CLEANUP

echo ""
echo "=== CLEANUP ==="

rm -f /tmp/debug.log /tmp/debug_test_*.txt

echo "Cleanup complete"

echo ""
echo "Script debugging tutorial complete!"
echo ""
echo "Remember: Good debugging starts with good code!"
