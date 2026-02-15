#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Nerd Fonts - https://www.nerdfonts.com
case "$DISTRO" in
    arch)
        pkg_install nerd-fonts
        ;;
    *)
        # Install Hack Nerd Font from GitHub releases
        echo "Installing Hack Nerd Font from GitHub..."
        _version=$(curl -fsSL "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" \
            | grep '"tag_name"' | sed 's/.*"tag_name": *"//;s/".*//')

        if [ -z "$_version" ]; then
            echo "ERROR: Could not determine latest Nerd Fonts version."
            echo "Download manually: https://www.nerdfonts.com/font-downloads"
        else
            _tmpdir=$(mktemp -d)
            echo "   Downloading Hack Nerd Font ${_version}..."
            curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/${_version}/Hack.zip" \
                -o "$_tmpdir/Hack.zip"
            mkdir -p "$HOME/.local/share/fonts"
            unzip -o "$_tmpdir/Hack.zip" -d "$HOME/.local/share/fonts/" >/dev/null
            rm -rf "$_tmpdir"
            fc-cache -f 2>/dev/null || true
            echo "   Hack Nerd Font installed to ~/.local/share/fonts/"
        fi
        ;;
esac
