#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# GitHub CLI - https://cli.github.com
case "$DISTRO" in
    arch)
        pkg_install github-cli
        ;;
    debian)
        # Official GitHub CLI apt repository
        # See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
        if command -v gh >/dev/null 2>&1; then
            echo "GitHub CLI is already installed."
        else
            sudo mkdir -p -m 755 /etc/apt/keyrings
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
                | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
            sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
                | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
            sudo apt-get update
            sudo apt-get install -y gh
        fi
        ;;
    fedora)
        sudo dnf install -y gh
        ;;
    *)
        echo "ERROR: Unsupported distro. Install from: https://cli.github.com"
        ;;
esac
