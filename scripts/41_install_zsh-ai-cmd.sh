#!/bin/sh

# Install zsh-ai-cmd
# This script clones the zsh-ai-cmd plugin to ~/.zsh-ai-cmd

ZSH_AI_CMD_DIR="${HOME}/.zsh-ai-cmd"
ZSH_AI_CMD_REPO="https://github.com/paoloantinori/zsh-ai-cmd.git"

echo "Installing zsh-ai-cmd..."

# Check if zsh-ai-cmd directory already exists
if [ -d "$ZSH_AI_CMD_DIR" ]; then
    echo "zsh-ai-cmd directory already exists at $ZSH_AI_CMD_DIR"
    echo "Updating repository..."
    if ! (cd "$ZSH_AI_CMD_DIR" && git pull); then
        echo "Warning: Failed to update repository. Continuing with existing installation."
        echo "You may want to remove $ZSH_AI_CMD_DIR and reinstall if you encounter issues."
    fi
else
    # Clone the repository
    echo "Cloning zsh-ai-cmd from $ZSH_AI_CMD_REPO..."
    if git clone "$ZSH_AI_CMD_REPO" "$ZSH_AI_CMD_DIR"; then
        echo "Success: zsh-ai-cmd installed successfully at $ZSH_AI_CMD_DIR"
    else
        echo "Warning: Failed to clone zsh-ai-cmd repository."
        echo "This may be due to network issues or repository access problems."
        echo "You can try installing manually: git clone $ZSH_AI_CMD_REPO $ZSH_AI_CMD_DIR"
        # Continue execution - the verification step will catch if installation failed
    fi
fi

# Verify the plugin file exists
if [ -f "$ZSH_AI_CMD_DIR/zsh-ai-cmd.plugin.zsh" ]; then
    echo "Plugin file found."
    
    # Check if .zshrc exists
    ZSHRC_FILE="${HOME}/.zshrc"
    SOURCE_LINE="source ~/.zsh-ai-cmd/zsh-ai-cmd.plugin.zsh"
    
    if [ -f "$ZSHRC_FILE" ]; then
        # Check if the source line already exists
        if grep -q "zsh-ai-cmd.plugin.zsh" "$ZSHRC_FILE"; then
            echo "Source line already exists in $ZSHRC_FILE"
        else
            # Add the source line to .zshrc
            echo "" >> "$ZSHRC_FILE"
            echo "# zsh-ai-cmd plugin" >> "$ZSHRC_FILE"
            echo "$SOURCE_LINE" >> "$ZSHRC_FILE"
            echo "Success: Added source line to $ZSHRC_FILE"
        fi
    else
        echo "Warning: $ZSHRC_FILE not found. Please add this line manually:"
        echo "  $SOURCE_LINE"
    fi
    
    echo "zsh-ai-cmd is ready to use. Reload your shell or run: source ~/.zshrc"
else
    echo "Warning: Plugin file not found at expected location: $ZSH_AI_CMD_DIR/zsh-ai-cmd.plugin.zsh"
    echo "Installation may have failed. Please check the installation manually."
    echo "You can try: git clone $ZSH_AI_CMD_REPO $ZSH_AI_CMD_DIR"
    # Don't exit with error - allow other scripts to continue
fi
