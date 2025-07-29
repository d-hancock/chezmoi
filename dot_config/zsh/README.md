# Zsh Configuration Directory

## Overview

This directory contains modular Zsh configuration files that enhance the shell experience for development workflows. Each file serves a specific purpose and is loaded by the main `dot_zshrc.tmpl` in a specific order.

## Files

- **`aliases.zsh`**: Modern CLI tool replacements, shortcuts, and workflow aliases
- **`completions.zsh`**: Enhanced completions for modern tools and SSH integration  
- **`plugins.zsh`**: Comprehensive Zinit plugin stack for development workflows
- **`terminal-compat.zsh`**: Cross-platform compatibility for Windows Terminal, VS Code, WSL2
- **`machine-config.zsh.tmpl`**: Machine-specific environment configuration (templated)
- **`functions/`**: Directory for modular shell functions (gitlog, mkcd, etc.)

## Plugin Stack Highlights

### Core Quality of Life
- **zsh-autosuggestions**: Fish-like command suggestions from history
- **fast-syntax-highlighting**: Real-time command syntax highlighting  
- **zsh-completions**: Extended tab completions for modern tools
- **history-substring-search**: Search history with up/down arrows

### Navigation & Workflow
- **fzf + plugins**: Fuzzy finding for files, history, processes
- **zsh-z**: Jump to frequently used directories
- **safe-rm**: Protect against accidental file deletion
- **you-should-use**: Suggests using defined aliases

### Development Integration
- **Git extras**: Advanced Git commands and workflow helpers
- **Docker plugin**: Docker-specific completions and shortcuts
- **Conditional loading**: Kubernetes, AWS, language-specific plugins
- **Pixi integration**: Environment detection, task running, package search

### Performance Features
- **Lazy loading**: Plugins load after prompt for faster startup
- **Deferred execution**: Heavy plugins load in background
- **Smart caching**: Optimized completion and history management

## Pixi Integration

The configuration includes comprehensive Pixi package manager integration:

- **Auto-detection**: Automatically detects Pixi projects (`pixi.toml`)
- **Environment helpers**: `pixi-status`, `pixi-shell`, `pixi-task` functions
- **Fuzzy task selection**: Interactive task runner with FZF
- **Smart environment switching**: Conditional language tool loading
- **Enhanced completions**: Full Pixi command completion support

## Integration

These files are automatically loaded by the main `dot_zshrc.tmpl`:

1. **Early setup**: Core Zinit and fast-syntax-highlighting
2. **Tool initialization**: Pixi, zoxide, atuin, direnv, SSH agent
3. **Compatibility**: `terminal-compat.zsh` for cross-platform support
4. **Machine config**: `machine-config.zsh` for environment-specific settings
5. **Aliases & completions**: Enhanced command shortcuts and tab completion
6. **Plugin stack**: Full development plugin suite via `plugins.zsh`
7. **Functions**: Auto-loaded from `functions/` directory

This modular approach provides a fast, powerful, and maintainable shell configuration optimized for modern development workflows with Pixi package management.
