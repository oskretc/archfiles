#!/bin/bash

# Configuration
LINE_TO_ADD="source = ~/.config/hypr/myhyper.conf"
TARGET_FILE=~/.config/hypr/hyprland.conf # Target file is passed as the first argument

# --- Function to check and add the line ---
add_line_if_missing() {
    local file="$1"
    local line="$2"

    if [ -z "$file" ]; then
        echo "Error: Target file not provided."
        return 1
    fi

    # Check if the line already exists in the file
    # The -q flag makes grep quiet, it only sets the exit status (0 for found, 1 for not found)
    if grep -qF "$line" "$file"; then
        echo "✅ Line already exists in $file. No changes made."
    else
        echo "➕ Line not found in $file."
        echo "Adding the line: $line"
        
        # Append the line to the end of the file
        echo "$line" >> "$file"
        
        if [ $? -eq 0 ]; then
            echo "✨ Successfully added the line to $file."
        else
            echo "⚠️  Warning: Could not write to $file. Check file permissions."
            echo "   You can manually add this line to $file:"
            echo "   $line"
            # Don't return error - allow script to continue
        fi
    fi
}

# --- Script Execution ---

# Check if a target file was provided as a command-line argument
if [ -z "$1" ]; then
    echo "Usage: $0 <target_file>"
    echo "Example: $0 ~/.config/hypr/hyprland.conf"
    exit 1
fi

add_line_if_missing "$TARGET_FILE" "$LINE_TO_ADD"
