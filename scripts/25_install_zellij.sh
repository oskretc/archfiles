#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# Zellij terminal multiplexer - https://zellij.dev
case "$DISTRO" in
    arch)
        pkg_install zellij
        ;;
    *)
        _arch_pattern="x86_64"
        [ "$SYS_ARCH" = "aarch64" ] && _arch_pattern="aarch64"
        install_github_binary "zellij-org/zellij" "zellij" "${_arch_pattern}.*linux.*musl.*tar.gz"
        ;;
esac
