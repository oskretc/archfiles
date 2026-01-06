# Arch Linux Dotfiles

A comprehensive collection of dotfiles and configuration files for Arch Linux, featuring modern terminal tools, window managers, and development environments.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Structure](#structure)
- [Components](#components)
- [Configuration](#configuration)
- [Usage](#usage)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This repository contains dotfiles and installation scripts for a modern Arch Linux setup, including:

- **Shell**: Zsh with Powerlevel10k, Zinit, and various plugins
- **Terminal**: WezTerm with custom themes
- **Window Manager**: Niri (Wayland compositor)
- **File Manager**: Yazi
- **Editor**: Helix with extensive language server support
- **Terminal Multiplexer**: Zellij
- **Git Tools**: LazyGit, Delta, GitHub CLI
- **System Tools**: Atuin (shell history), FastFetch, Btop, and more

## 📦 Prerequisites

- Arch Linux (or an Arch-based distribution)
- `yay` AUR helper installed
- Git
- Basic knowledge of shell scripting

## 🚀 Installation

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/archfiles.git
   cd archfiles
   ```

2. **Review and customize personal information:**
   - Edit `gitconfig/.gitconfig` to set your name and email
   - Update any hardcoded paths in configuration files (see [Customization](#customization))
   - Set up environment variables for sensitive data (see [Configuration](#configuration))

3. **Run the installation script:**
   ```bash
   chmod +x master_installation.sh execute_scripts.sh
   ./master_installation.sh
   ```

   This will execute all installation scripts in the `scripts/` directory in order.

### Manual Installation

If you prefer to install components individually:

```bash
# Install specific components
./scripts/12_install_zsh.sh
./scripts/20_install_helix.sh
./scripts/21_install_yazi.sh
# ... etc
```

### Using GNU Stow (Recommended)

After installing Stow (`./scripts/22_install_stow.sh`), you can symlink configurations:

```bash
# From the repository root
stow zsh
stow helix
stow yazi
# ... etc
```

## 📁 Structure

```
archfiles/
├── atuin/              # Atuin shell history configuration
├── eza/                # Eza (better ls) theme configuration
├── gitconfig/          # Git global configuration
├── helix/              # Helix editor configuration
│   └── .config/helix/
│       ├── config.toml
│       ├── languages.toml
│       └── themes/
├── hypr/               # Hyprland window manager configs
├── kanata/             # Kanata keyboard remapping
├── lazygit/            # LazyGit configuration
├── localbin/           # Local binary scripts
├── niri/               # Niri Wayland compositor config
├── scripts/            # Installation scripts
│   ├── 10_install_restic.sh
│   ├── 11_install_skm.sh
│   ├── 12_install_zsh.sh
│   ├── 40_install_cursor-agent-cli.sh
│   └── ...
├── systemd/            # Systemd user services
├── wezterm/            # WezTerm terminal configuration
├── xdg/                # XDG MIME and terminal configurations
├── yazi/               # Yazi file manager configuration
├── zellij/             # Zellij terminal multiplexer config
├── zsh/                # Zsh shell configuration
│   ├── .zshrc
│   ├── .p10k.zsh
│   └── aliases.zsh
├── execute_scripts.sh  # Script executor utility
├── master_installation.sh  # Main installation script
└── pkglist.txt         # List of installed packages
```

## 🧩 Components

### Shell: Zsh

**Location**: `zsh/`

- **Powerlevel10k**: Fast and customizable prompt
- **Zinit**: Fast and flexible Zsh plugin manager
- **Plugins**:
  - `zsh-syntax-highlighting`: Command syntax highlighting
  - `zsh-completions`: Additional completions
  - `zsh-autosuggestions`: History-based autosuggestions
  - `fzf-tab`: Fuzzy completion
  - `zoxide`: Smart directory jumping
  - `atuin`: Enhanced shell history

**Key Aliases**:
- `ls` → `eza` (better ls)
- `cd` → `z` (zoxide)
- `cat` → `bat` (better cat)
- `lg` → `lazygit`
- `hk` → `hx` (helix)
- `en` → `y` (yazi)

### Editor: Helix

**Location**: `helix/.config/helix/`

- Modern modal editor inspired by Kakoune
- Extensive language server support (LSP) for:
  - Rust, Go, Python, JavaScript/TypeScript
  - C/C++, C#, PHP, SQL
  - Markdown, HTML, CSS, JSON, YAML
  - And more
- Custom themes included
- File picker integration with Yazi

**Note**: Some paths in `languages.toml` may need adjustment:
- OmniSharp path: `/home/osto/tmp/omnisharp/OmniSharp`
- LSP-AI config: `${HOME}/.config/helix/lsp-ai-gemini.json` (create this file with your API key if needed)

### Terminal: WezTerm

**Location**: `wezterm/.config/wezterm/`

- Cross-platform terminal emulator
- Custom tabline plugin
- Gruvbox Dark theme
- Background images support

### Window Manager: Niri

**Location**: `niri/.config/niri/`

- Wayland compositor with tiling window management
- Custom keybindings in `mybinds.kdl`
- Multi-monitor support configured

### File Manager: Yazi

**Location**: `yazi/.config/yazi/`

- Terminal file manager with preview support
- Custom keybindings and themes
- Integration with Helix editor

### Terminal Multiplexer: Zellij

**Location**: `zellij/.config/zellij/`

- Terminal workspace manager
- Custom layouts: `newr.kdl`, `rustdev.kdl`, `stacked.kdl`, `tall.kdl`, `uni.kdl`
- Session management

### Git Tools

- **LazyGit**: Terminal UI for Git
- **Delta**: Syntax-highlighting pager for Git
- **GitHub CLI**: Command-line interface for GitHub

### Other Tools

- **Atuin**: Magical shell history
- **FastFetch**: System information display
- **Btop**: System resource monitor
- **FZF**: Fuzzy finder
- **Ripgrep**: Fast text search
- **FD**: Fast file finder
- **Bat**: Better cat with syntax highlighting
- **Eza**: Modern ls replacement
- **Pass**: Password manager integration
- **Restic**: Backup tool
- **Kanata**: Keyboard remapping
- **Cursor Agent CLI**: Command-line interface for Cursor AI agent

## ⚙️ Configuration

### Environment Variables

Before using these dotfiles, set up the following environment variables:

```bash
# SVN password (used in aliases.zsh)
export SVNPASS="your-svn-password"

# Add to ~/.zshenv or ~/.zshrc
```

### Personal Information

**Important**: Before committing or sharing, update:

1. **Git Configuration** (`gitconfig/.gitconfig`):
   ```ini
   [user]
       email = your-email@example.com
       name = Your Name
   ```

2. **Hardcoded Paths**: Replace `/home/osto` with your username or use `$HOME`:
   - `zsh/.zshrc`: Line 48
   - `helix/.config/helix/languages.toml`: Lines 58, 181
   - `zellij/.config/zellij/config.kdl`: Line 12
   - `yazi/.config/yazi/keymap.toml`: Line 28
   - `scripts/50_change_editor_default.sh`: Line 4

3. **SVN Username**: In `zsh/aliases.zsh`, replace `osto` with your SVN username:
   ```bash
   alias svnu="svn update --username YOUR_USERNAME --password $SVNPASS"
   alias svnst="svn status --username YOUR_USERNAME --password $SVNPASS"
   ```

### Package List

The `pkglist.txt` file contains all packages installed via `yay`. To install all packages:

```bash
yay -S --needed - < pkglist.txt
```

## 💡 Usage

### Shell

After installation, restart your shell or run:
```bash
source ~/.zshrc
```

### Helix Editor

Open files with:
```bash
hx filename
# or
hk filename
```

### Yazi File Manager

Launch Yazi:
```bash
yazi
# or
y
```

### Zellij Sessions

Start a new session:
```bash
zellij
```

Use custom layouts:
```bash
zellij --layout rustdev
```

### WezTerm

Launch WezTerm:
```bash
wezterm
```

## 🎨 Customization

### Zsh Prompt

Customize Powerlevel10k:
```bash
p10k configure
```

Or edit `zsh/.p10k.zsh` directly.

### Helix Theme

Edit `helix/.config/helix/config.toml`:
```toml
theme = "your-theme-name"
```

Available themes are in `helix/.config/helix/themes/`.

### WezTerm Colors

Edit `wezterm/.config/wezterm/colors/dank-theme.toml` or modify `wezterm.lua`.

### Niri Configuration

Edit `niri/.config/niri/config.kdl` for window management settings.

## 🔧 Troubleshooting

### Installation Scripts Fail

- Ensure `yay` is installed and configured
- Check internet connection
- Review script output for specific errors

### Zsh Not Default Shell

Run:
```bash
chsh -s $(which zsh)
```

### Helix Language Servers Not Working

- Ensure language servers are installed
- Check paths in `languages.toml`
- Review Helix logs: `:log-open`

### WezTerm Not Starting

- Check Lua syntax in `wezterm.lua`
- Verify plugin URLs are accessible
- Review WezTerm logs

### Permission Issues

Some scripts require sudo. Ensure you have appropriate permissions.

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 Notes

- These dotfiles are configured for Arch Linux. Some adjustments may be needed for other distributions.
- Always review scripts before executing them.
- Backup your existing dotfiles before installation.
- Some configurations include personal paths that need to be updated.

## 🔒 Security & Privacy

**Before sharing or committing:**

1. Remove or replace all personal information (emails, names, usernames)
2. Replace hardcoded paths with environment variables
3. Never commit passwords, API keys, or tokens
4. Review `.gitignore` to ensure sensitive files are excluded
5. Check for any personal data in configuration files

## 📄 License

This project is provided as-is. Feel free to use and modify for your own needs.

---

**Maintained by**: [Your Name]  
**Last Updated**: 2025
