#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

pkg_install zsh

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
    echo "Please install zsh first."
fi

# 2. Check if the current shell is already the target shell
if [ "$CURRENT_SHELL" = "$TARGET_SHELL" ]; then
    echo "Success: The default shell is already set to $TARGET_SHELL ($ZSH_PATH). No changes made."
else

    # 3. Perform the shell change
    echo "Attempting to change default shell to $TARGET_SHELL ($ZSH_PATH)..."
    echo "Note: This will require your user password."

    chsh -s "$ZSH_PATH"

    if [ $? -eq 0 ]; then
        echo "Successfully updated the default shell to $TARGET_SHELL."
        echo "The change will take effect the next time you log in or open a new terminal session."
    else
        echo "Warning: Failed to change the default shell using 'chsh'."
        echo "zsh is installed, but you can change the default shell manually later with:"
        echo "  chsh -s $(which zsh)"
    fi

fi
