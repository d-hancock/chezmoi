# Zsh Configuration

This directory contains configuration files for the Zsh shell.

## Files

- **aliases.zsh**: Contains custom aliases for the shell, including modern CLI tool replacements and shortcuts.
- **completions.zsh**: Configuration for enhanced tab completions and custom completion functions.
- **plugins.zsh**: Zinit plugin manager configuration for loading Zsh plugins.
- **terminal-compat.zsh**: Cross-platform compatibility settings for Windows Terminal, VS Code, and WSL2.
- **functions/**: Directory for modular shell functions, with one file per function.

## Integration

These files are automatically loaded by the main `.zshrc` configuration:
- `terminal-compat.zsh` is loaded first to set up environment compatibility
- `aliases.zsh` and `completions.zsh` are loaded for enhanced functionality
- `plugins.zsh` manages Zinit plugin loading
- Functions are auto-loaded from the `functions/` directory

Zsh is a powerful shell with advanced features, and these configurations enhance its functionality for modern development workflows.
