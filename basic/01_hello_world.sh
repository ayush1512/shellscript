#!/bin/bash

# Shebang Line (#!/bin/bash):
# - Tells the system which interpreter to use to execute the script
# - Must be the first line of the script
# - /bin/bash is the path to the Bash shell interpreter

# ECHO COMMAND
# Syntax: echo [options] [string]
# Used to display text/string on the screen

echo "Hello, World!"

# Output: Hello, World!

# Different ways to use echo:
echo Hello World                    # Without quotes (works for simple text)
echo "Hello World"                  # With double quotes (recommended)
echo 'Hello World'                  # With single quotes

# Echo with options:
echo -n "No newline"                # -n option: no trailing newline
echo " continues here"

echo -e "Line 1\nLine 2"           # -e option: enable interpretation of backslash escapes
                                    # \n creates a new line

echo -e "Tab\tseparated"           # \t creates a tab

echo -e "\033[1;32mGreen Text\033[0m"  # Colored text using ANSI escape codes
