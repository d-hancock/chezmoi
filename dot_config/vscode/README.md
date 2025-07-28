# VS Code Configuration

## Overview

This directory contains VS Code settings optimized for terminal compatibility, font configuration, and WSL2 integration.

## Files

- **`settings.json`**: Main VS Code user settings with terminal and font configuration

## Features

### Terminal Integration
- **Default Shell**: Zsh configured as default Linux terminal
- **Font**: Monaspace Nerd Font for proper icon rendering
- **Color Support**: True color (24-bit) enabled
- **Scrollback**: 10,000 lines for extensive history

### Editor Configuration
- **Font**: Monaspace Nerd Font with ligatures enabled
- **Auto-save**: Enabled with 1-second delay
- **Theme**: Default Dark+ (modify as preferred)

### Git Integration
- **Smart Commit**: Enabled for better workflow
- **Sync Confirmation**: Disabled for smoother operation

## Manual Setup

### VS Code Extension for WSL
If using WSL2, install the WSL extension:
1. Open VS Code on Windows
2. Install "WSL" extension by Microsoft
3. Connect to WSL by clicking the green corner button
4. Select "Connect to WSL"

### Font Installation
Ensure Monaspace Nerd Font is installed:
- **Linux/WSL2**: Handled automatically by ChezMoi
- **Windows**: Install manually for VS Code on Windows

## Settings Explained

### Terminal Settings
```json
{
    "terminal.integrated.fontFamily": "Monaspace Nerd Font",
    "terminal.integrated.fontSize": 11,
    "terminal.integrated.profiles.linux": {
        "zsh": {
            "path": "/usr/bin/zsh",
            "args": []
        }
    },
    "terminal.integrated.defaultProfile.linux": "zsh"
}
```

This configures:
- Font family for terminal (with Nerd Font icons)
- Font size for readability
- Zsh as the default terminal shell
- Custom Zsh profile definition

### Editor Settings
```json
{
    "editor.fontFamily": "Monaspace Nerd Font, 'Droid Sans Mono', 'monospace', monospace",
    "editor.fontLigatures": true,
    "editor.fontSize": 11
}
```

Features:
- Font fallback chain for compatibility
- Programming ligatures enabled (e.g., `->` becomes `→`)
- Consistent font size with terminal

### Environment Variables
```json
{
    "terminal.integrated.env.linux": {
        "COLORTERM": "truecolor"
    }
}
```

Sets environment variables for optimal terminal rendering.

## Customization

### Change Color Theme
Update the `workbench.colorTheme` setting:
```json
"workbench.colorTheme": "One Dark Pro"
```

Popular themes that work well with this setup:
- One Dark Pro
- Material Theme
- Dracula Official
- Monokai Pro
- Night Owl

### Adjust Font Size
Modify both editor and terminal font sizes:
```json
"editor.fontSize": 12,
"terminal.integrated.fontSize": 12
```

### Disable Font Ligatures
If you prefer no ligatures:
```json
"editor.fontLigatures": false
```

### Change Terminal Profile
To use bash instead of zsh:
```json
"terminal.integrated.defaultProfile.linux": "bash"
```

## Extensions Integration

### Recommended Extensions
These extensions work well with the terminal setup:

1. **GitLens**: Enhanced Git capabilities
2. **Bracket Pair Colorizer**: Visual bracket matching
3. **indent-rainbow**: Indentation visualization
4. **Material Icon Theme**: Better file icons
5. **Thunder Client**: API testing within VS Code

### Extension Settings
Some extensions benefit from font configuration:

```json
"gitlens.currentLine.fontFamily": "Monaspace Nerd Font",
"debug.console.fontFamily": "Monaspace Nerd Font"
```

## Troubleshooting

### Terminal Not Using Zsh
1. Check if Zsh is installed: `which zsh`
2. Verify Zsh path in settings matches actual path
3. Restart VS Code after ChezMoi apply

### Font Not Rendering Correctly
1. Ensure Nerd Font is installed (check with `fc-list | grep -i monaspace`)
2. Restart VS Code completely
3. Clear VS Code cache if needed

### Icons Not Displaying
1. Verify Nerd Font installation
2. Test in terminal: `echo "  📁 🐍"`
3. Check terminal environment variables are set

### WSL Integration Issues
1. Install WSL extension for VS Code
2. Connect to WSL environment
3. Ensure settings are applied in WSL context

## Advanced Configuration

### Workspace-Specific Settings
Create `.vscode/settings.json` in project roots for project-specific settings:

```json
{
    "terminal.integrated.cwd": "${workspaceFolder}",
    "terminal.integrated.env.linux": {
        "PROJECT_ROOT": "${workspaceFolder}"
    }
}
```

### Task Integration
Define tasks that use the terminal setup:

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "dev-server",
            "type": "shell",
            "command": "pixi run dev",
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "new"
            }
        }
    ]
}
```

### Launch Configuration
Debug configurations that work with the environment:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python Debug",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "env": {
                "PYTHONPATH": "${workspaceFolder}"
            }
        }
    ]
}
```

## File Locations

- **User Settings**: `~/.config/Code/User/settings.json` (managed by ChezMoi)
- **Workspace Settings**: `${workspace}/.vscode/settings.json`
- **Extensions**: `~/.vscode/extensions/`

The ChezMoi configuration applies to user-level settings, ensuring consistency across all workspaces while allowing project-specific overrides.
