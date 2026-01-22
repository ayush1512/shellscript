#!/bin/bash

# COMMENTS IN SHELL SCRIPTING
# Comments are used to explain code and are ignored by the interpreter

# SINGLE LINE COMMENTS
# Any line starting with # is a comment
# Comments help make code more readable and maintainable

# This is a single line comment
echo "This line executes"  # This is an inline comment

# You can use comments to temporarily disable code
# echo "This line will not execute"

# MULTI-LINE COMMENTS
# Bash doesn't have native multi-line comment syntax
# But we can achieve it using different methods:

# Method 1: Multiple single-line comments
# This is line 1 of a multi-line comment
# This is line 2 of a multi-line comment
# This is line 3 of a multi-line comment

# Method 2: Using : (colon) with heredoc
# This method is useful for long comments
: '
This is a multi-line comment
It can span multiple lines
All these lines are ignored
Nothing here will execute
'

# Method 3: Using block comment with <<
: <<'COMMENT'
This is another way to write multi-line comments
You can write as many lines as you want
The word COMMENT is arbitrary - you can use any word
Just make sure the closing word matches
COMMENT

# BEST PRACTICES FOR COMMENTS

# 1. Explain WHY, not WHAT (when the code is not obvious)
# Bad comment:
# Increment i by 1
i=$((i + 1))

# Good comment:
# Skip the first line as it contains headers
i=$((i + 1))

# 2. Keep comments up-to-date with code
# Outdated comments are worse than no comments

# 3. Use comments to document:
#    - Complex algorithms
#    - Function purposes and parameters
#    - Important assumptions
#    - Known limitations or bugs
#    - TODO items

# 4. Add header comments to scripts
# --------------------------------------------
# Script: example.sh
# Description: Does something important
# Author: Your Name
# Date: 2024-01-01
# Version: 1.0
# --------------------------------------------

# 5. Document function parameters and return values (covered in functions section)

# 6. Use TODO comments for future improvements
# TODO: Add error handling
# FIXME: This doesn't work with negative numbers
# HACK: Temporary workaround

echo "Script with comments completed"
