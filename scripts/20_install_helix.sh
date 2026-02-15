#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Helix editor - https://helix-editor.com
case "$DISTRO" in
    arch)
        pkg_install helix
        ;;
    fedora)
        # Helix is available via COPR on Fedora
        sudo dnf copr enable -y varlad/helix 2>/dev/null || true
        sudo dnf install -y helix
        ;;
    debian)
        if command -v hx >/dev/null 2>&1; then
            echo "Helix is already installed."
        else
            # Install from GitHub release (includes runtime)
            echo "Installing Helix from GitHub releases..."
            _version=$(curl -fsSL "https://api.github.com/repos/helix-editor/helix/releases/latest" \
                | grep '"tag_name"' | sed 's/.*"tag_name": *"//;s/".*//')

            if [ -z "$_version" ]; then
                echo "ERROR: Could not determine latest Helix version."
                echo "Install manually: https://github.com/helix-editor/helix/releases"
            else
                _arch="$SYS_ARCH"
                _tmpdir=$(mktemp -d)

                echo "   Downloading helix ${_version} for ${_arch}..."
                curl -fsSL "https://github.com/helix-editor/helix/releases/download/${_version}/helix-${_version}-${_arch}-linux.tar.xz" \
                    -o "$_tmpdir/helix.tar.xz"

                tar xJf "$_tmpdir/helix.tar.xz" -C "$_tmpdir"

                # Install binary
                mkdir -p "$HOME/.local/bin"
                cp "$_tmpdir"/helix-*/hx "$HOME/.local/bin/hx"
                chmod +x "$HOME/.local/bin/hx"

                # Install runtime (required for syntax highlighting, LSP, etc.)
                mkdir -p "$HOME/.config/helix"
                if [ -d "$HOME/.config/helix/runtime" ]; then
                    rm -rf "$HOME/.config/helix/runtime"
                fi
                cp -r "$_tmpdir"/helix-*/runtime "$HOME/.config/helix/runtime"

                rm -rf "$_tmpdir"
                echo "   Helix installed to ~/.local/bin/hx"
                echo "   Runtime installed to ~/.config/helix/runtime/"
            fi
        fi
        ;;
    *)
        echo "ERROR: Unsupported distro '$DISTRO' for Helix installation."
        echo "Install manually: https://github.com/helix-editor/helix/releases"
        ;;
esac
