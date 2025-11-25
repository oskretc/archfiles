#!/bin/sh

yay -S --noconfirm --needed zsh

#!/bin/bash

# --- Shell Change Script ---
# This script checks the current default shell for the user and changes it to zsh
# only if it is not already set to zsh.

ZSH_PATH=$(which zsh)
CURRENT_SHELL=$(basename "$SHELL")
TARGET_SHELL="zsh"

echo "Current user's default shell is: $CURRENT_SHELL"

# 1. Check if zsh is installed on the system
if [ -z "$ZSH_PATH" ]; then
    echo "Error: The '$TARGET_SHELL' command was not found."
    echo "Please install zsh first (e.g., 'sudo apt install zsh' or 'sudo yum install zsh')."
    exit 1
fi

# 2. Check if the current shell is already the target shell
if [ "$CURRENT_SHELL" = "$TARGET_SHELL" ]; then
    echo "Success: The default shell is already set to $TARGET_SHELL ($ZSH_PATH). No changes made."
    exit 0
fi

# 3. Perform the shell change
echo "Attempting to change default shell to $TARGET_SHELL ($ZSH_PATH)..."
echo "Note: This will require your user password."

# 'chsh' modifies the user's entry in /etc/passwd.
# The -s option specifies the new login shell.
chsh -s "$ZSH_PATH"

# Check the exit status of the chsh command
if [ $? -eq 0 ]; then
    echo "Successfully updated the default shell to $TARGET_SHELL."
    echo "The change will take effect the next time you log in or open a new terminal session."
else
    echo "Error: Failed to change the default shell using 'chsh'."
    echo "This might be due to incorrect password or permissions."
    exit 1
fi
