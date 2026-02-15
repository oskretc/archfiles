#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

# LazyGit - https://github.com/jesseduffield/lazygit
case "$DISTRO" in
    arch)
        pkg_install lazygit
        ;;
    fedora)
        sudo dnf copr enable -y atim/lazygit 2>/dev/null || true
        sudo dnf install -y lazygit
        ;;
    debian)
        _arch_pattern="Linux_x86_64"
        [ "$SYS_ARCH" = "aarch64" ] && _arch_pattern="Linux_arm64"
        install_github_binary "jesseduffield/lazygit" "lazygit" "${_arch_pattern}.*tar.gz"
        ;;
    *)
        echo "ERROR: Unsupported distro. Install from: https://github.com/jesseduffield/lazygit/releases"
        ;;
esac
