#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# SKM (SSH Key Manager)
case "$DISTRO" in
    arch)
        pkg_install skm
        ;;
    *)
        if command -v skm >/dev/null 2>&1; then
            echo "skm is already installed."
        elif command -v go >/dev/null 2>&1; then
            echo "Installing skm via go install..."
            go install github.com/TimothyYe/skm/cmd/skm@latest
        else
            echo "WARNING: skm is only packaged for Arch (AUR)."
            echo "Install Go and run: go install github.com/TimothyYe/skm/cmd/skm@latest"
            echo "Or download from the project's GitHub releases page."
        fi
        ;;
esac
