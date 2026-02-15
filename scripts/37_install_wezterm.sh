#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# WezTerm terminal emulator - https://wezfurlong.org/wezterm/install/linux.html
case "$DISTRO" in
    arch)
        pkg_install wezterm
        ;;
    debian)
        if command -v wezterm >/dev/null 2>&1; then
            echo "WezTerm is already installed."
        else
            # Official WezTerm apt repository
            curl -fsSL https://apt.fury.io/wez/gpg.key \
                | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
            echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' \
                | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
            sudo apt-get update
            sudo apt-get install -y wezterm
        fi
        ;;
    fedora)
        if command -v wezterm >/dev/null 2>&1; then
            echo "WezTerm is already installed."
        else
            # Try base repos first, fall back to COPR
            if ! sudo dnf install -y wezterm 2>/dev/null; then
                sudo dnf copr enable -y wezfurlong/wezterm-nightly
                sudo dnf install -y wezterm
            fi
        fi
        ;;
    *)
        echo "ERROR: Unsupported distro. Install from: https://wezfurlong.org/wezterm/install/linux.html"
        ;;
esac
