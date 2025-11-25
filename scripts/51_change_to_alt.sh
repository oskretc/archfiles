#!/bin/bash

# --- Configuration Variables ---
# Use $HOME for robustness across different shell environments
TARGET_FILE="${HOME}/.config/hypr/input.conf"

# The EXACT line we are searching for (the original state)
OLD_PATTERN="kb_options = compose:caps # ,grp:shifts_toggle"

# The EXACT line we want to replace it with (the desired state)
NEW_LINE="kb_options = compose:caps,altwin:swap_alt_win # ,grp:shifts_toggle"

# --- Script Logic ---

# 1. Check if the target file exists
if [ ! -f "$TARGET_FILE" ]; then
    echo "❌ Error: Target file not found at $TARGET_FILE. Please verify the path."
    exit 1
fi

echo "Target configuration file: $TARGET_FILE"

# 2. Check if the configuration is already in the desired state (idempotence check)
if grep -qF "$NEW_LINE" "$TARGET_FILE"; then
    echo "✅ Configuration already updated to the desired state. No changes made."
    exit 0
fi

# 3. Check if the OLD_PATTERN exists to ensure we modify the correct line
if grep -qF "$OLD_PATTERN" "$TARGET_FILE"; then
    
    # Use 'sed -i' to perform in-place replacement.
    # We use '|' as the delimiter in 's///' to avoid escaping the '/' character if it were in the path.
    # The 'g' flag ensures all occurrences on the line are replaced (though there should only be one).
    sed -i "s|$OLD_PATTERN|$NEW_LINE|g" "$TARGET_FILE"
    
    # Check if sed executed successfully
    if [ $? -eq 0 ]; then
        echo "✨ Success! The line has been updated in $TARGET_FILE:"
        echo "   FROM: $OLD_PATTERN"
        echo "   TO:   $NEW_LINE"
    else
        echo "❌ Error: Substitution failed. Check file permissions."
        exit 1
    fi
else
    echo "⚠️ Warning: The original line '$OLD_PATTERN' was not found."
    echo "   The file may already be configured differently, or the line might have been modified."
    echo "   Please check $TARGET_FILE manually."
    exit 1
fi
