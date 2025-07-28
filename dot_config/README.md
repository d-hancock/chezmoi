# Configuration Directory (dot_config)

## Overview

This directory contains application-specific configurations that will be symlinked to `~/.config/` by ChezMoi. It serves as the central hub for all user-level application settings, ensuring consistent behavior across different machines.

### Role in the Project

The `dot_config` directory is where ChezMoi places files that need to be managed in the user's configuration directory. ChezMoi automatically:
- Strips the `dot_` prefix when applying files
- Creates necessary subdirectories
- Handles file permissions and ownership
- Supports templating for dynamic configuration

### Integration with Other Components

- **Shell Integration**: Zsh configurations here are sourced by `dot_zshrc.tmpl`
- **Prompt Integration**: Starship config is automatically loaded by the shell
- **Terminal Integration**: WezTerm reads its config from this location
- **Tool Discovery**: Many CLI tools automatically find configs here

---

## Directory Contents

### Structure

```
starship/
  starship.toml             # Prompt theme
wezterm/
  wezterm.lua               # Terminal config
zsh/
  aliases.zsh               # Aliases stub
  completions.zsh           # Extra completions stub
```

### Configuration Details

#### `starship/starship.toml` - Shell Prompt
- **Purpose**: Defines the appearance and behavior of your shell prompt
- **Features**: Shows current directory, git status, active environments (including Pixi)
- **Integration**: Automatically loaded by Zsh via `dot_zshrc.tmpl`
- **Customization**: TOML-based configuration for easy modification

#### `wezterm/wezterm.lua` - Terminal Emulator
- **Purpose**: Configures WezTerm terminal emulator
- **Features**: Font selection (Monaspace Nerd Font), color schemes, key bindings
- **Integration**: Auto-loaded by WezTerm on startup
- **Customization**: Lua-based configuration for advanced scripting

#### `zsh/` - Shell Enhancement
- **`aliases.zsh`**: Command shortcuts and modern tool replacements
- **`completions.zsh`**: Custom command completions and enhancements
- **Integration**: Both files are sourced by `dot_zshrc.tmpl`
- **Purpose**: Modular organization of shell customizations

---

## Configuration Philosophy

### Modular Design
Each tool has its own subdirectory, making it easy to:
- Enable/disable specific configurations
- Version control changes independently
- Share configurations between tools
- Troubleshoot issues in isolation

### Template Support
Files can use ChezMoi templates (`.tmpl` extension) for:
- Machine-specific configurations
- Conditional features
- Dynamic values (paths, usernames, etc.)
- Environment-based settings

---

## Working with Configurations

### Editing Process
1. **Direct Editing**: Modify files directly in the ChezMoi source
   ```bash
   cd $(chezmoi source-path)/dot_config
   vim starship/starship.toml
   ```

2. **ChezMoi Edit**: Use ChezMoi's edit command
   ```bash
   chezmoi edit ~/.config/starship/starship.toml
   ```

3. **Preview and Apply**: Check changes before applying
   ```bash
   chezmoi diff
   chezmoi apply
   ```

### Adding New Configurations
1. Create subdirectory: `mkdir -p dot_config/newtool`
2. Add configuration files
3. Update relevant integration points (shell configs, etc.)
4. Test with `chezmoi apply`

### Tool-Specific Notes
- **Starship**: Changes take effect on new shell sessions
- **WezTerm**: Configs are reloaded automatically or with Ctrl+Shift+R
- **Zsh**: Source changes with `. ~/.zshrc` or start new session

---

## Best Practices

1. **Keep It Simple**: Start with minimal configs and add complexity as needed
2. **Document Changes**: Add comments explaining non-obvious configurations
3. **Test Thoroughly**: Verify changes work across different environments
4. **Version Control**: Commit frequently with descriptive messages
5. **Backup First**: Use `chezmoi diff` before applying major changes
