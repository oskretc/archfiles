#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Fastfetch - https://github.com/fastfetch-cli/fastfetch
case "$DISTRO" in
    arch)
        pkg_install fastfetch
        ;;
    fedora)
        # Available in Fedora base repos
        pkg_install fastfetch
        ;;
    debian)
        # Available in Ubuntu 24.04+ / Debian 13+; fall back to GitHub .deb
        if ! sudo apt-get install -y fastfetch 2>/dev/null; then
            _arch_pattern="amd64"
            [ "$SYS_ARCH" = "aarch64" ] && _arch_pattern="aarch64"
            install_github_binary "fastfetch-cli/fastfetch" "fastfetch" "linux.*${_arch_pattern}.*\\.deb"
        fi
        ;;
    *)
        echo "ERROR: Unsupported distro. Install from: https://github.com/fastfetch-cli/fastfetch/releases"
        ;;
esac
