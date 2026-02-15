#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Zinit (Zsh plugin manager)
# Note: .zshrc also auto-installs zinit if missing, so this is optional.
case "$DISTRO" in
    arch)
        pkg_install zinit
        ;;
    *)
        ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
        if [ -d "$ZINIT_HOME" ]; then
            echo "Zinit already installed at $ZINIT_HOME"
        else
            echo "Installing Zinit via git clone..."
            mkdir -p "$(dirname "$ZINIT_HOME")"
            git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
            echo "Zinit installed to $ZINIT_HOME"
        fi
        ;;
esac
