#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Yazi file manager - https://yazi-rs.github.io
case "$DISTRO" in
    arch)
        pkg_install yazi
        ;;
    fedora)
        # Try dnf first (available in newer Fedora versions)
        if sudo dnf install -y yazi 2>/dev/null; then
            echo "Yazi installed via dnf"
        else
            _arch_pattern="x86_64"
            [ "$SYS_ARCH" = "aarch64" ] && _arch_pattern="aarch64"
            install_github_binary "sxyazi/yazi" "yazi" "${_arch_pattern}.*linux.*gnu.*zip"
        fi
        ;;
    debian)
        _arch_pattern="x86_64"
        [ "$SYS_ARCH" = "aarch64" ] && _arch_pattern="aarch64"
        install_github_binary "sxyazi/yazi" "yazi" "${_arch_pattern}.*linux.*gnu.*zip"
        ;;
    *)
        echo "ERROR: Unsupported distro for Yazi. Install from: https://github.com/sxyazi/yazi/releases"
        ;;
esac
