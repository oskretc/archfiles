#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Git Delta (syntax-highlighting pager) - https://github.com/dandavison/delta
case "$DISTRO" in
    arch)
        pkg_install git-delta
        ;;
    fedora)
        sudo dnf install -y git-delta
        ;;
    debian)
        # Delta is not in Debian/Ubuntu repos; install .deb from GitHub
        _arch_pattern="amd64"
        [ "$SYS_ARCH" = "aarch64" ] && _arch_pattern="arm64"
        install_github_binary "dandavison/delta" "delta" "git-delta.*${_arch_pattern}.*\\.deb"
        ;;
    *)
        echo "ERROR: Unsupported distro. Install from: https://github.com/dandavison/delta/releases"
        ;;
esac
