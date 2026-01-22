# Shell Scripting Tutorial

A comprehensive shell scripting tutorial covering topics from basic to advanced levels with detailed comments and explanations.

## 📚 Table of Contents

### Basic Scripts (01-10)
Learn fundamental shell scripting concepts:

1. **Hello World** (`basic/01_hello_world.sh`)
   - Shebang line
   - Echo command and its options
   - Colored output

2. **Variables** (`basic/02_variables.sh`)
   - Variable declaration and assignment
   - Accessing variables
   - Types of variables (local, environment, built-in)
   - Variable operations
   - Read-only variables

3. **User Input** (`basic/03_user_input.sh`)
   - Read command
   - Reading with prompts
   - Silent input (passwords)
   - Timeouts
   - Reading arrays

4. **Comments** (`basic/04_comments.sh`)
   - Single-line comments
   - Multi-line comments
   - Best practices
   - Documentation tips

5. **Arithmetic Operations** (`basic/05_arithmetic_operations.sh`)
   - Basic operators (+, -, *, /, %, **)
   - Different methods ($(( )), expr, let, bc)
   - Integer and floating-point arithmetic
   - Increment/decrement operators

6. **Comparison Operators** (`basic/06_comparison_operators.sh`)
   - Integer comparisons (-eq, -ne, -gt, -ge, -lt, -le)
   - String comparisons (=, ==, !=, <, >)
   - Using [ ] vs [[ ]] vs (( ))

7. **Logical Operators** (`basic/07_logical_operators.sh`)
   - AND (&&, -a)
   - OR (||, -o)
   - NOT (!)
   - Combining conditions
   - Short-circuit evaluation

8. **String Operations** (`basic/08_string_operations.sh`)
   - String length
   - Concatenation
   - Substring extraction
   - String replacement and deletion
   - Case conversion
   - Pattern matching

9. **Command Line Arguments** (`basic/09_command_line_arguments.sh`)
   - Positional parameters ($1, $2, ...)
   - Special variables ($@, $*, $#, $0)
   - Iterating through arguments
   - Processing options (getopts)

10. **Exit Status** (`basic/10_exit_status.sh`)
    - Understanding exit codes
    - Using $? variable
    - Setting exit status
    - Error handling

### Intermediate Scripts (11-20)
Build on basics with control structures and data structures:

11. **If-Else Conditions** (`intermediate/11_if_else_conditions.sh`)
    - Simple if statements
    - If-else and if-elif-else
    - Nested conditions
    - Multiple conditions
    - File and string tests

12. **Case Statements** (`intermediate/12_case_statements.sh`)
    - Basic case syntax
    - Multiple patterns
    - Pattern matching with wildcards
    - Nested case statements
    - Practical examples (menus, file processing)

13. **For Loops** (`intermediate/13_for_loops.sh`)
    - Basic for loops
    - Ranges and sequences
    - C-style for loops
    - Iterating over arrays and files
    - Nested loops
    - Break and continue

14. **While Loops** (`intermediate/14_while_loops.sh`)
    - Basic while syntax
    - Infinite loops
    - Reading files
    - Multiple conditions
    - Practical examples (menus, monitoring)

15. **Until Loops** (`intermediate/15_until_loops.sh`)
    - Until vs while
    - Waiting for conditions
    - Polling and retry mechanisms
    - Practical examples

16. **Break and Continue** (`intermediate/16_break_continue.sh`)
    - Break statement
    - Continue statement
    - Breaking multiple levels
    - Practical examples (error handling, filtering)

17. **Functions** (`intermediate/17_functions.sh`)
    - Function declaration
    - Parameters and arguments
    - Return values
    - Recursive functions
    - Function libraries

18. **Local vs Global Variables** (`intermediate/18_local_global_variables.sh`)
    - Variable scope
    - Local keyword
    - Variable shadowing
    - Environment variables
    - Best practices

19. **Arrays** (`intermediate/19_arrays.sh`)
    - Array declaration and initialization
    - Accessing elements
    - Array operations (append, slice, delete)
    - Iterating over arrays
    - Sorting and searching

20. **Associative Arrays** (`intermediate/20_associative_arrays.sh`)
    - Declaring associative arrays
    - Key-value operations
    - Iterating over keys and values
    - Practical examples (configs, caching, translations)

### Advanced Scripts (21-30)
Master advanced techniques and real-world scenarios:

21. **File Operations** (`advanced/21_file_operations.sh`)
    - Creating, reading, writing files
    - Copying, moving, deleting
    - File properties and permissions
    - File comparison
    - Practical examples (backup, rotation)

22. **Directory Operations** (`advanced/22_directory_operations.sh`)
    - Creating and managing directories
    - Navigation and directory stack
    - Directory size and permissions
    - Finding directories
    - Practical examples (project structure, monitoring)

23. **File Test Operators** (`advanced/23_file_test_operators.sh`)
    - File type tests (-f, -d, -L, -e)
    - Permission tests (-r, -w, -x)
    - File comparisons (-nt, -ot, -ef)
    - Practical validation examples

24. **Process Management** (Coming soon)
    - Process creation and monitoring
    - Background processes
    - Job control
    - Signal handling

25. **Signals and Traps** (Coming soon)
    - Understanding signals
    - Trap command
    - Cleanup handlers
    - Signal best practices

26. **Input/Output Redirection** (Coming soon)
    - Standard streams (stdin, stdout, stderr)
    - Redirection operators
    - Here documents and strings
    - File descriptors

27. **Pipes and Filters** (Coming soon)
    - Using pipes
    - Command chaining
    - Common filters (grep, sort, uniq)
    - Practical data processing

28. **Text Processing** (Coming soon)
    - grep for searching
    - sed for editing
    - awk for processing
    - Practical examples

29. **Regular Expressions** (Coming soon)
    - Regex basics
    - Pattern matching
    - Extended regex
    - Practical examples

30. **Script Debugging** (Coming soon)
    - Debugging techniques
    - Set options (-x, -e, -u)
    - Error handling
    - Testing strategies

## 🚀 Getting Started

### Prerequisites
- Bash 4.0 or later (for associative arrays)
- Linux, macOS, or WSL on Windows
- Basic command line knowledge

### Running the Scripts

1. Clone the repository:
```bash
git clone https://github.com/ayush1512/shellscript.git
cd shellscript
```

2. Make scripts executable (if needed):
```bash
chmod +x basic/*.sh intermediate/*.sh advanced/*.sh
```

3. Run any script:
```bash
./basic/01_hello_world.sh
./intermediate/11_if_else_conditions.sh
./advanced/21_file_operations.sh
```

## 📖 How to Use This Tutorial

1. **Sequential Learning**: Start with basic scripts and progress through intermediate to advanced
2. **Hands-on Practice**: Run each script and observe the output
3. **Read Comments**: Every script has detailed comments explaining each line
4. **Experiment**: Modify the scripts to understand how changes affect behavior
5. **Build Projects**: Apply learned concepts to create your own scripts

## 💡 Key Features

- ✅ **Comprehensive Coverage**: From basics to advanced topics
- ✅ **Detailed Comments**: Every line explained with syntax and purpose
- ✅ **Practical Examples**: Real-world use cases and scenarios
- ✅ **Best Practices**: Industry-standard coding practices
- ✅ **Progressive Learning**: Concepts build upon each other
- ✅ **Executable Scripts**: All scripts are runnable and tested

## 📝 Learning Tips

1. **Run the Scripts**: Don't just read, execute and see the results
2. **Modify and Experiment**: Change values and see what happens
3. **Use a Text Editor**: Follow along by typing the scripts yourself
4. **Practice Regularly**: Shell scripting is a skill that improves with practice
5. **Build Real Scripts**: Apply what you learn to automate tasks

## 🛠️ Common Commands Reference

### File Operations
```bash
touch file.txt          # Create empty file
cat file.txt           # Display file content
cp file1 file2         # Copy file
mv file1 file2         # Move/rename file
rm file.txt            # Delete file
```

### Directory Operations
```bash
mkdir dir              # Create directory
cd dir                 # Change directory
ls                     # List files
pwd                    # Print working directory
rmdir dir              # Remove empty directory
```

### Text Processing
```bash
grep pattern file      # Search in file
sed 's/old/new/' file  # Replace text
awk '{print $1}' file  # Process columns
sort file              # Sort lines
uniq file              # Remove duplicates
```

## 🔗 Additional Resources

- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/) - Script analysis tool
- [Explain Shell](https://explainshell.com/) - Command explanation tool
- [Bash Hackers Wiki](https://wiki.bash-hackers.org/)

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs or issues
- Suggest new topics or improvements
- Submit pull requests
- Share feedback

## 📄 License

This tutorial is open source and available for educational purposes.

## 👤 Author

**Ayush**
- GitHub: [@ayush1512](https://github.com/ayush1512)

## ⭐ Acknowledgments

Special thanks to the shell scripting community for their invaluable resources and documentation.

---

**Happy Scripting! 🚀**
