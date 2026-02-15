#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Google Chrome
case "$DISTRO" in
    arch)
        pkg_install google-chrome
        ;;
    debian)
        if command -v google-chrome-stable >/dev/null 2>&1; then
            echo "Google Chrome is already installed."
        else
            echo "Installing Google Chrome from official .deb..."
            wget -q -O /tmp/google-chrome.deb \
                https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            sudo dpkg -i /tmp/google-chrome.deb || sudo apt-get install -f -y
            rm -f /tmp/google-chrome.deb
        fi
        ;;
    fedora)
        if command -v google-chrome-stable >/dev/null 2>&1; then
            echo "Google Chrome is already installed."
        else
            echo "Installing Google Chrome from official .rpm..."
            sudo dnf install -y \
                https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
        fi
        ;;
    *)
        echo "ERROR: Unsupported distro. Download Chrome from: https://www.google.com/chrome/"
        ;;
esac
