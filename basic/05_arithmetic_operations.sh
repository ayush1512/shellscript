#!/bin/bash

# ARITHMETIC OPERATIONS IN SHELL SCRIPTING
# Shell scripting supports various arithmetic operations

# BASIC ARITHMETIC OPERATORS
# + : Addition
# - : Subtraction
# * : Multiplication
# / : Division (integer division)
# % : Modulus (remainder)
# ** : Exponentiation

# METHOD 1: Using $(( )) - Double Parentheses (Recommended)
# Syntax: $((expression))
# This is the most common and preferred method

a=10
b=5

# Addition
sum=$((a + b))
echo "$a + $b = $sum"

# Subtraction
diff=$((a - b))
echo "$a - $b = $diff"

# Multiplication
product=$((a * b))
echo "$a * $b = $product"

# Division (integer division - decimal part is truncated)
quotient=$((a / b))
echo "$a / $b = $quotient"

# Modulus (remainder)
remainder=$((a % b))
echo "$a % $b = $remainder"

# Exponentiation
power=$((a ** 2))
echo "$a ** 2 = $power"

# Complex expressions
result=$((a + b * 2))
echo "$a + $b * 2 = $result"  # Follows order of operations

result=$(((a + b) * 2))
echo "($a + $b) * 2 = $result"  # Use parentheses to control order

# METHOD 2: Using expr command
# Syntax: expr expression
# Note: Requires spaces around operators
# Note: * must be escaped as \*

sum=$(expr $a + $b)
echo "Using expr: $a + $b = $sum"

product=$(expr $a \* $b)
echo "Using expr: $a * $b = $product"

# METHOD 3: Using let command
# Syntax: let expression
# Note: No spaces around operators

let result=a+b
echo "Using let: $a + $b = $result"

let result=a*b
echo "Using let: $a * $b = $result"

# METHOD 4: Using bc for floating-point arithmetic
# bc is a calculator that supports decimal numbers
# Syntax: echo "expression" | bc

x=10
y=3

# Integer division
int_div=$((x / y))
echo "$x / $y (integer) = $int_div"

# Floating-point division
float_div=$(echo "scale=2; $x / $y" | bc)
echo "$x / $y (float) = $float_div"

# scale=2 means 2 decimal places
result=$(echo "scale=4; 22 / 7" | bc)
echo "22 / 7 with 4 decimals = $result"

# Square root using bc
num=16
sqrt=$(echo "scale=2; sqrt($num)" | bc)
echo "Square root of $num = $sqrt"

# INCREMENT AND DECREMENT OPERATORS

# Pre-increment
i=5
echo "i = $i"
((++i))
echo "After ++i: $i"

# Post-increment
i=5
echo "i = $i"
((i++))
echo "After i++: $i"

# Pre-decrement
i=5
((--i))
echo "After --i: $i"

# Post-decrement
i=5
((i--))
echo "After i--: $i"

# Compound assignment operators
i=10
((i += 5))   # i = i + 5
echo "i += 5: $i"

((i -= 3))   # i = i - 3
echo "i -= 3: $i"

((i *= 2))   # i = i * 2
echo "i *= 2: $i"

((i /= 4))   # i = i / 4
echo "i /= 4: $i"

((i %= 3))   # i = i % 3
echo "i %= 3: $i"

# PRACTICAL EXAMPLES

# Calculate average
num1=10
num2=20
num3=30
average=$(((num1 + num2 + num3) / 3))
echo "Average of $num1, $num2, $num3 = $average"

# Check if number is even or odd
number=17
if (( number % 2 == 0 )); then
    echo "$number is even"
else
    echo "$number is odd"
fi

# Convert Celsius to Fahrenheit
celsius=25
fahrenheit=$(echo "scale=2; ($celsius * 9 / 5) + 32" | bc)
echo "${celsius}°C = ${fahrenheit}°F"
