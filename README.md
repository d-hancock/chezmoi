# ChezMoi Dotfiles

## Overview

This repository provides a complete, reproducible development environment setup using ChezMoi for dotfile management. It combines modern CLI tools, terminal configuration, and shell enhancements into a unified system that can be deployed across multiple machines with a single command.

### Technology Stack
- **OS & Desktop**: Ubuntu 22.04 LTS + GNOME (Wayland-ready)
- **Terminal**: WezTerm (GPU-accelerated, Lua-configurable)
- **Shell**: Zsh with Zinit plugin manager
- **Prompt**: Starship (cross-shell, TOML-based)
- **Package Management**: Pixi (conda-forge ecosystem)
- **Dotfile Management**: ChezMoi (templating, secrets, cross-platform)

### Key Features
- **One-Command Bootstrap**: Fresh machine setup in minutes
- **Reproducible Environments**: All tools managed via Pixi/conda-forge
- **Modular Configuration**: Separate configs for different tools
- **Template-Driven**: Dynamic configuration based on machine context
- **Cross-Platform Ready**: Designed for Linux with future OS support

### Quick Start

1. Install ChezMoi:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   chezmoi init git@github.com:<you>/dotfiles.git
   chezmoi apply
   ```

2. Customize stubs and rerun `chezmoi apply` to update your environment.

---

## How It Works

### Bootstrap Process
1. **ChezMoi Installation**: Downloads and installs ChezMoi dotfile manager
2. **Repository Clone**: Pulls this configuration repository
3. **One-Time Scripts**: Executes bootstrap scripts for tools, fonts, and directories
4. **Configuration Apply**: Renders and applies all dotfiles to home directory

### Key Components

#### Configuration Files
- **`.chezmoi.toml`**: ChezMoi settings and source directory configuration
- **`dot_zshrc.tmpl`**: Main shell configuration with Zinit and Starship setup
- **`dot_gitconfig`**: Global Git settings and aliases

#### Bootstrap Scripts (run_once_*)
- **`setup_tools.sh.tmpl`**: Installs Pixi and synchronizes all CLI tools
- **`setup_fonts.sh.tmpl`**: Downloads and installs Monaspace Nerd Fonts
- **`setup_dirs.sh.tmpl`**: Creates standard development directories

#### Tool Management
- **`pixi.toml`**: Defines all CLI tools managed via conda-forge
- Tools include: fzf, ripgrep, bat, eza, starship, atuin, and many more
- Fallback to cargo for tools not available in conda-forge

---

## Directory Structure

```
.chezmoi.toml                 # ChezMoi config
pixi.toml                     # Pixi dependencies
run_once_setup_tools.sh.tmpl  # Pixi + extra tools
run_once_setup_fonts.sh.tmpl  # Nerd font installer
run_once_setup_dirs.sh.tmpl   # Directory scaffolding

dot_zshrc.tmpl                # Zsh, Zinit, Starship

dot_config/
  starship/
    starship.toml             # Prompt theme
  wezterm/
    wezterm.lua               # Terminal config
  zsh/
    aliases.zsh               # Aliases stub
    completions.zsh           # Extra completions stub

dot_local/
  bin/
    sample-script.sh          # Custom scripts stub
```

---

## Making Changes

### Development Workflow
1. **Edit in Source**: Modify files in the ChezMoi source directory
   ```bash
   chezmoi edit ~/.config/wezterm/wezterm.lua
   # or edit directly in the repo
   cd $(chezmoi source-path) && code .
   ```
2. **Preview Changes**: See what will be applied before committing
   ```bash
   chezmoi diff
   ```
3. **Apply Changes**: Update your home directory
   ```bash
   chezmoi apply
   ```
4. **Version Control**: Commit and push changes
   ```bash
   cd $(chezmoi source-path)
   git add . && git commit -m "Update config" && git push
   ```

### Adding New Tools
1. Add to `pixi.toml` dependencies section
2. Run `pixi sync` to install
3. Configure in appropriate `dot_config/` subdirectory
4. Apply with `chezmoi apply`

---

## Directory Details

Each major directory has its own README with specific guidance:
- **`dot_config/`**: Application configurations (starship, wezterm, zsh)
- **`dot_local/`**: User-specific scripts and binaries

---

## Next Steps

1. Fill in stubs (aliases, WezTerm theme, Starship sections).
2. Test in a VM or new user: `chezmoi init … && chezmoi apply`.
3. (Optional) Add Pixi feature profiles (e.g., `[feature.minimal]`, `[feature.infra]`).
4. Write README.md with one-liner install instructions.
