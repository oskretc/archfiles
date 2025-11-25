#!/bin/bash

# =================================================================
# SCRIPT: source_scripts.sh
# DESCRIPTION: Finds and sources all .sh files within a target directory.
#
# USAGE:
#   ./source_scripts.sh /path/to/your/scripts/folder
#
# NOTE: Sourcing executes the script in the CURRENT shell environment.
# This means any functions or variable changes will remain after the
# script finishes. Use 'bash' or './' if you want a subshell execution.
# =================================================================

# 1. Define the target directory
# Check if a directory path was provided as an argument
if [ -z "$1" ]; then
    echo "ERROR: Please provide a target directory path." >&2
    echo "Usage: $0 /path/to/scripts/folder" >&2
    exit 1
fi

TARGET_DIR="$1"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "ERROR: Directory '$TARGET_DIR' does not exist." >&2
    exit 1
fi

echo "Searching for and sourcing .sh files in: $TARGET_DIR"
echo "--------------------------------------------------------"

# 2. Find files and execute the sourcing
# The 'find' command locates all files ending in '.sh' recursively.
# We use -print0 and 'while IFS= read -r -d $'\0' ...' for safe handling
# of file names that contain spaces or special characters.
find "$TARGET_DIR" -type f -name "*.sh" -print0 | while IFS= read -r -d $'\0' SCRIPT_PATH; do
    
    echo "-> Sourcing: $SCRIPT_PATH"
    
    # The '.' operator (or 'source') executes the script in the current shell.
    # We check if the file is readable before attempting to source.
    if [ -r "$SCRIPT_PATH" ]; then
        # Execute the script
        . "$SCRIPT_PATH"
        
        # Check the exit status of the sourced script
        if [ $? -eq 0 ]; then
            echo "   [SUCCESS] Sourced successfully."
        else
            # Note: This checks the exit status of the LAST command in the sourced script,
            # which might not always reflect a "full" failure, but it's the best measure.
            echo "   [WARNING] Script returned a non-zero exit status." >&2
        fi
    else
        echo "   [ERROR] Cannot read file: $SCRIPT_PATH (Check permissions)" >&2
    fi

done

echo "--------------------------------------------------------"
echo "All files processed. Environment updates from sourced scripts are now active."

# Exit with success status
exit 0



