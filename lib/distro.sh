#!/bin/sh
# =================================================================
# LIBRARY: lib/distro.sh
# DESCRIPTION: Distro detection and multi-distro package management
# Supports: Arch Linux (+ derivatives), Debian/Ubuntu, Fedora
#
# USAGE: Source this file at the top of installation scripts:
#   . "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"
#
# PROVIDES:
#   $DISTRO               - "arch", "debian", "fedora", or "unknown"
#   $SYS_ARCH             - system architecture (x86_64, aarch64, etc.)
#   pkg_install           - install packages via the native package manager
#   pkg_name              - resolve canonical package name for current distro
#   pkg_update            - refresh the package database
#   ensure_symlink        - create compatibility symlinks (e.g. fdfind -> fd)
#   install_github_binary - install a binary from GitHub releases
# =================================================================

# -----------------------------------------------------------------
# Detect the distribution family
# -----------------------------------------------------------------
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            arch|endeavouros|manjaro|garuda|artix|cachyos)
                echo "arch" ;;
            debian|ubuntu|linuxmint|pop|zorin|elementary|kali|raspbian)
                echo "debian" ;;
            fedora|nobara|ultramarine|bazzite)
                echo "fedora" ;;
            *)
                # Fall back to ID_LIKE
                case "${ID_LIKE:-}" in
                    *arch*)            echo "arch" ;;
                    *debian*|*ubuntu*) echo "debian" ;;
                    *fedora*|*rhel*)   echo "fedora" ;;
                    *)                 echo "unknown" ;;
                esac
                ;;
        esac
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/fedora-release ]; then
        echo "fedora"
    else
        echo "unknown"
    fi
}

# Only detect once per session
if [ -z "$DISTRO" ]; then
    DISTRO=$(detect_distro)
    export DISTRO
    echo "[distro.sh] Detected distribution family: $DISTRO"
fi

SYS_ARCH=$(uname -m)
export SYS_ARCH

# -----------------------------------------------------------------
# Package name mapping: canonical -> distro-specific
# Add entries here when a package has a different name across distros.
# If a canonical name is not listed, it passes through unchanged.
# Return empty string "" for packages unavailable via package manager.
# -----------------------------------------------------------------
pkg_name() {
    _canonical="$1"
    case "$DISTRO" in
        arch)
            case "$_canonical" in
                github-cli)  echo "github-cli" ;;
                noto-emoji)  echo "noto-fonts-emoji" ;;
                nerd-fonts)  echo "nerd-fonts" ;;
                git-delta)   echo "git-delta" ;;
                *)           echo "$_canonical" ;;
            esac
            ;;
        debian)
            case "$_canonical" in
                fd)          echo "fd-find" ;;
                github-cli)  echo "gh" ;;
                noto-emoji)  echo "fonts-noto-color-emoji" ;;
                git-delta)   echo "" ;;  # not in repos, use GitHub .deb
                nerd-fonts)  echo "" ;;  # not in repos, use manual install
                *)           echo "$_canonical" ;;
            esac
            ;;
        fedora)
            case "$_canonical" in
                fd)          echo "fd-find" ;;
                github-cli)  echo "gh" ;;
                noto-emoji)  echo "google-noto-emoji-fonts" ;;
                git-delta)   echo "git-delta" ;;
                nerd-fonts)  echo "" ;;  # not in repos, use manual install
                *)           echo "$_canonical" ;;
            esac
            ;;
        *)
            echo "$_canonical"
            ;;
    esac
}

# -----------------------------------------------------------------
# Install packages using the native package manager
# Usage: pkg_install bat fd ripgrep
# -----------------------------------------------------------------
pkg_install() {
    for _pkg in "$@"; do
        _resolved=$(pkg_name "$_pkg")
        if [ -z "$_resolved" ]; then
            echo "WARNING: Package '$_pkg' is not available via package manager on $DISTRO. Skipping."
            return 1
        fi
        echo "-> Installing '$_resolved' (canonical: $_pkg) on $DISTRO..."
        case "$DISTRO" in
            arch)
                if command -v yay >/dev/null 2>&1; then
                    yay -S --noconfirm --needed "$_resolved"
                elif command -v paru >/dev/null 2>&1; then
                    paru -S --noconfirm --needed "$_resolved"
                else
                    sudo pacman -S --noconfirm --needed "$_resolved"
                fi
                ;;
            debian)
                sudo apt-get install -y "$_resolved"
                ;;
            fedora)
                sudo dnf install -y "$_resolved"
                ;;
            *)
                echo "ERROR: Unsupported distribution '$DISTRO'. Install '$_resolved' manually."
                return 1
                ;;
        esac
    done
}

# -----------------------------------------------------------------
# Refresh the package database
# Call once before running multiple install scripts
# -----------------------------------------------------------------
pkg_update() {
    echo "-> Refreshing package database for $DISTRO..."
    case "$DISTRO" in
        arch)
            sudo pacman -Sy
            ;;
        debian)
            sudo apt-get update
            ;;
        fedora)
            sudo dnf check-update || true  # returns 100 if updates available
            ;;
    esac
}

# -----------------------------------------------------------------
# Create a symlink in ~/.local/bin for compatibility
# Usage: ensure_symlink "source_binary" "link_name"
# Example: ensure_symlink "fdfind" "fd"
# -----------------------------------------------------------------
ensure_symlink() {
    _src_cmd="$1"
    _link_name="$2"

    # If the link_name command already exists, nothing to do
    if command -v "$_link_name" >/dev/null 2>&1; then
        return 0
    fi

    _src_path=$(command -v "$_src_cmd" 2>/dev/null || true)
    if [ -n "$_src_path" ]; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$_src_path" "$HOME/.local/bin/$_link_name"
        echo "   Created symlink: $_link_name -> $_src_path"
    fi
}

# -----------------------------------------------------------------
# Install a binary from GitHub releases
# Usage: install_github_binary "owner/repo" "binary_name" "url_grep_pattern"
# Example: install_github_binary "jesseduffield/lazygit" "lazygit" "Linux_x86_64.*tar.gz"
#
# Supports: .tar.gz, .tar.xz, .zip, .deb, .rpm archives
# Installs to ~/.local/bin by default (except .deb/.rpm which go system-wide)
# -----------------------------------------------------------------
install_github_binary() {
    _repo="$1"
    _binary="$2"
    _url_grep="$3"

    if command -v "$_binary" >/dev/null 2>&1; then
        echo "   $_binary is already installed: $(command -v "$_binary")"
        return 0
    fi

    echo "-> Installing $_binary from GitHub releases ($_repo)..."

    _download_url=$(curl -fsSL "https://api.github.com/repos/$_repo/releases/latest" \
        | grep "browser_download_url" \
        | grep -i "$_url_grep" \
        | head -1 \
        | sed 's/.*"browser_download_url": *"//;s/".*//')

    if [ -z "$_download_url" ]; then
        echo "ERROR: Could not find download URL for $_binary."
        echo "       Install manually: https://github.com/$_repo/releases"
        return 1
    fi

    _tmpdir=$(mktemp -d)
    echo "   Downloading: $_download_url"
    curl -fsSL "$_download_url" -o "$_tmpdir/download"

    mkdir -p "$HOME/.local/bin"

    case "$_download_url" in
        *.tar.gz|*.tgz)
            tar xzf "$_tmpdir/download" -C "$_tmpdir"
            _found=$(find "$_tmpdir" -name "$_binary" -type f 2>/dev/null | head -1)
            if [ -n "$_found" ]; then
                cp "$_found" "$HOME/.local/bin/$_binary"
            else
                echo "ERROR: '$_binary' not found in archive."
                rm -rf "$_tmpdir"
                return 1
            fi
            ;;
        *.tar.xz|*.txz)
            tar xJf "$_tmpdir/download" -C "$_tmpdir"
            _found=$(find "$_tmpdir" -name "$_binary" -type f 2>/dev/null | head -1)
            if [ -n "$_found" ]; then
                cp "$_found" "$HOME/.local/bin/$_binary"
            else
                echo "ERROR: '$_binary' not found in archive."
                rm -rf "$_tmpdir"
                return 1
            fi
            ;;
        *.zip)
            unzip -o "$_tmpdir/download" -d "$_tmpdir/extracted" >/dev/null
            _found=$(find "$_tmpdir/extracted" -name "$_binary" -type f 2>/dev/null | head -1)
            if [ -n "$_found" ]; then
                cp "$_found" "$HOME/.local/bin/$_binary"
            else
                echo "ERROR: '$_binary' not found in archive."
                rm -rf "$_tmpdir"
                return 1
            fi
            ;;
        *.deb)
            sudo dpkg -i "$_tmpdir/download" || sudo apt-get install -f -y
            rm -rf "$_tmpdir"
            echo "   $_binary installed via .deb package"
            return 0
            ;;
        *.rpm)
            sudo rpm -ivh "$_tmpdir/download"
            rm -rf "$_tmpdir"
            echo "   $_binary installed via .rpm package"
            return 0
            ;;
        *)
            # Assume raw binary
            cp "$_tmpdir/download" "$HOME/.local/bin/$_binary"
            ;;
    esac

    chmod +x "$HOME/.local/bin/$_binary"
    rm -rf "$_tmpdir"
    echo "   $_binary installed to ~/.local/bin/$_binary"
}
