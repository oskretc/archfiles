#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Scooter (TUI search & replace) - https://github.com/thomasschafer/scooter
case "$DISTRO" in
    arch)
        pkg_install scooter
        ;;
    *)
        if command -v scooter >/dev/null 2>&1; then
            echo "scooter is already installed."
        elif command -v cargo >/dev/null 2>&1; then
            echo "Installing scooter via cargo..."
            cargo install scooter
        else
            echo "WARNING: scooter is only packaged for Arch (AUR)."
            echo "Install Rust/Cargo and run: cargo install scooter"
            echo "Or download from: https://github.com/thomasschafer/scooter/releases"
        fi
        ;;
esac
