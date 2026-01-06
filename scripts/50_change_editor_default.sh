#!/bin/bash

# Define the configuration file path
CONFIG_FILE="${HOME}/.config/uwsm/default"

# Define the pattern to search for (nvim) and the replacement line (helix)
SEARCH_PATTERN="export EDITOR=nvim"
REPLACE_LINE="export EDITOR=helix"

# Check if the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Warning: Configuration file not found at $CONFIG_FILE"
    echo "Skipping editor default change. This is non-critical."
    exit 0
fi

echo "Attempting to change editor setting in: $CONFIG_FILE"

# Use 'sed' to perform an in-place substitution.
# The '^' and '$' anchors ensure we match the entire line exactly.
# The 'g' flag ensures all instances on the matched line are replaced (though only one is expected).
# The -i flag makes the change directly in the file.
sed -i "s|^$SEARCH_PATTERN|$REPLACE_LINE|g" "$CONFIG_FILE"

# Check if the sed command was successful (exit code 0)
if [[ $? -eq 0 ]]; then
    # Verify the change (optional, but good practice)
    if grep -q "$REPLACE_LINE" "$CONFIG_FILE"; then
        echo "Successfully updated '$SEARCH_PATTERN' to '$REPLACE_LINE'."
    else
        echo "Warning: Sed executed, but verification failed. Check the file manually."
    fi
else
    echo "Warning: Failed to execute sed command. The file may be read-only or have permission issues."
    echo "This is non-critical - continuing with installation."
fi
