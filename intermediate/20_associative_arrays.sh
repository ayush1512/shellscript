#!/bin/bash

# ASSOCIATIVE ARRAYS IN SHELL SCRIPTING
# Associative arrays use strings as keys instead of numeric indices
# Also known as maps, dictionaries, or hash tables
# Requires Bash 4.0 or later

# Check Bash version
echo "=== BASH VERSION ==="
echo "Bash version: ${BASH_VERSION}"

# DECLARING ASSOCIATIVE ARRAYS
# Must use 'declare -A' before initialization

echo ""
echo "=== DECLARING ASSOCIATIVE ARRAYS ==="

# Declare associative array
declare -A person

# Assign key-value pairs
person[name]="John Doe"
person[age]=30
person[city]="New York"
person[occupation]="Engineer"

echo "Person array created"

# ALTERNATIVE INITIALIZATION
# Can declare and initialize in one step

declare -A colors=(
    [sky]="blue"
    [grass]="green"
    [sun]="yellow"
    [blood]="red"
)

echo "Colors array created"

# ACCESSING VALUES
# Syntax: ${array_name[key]}

echo ""
echo "=== ACCESSING VALUES ==="

echo "Name: ${person[name]}"
echo "Age: ${person[age]}"
echo "City: ${person[city]}"
echo "Occupation: ${person[occupation]}"

echo "Sky color: ${colors[sky]}"
echo "Grass color: ${colors[grass]}"

# GET ALL KEYS
# Syntax: ${!array_name[@]}

echo ""
echo "=== GETTING ALL KEYS ==="

echo "Person keys: ${!person[@]}"
echo "Color keys: ${!colors[@]}"

# GET ALL VALUES
# Syntax: ${array_name[@]}

echo ""
echo "=== GETTING ALL VALUES ==="

echo "Person values: ${person[@]}"
echo "Color values: ${colors[@]}"

# ARRAY LENGTH
# Syntax: ${#array_name[@]}

echo ""
echo "=== ARRAY LENGTH ==="

echo "Number of person fields: ${#person[@]}"
echo "Number of colors: ${#colors[@]}"

# ITERATING OVER ASSOCIATIVE ARRAYS

echo ""
echo "=== ITERATING OVER KEYS AND VALUES ==="

# Method 1: Iterate over keys
echo "Person information:"
for key in "${!person[@]}"; do
    echo "  $key: ${person[$key]}"
done

# Method 2: Iterate over values
echo "All color values:"
for value in "${colors[@]}"; do
    echo "  - $value"
done

# CHECKING IF KEY EXISTS

echo ""
echo "=== CHECKING KEY EXISTENCE ==="

declare -A config=(
    [host]="localhost"
    [port]="8080"
)

# Check if key exists using parameter expansion
# The ${var+isset} pattern returns "isset" if var is set, empty otherwise
if [ "${config[host]+isset}" ]; then
    echo "Host is set: ${config[host]}"
fi

# Same method for another key
if [ "${config[port]+isset}" ]; then
    echo "Port is set: ${config[port]}"
fi

if [ -z "${config[username]+isset}" ]; then
    echo "Username is not set"
fi

# MODIFYING VALUES

echo ""
echo "=== MODIFYING VALUES ==="

declare -A user=(
    [username]="alice"
    [role]="user"
)

echo "Before: ${user[@]}"

# Modify existing value
user[role]="admin"

# Add new key-value pair
user[email]="alice@example.com"

echo "After: ${user[@]}"
echo "Keys: ${!user[@]}"

# DELETING ELEMENTS

echo ""
echo "=== DELETING ELEMENTS ==="

declare -A temp=(
    [a]="first"
    [b]="second"
    [c]="third"
)

echo "Before delete: ${temp[@]}"
echo "Keys: ${!temp[@]}"

# Delete specific key
unset temp[b]

echo "After deleting 'b': ${temp[@]}"
echo "Keys: ${!temp[@]}"

# NESTED STRUCTURES (SIMULATED)
# Bash doesn't support nested associative arrays directly
# But we can use naming conventions

echo ""
echo "=== SIMULATED NESTED STRUCTURE ==="

# Using dot notation in keys
declare -A database
database[user.name]="John"
database[user.email]="john@example.com"
database[server.host]="localhost"
database[server.port]="5432"

echo "Database configuration:"
for key in "${!database[@]}"; do
    echo "  $key = ${database[$key]}"
done

# PRACTICAL EXAMPLE 1: CONFIGURATION MANAGEMENT

echo ""
echo "=== PRACTICAL EXAMPLE 1: CONFIGURATION ==="

declare -A app_config=(
    [app_name]="MyApp"
    [version]="1.0.0"
    [debug]="true"
    [max_connections]="100"
    [timeout]="30"
)

echo "Application Configuration:"
for key in "${!app_config[@]}"; do
    echo "  $key: ${app_config[$key]}"
done

# Access specific config
if [ "${app_config[debug]}" = "true" ]; then
    echo "Debug mode is enabled"
fi

# PRACTICAL EXAMPLE 2: TRANSLATION/LOCALIZATION

echo ""
echo "=== PRACTICAL EXAMPLE 2: TRANSLATIONS ==="

declare -A translations=(
    [hello]="Hola"
    [goodbye]="Adiós"
    [thank_you]="Gracias"
    [welcome]="Bienvenido"
)

translate() {
    local key=$1
    echo "${translations[$key]:-Translation not found}"
}

echo "English: hello -> Spanish: $(translate hello)"
echo "English: goodbye -> Spanish: $(translate goodbye)"
echo "English: unknown -> Spanish: $(translate unknown)"

# PRACTICAL EXAMPLE 3: COUNTER/FREQUENCY MAP

echo ""
echo "=== PRACTICAL EXAMPLE 3: WORD FREQUENCY ==="

text="apple banana apple orange banana apple"
declare -A word_count

# Count word frequencies
for word in $text; do
    if [ -n "${word_count[$word]}" ]; then
        ((word_count[$word]++))
    else
        word_count[$word]=1
    fi
done

echo "Word frequencies:"
for word in "${!word_count[@]}"; do
    echo "  $word: ${word_count[$word]}"
done

# PRACTICAL EXAMPLE 4: USER DIRECTORY

echo ""
echo "=== PRACTICAL EXAMPLE 4: USER DIRECTORY ==="

declare -A users

users[alice]="alice@example.com"
users[bob]="bob@example.com"
users[charlie]="charlie@example.com"

add_user() {
    local username=$1
    local email=$2
    users[$username]=$email
    echo "Added user: $username"
}

get_user() {
    local username=$1
    if [ -n "${users[$username]}" ]; then
        echo "${users[$username]}"
    else
        echo "User not found"
    fi
}

remove_user() {
    local username=$1
    if [ -n "${users[$username]}" ]; then
        unset users[$username]
        echo "Removed user: $username"
    else
        echo "User not found"
    fi
}

echo "All users:"
for username in "${!users[@]}"; do
    echo "  $username: ${users[$username]}"
done

add_user "david" "david@example.com"
echo "Bob's email: $(get_user bob)"
remove_user "charlie"

echo "Updated user list: ${!users[@]}"

# PRACTICAL EXAMPLE 5: CACHING

echo ""
echo "=== PRACTICAL EXAMPLE 5: CACHING ==="

declare -A cache

cache_set() {
    local key=$1
    local value=$2
    cache[$key]=$value
    echo "Cached: $key"
}

cache_get() {
    local key=$1
    if [ -n "${cache[$key]+isset}" ]; then
        echo "${cache[$key]}"
        return 0
    else
        return 1
    fi
}

cache_has() {
    local key=$1
    [ -n "${cache[$key]+isset}" ]
}

# Simulate expensive operation
expensive_operation() {
    local id=$1
    echo "Computing result for $id..."
    sleep 1
    echo "Result_$id"
}

# Function with caching
get_with_cache() {
    local id=$1
    
    if cache_has "$id"; then
        echo "Cache hit!"
        cache_get "$id"
    else
        echo "Cache miss!"
        local result=$(expensive_operation "$id")
        cache_set "$id" "$result"
        echo "$result"
    fi
}

echo "First call:"
get_with_cache "123"

echo "Second call (cached):"
get_with_cache "123"

# PRACTICAL EXAMPLE 6: ENVIRONMENT VARIABLES

echo ""
echo "=== PRACTICAL EXAMPLE 6: ENVIRONMENT MAP ==="

declare -A env_vars

# Store environment-like variables
env_vars[PATH]="/usr/local/bin:/usr/bin"
env_vars[HOME]="/home/user"
env_vars[SHELL]="/bin/bash"
env_vars[USER]="username"

print_env() {
    echo "Environment Variables:"
    for var in "${!env_vars[@]}"; do
        echo "  $var=${env_vars[$var]}"
    done
}

get_env() {
    local var=$1
    echo "${env_vars[$var]:-not set}"
}

print_env
echo "HOME directory: $(get_env HOME)"

# PRACTICAL EXAMPLE 7: STATUS CODES

echo ""
echo "=== PRACTICAL EXAMPLE 7: STATUS CODES ==="

declare -A http_codes=(
    [200]="OK"
    [201]="Created"
    [400]="Bad Request"
    [401]="Unauthorized"
    [404]="Not Found"
    [500]="Internal Server Error"
)

get_status_message() {
    local code=$1
    echo "${http_codes[$code]:-Unknown Status}"
}

echo "HTTP Status Codes:"
for code in 200 404 500 999; do
    echo "  $code: $(get_status_message $code)"
done

# PRACTICAL EXAMPLE 8: GRAPH/ADJACENCY LIST

echo ""
echo "=== PRACTICAL EXAMPLE 8: GRAPH REPRESENTATION ==="

declare -A graph
graph[A]="B C"
graph[B]="A D"
graph[C]="A D E"
graph[D]="B C"
graph[E]="C"

echo "Graph (Adjacency List):"
for node in "${!graph[@]}"; do
    echo "  $node -> ${graph[$node]}"
done

# Get neighbors
get_neighbors() {
    local node=$1
    echo "${graph[$node]}"
}

echo "Neighbors of C: $(get_neighbors C)"

# PRACTICAL EXAMPLE 9: METADATA STORAGE

echo ""
echo "=== PRACTICAL EXAMPLE 9: FILE METADATA ==="

declare -A file_metadata

# Store metadata
file_metadata[document.txt.size]="1024"
file_metadata[document.txt.modified]="2024-01-15"
file_metadata[document.txt.owner]="john"
file_metadata[image.jpg.size]="2048"
file_metadata[image.jpg.modified]="2024-01-20"

echo "File Metadata:"
for key in "${!file_metadata[@]}"; do
    echo "  $key: ${file_metadata[$key]}"
done

# ASSOCIATIVE ARRAY BEST PRACTICES

echo ""
echo "=== BEST PRACTICES ==="

: '
1. Always use "declare -A" before using associative arrays
2. Quote keys and values to handle spaces
3. Use meaningful key names
4. Check if key exists before accessing
5. Use associative arrays for lookup tables
6. Consider memory usage for large datasets
7. Use consistent key naming conventions
8. Document the structure of your associative arrays
9. Validate keys before use
10. Use functions to encapsulate array operations
'

# COMMON USE CASES

echo ""
echo "=== COMMON USE CASES ==="

: '
1. Configuration management
2. Caching
3. Counting/frequency analysis
4. Translation tables
5. Status code mappings
6. User directories
7. Graph representations
8. Metadata storage
9. Feature flags
10. Lookup tables
'

echo ""
echo "Associative arrays tutorial complete!"
