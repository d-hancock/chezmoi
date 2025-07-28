# Font Setup for Cross-Platform Compatibility

## Overview

This guide covers font installation and configuration for optimal compatibility with Windows Terminal, VS Code, and WSL2 environments.

## Monaspace Nerd Font Installation

### Automatic Installation (Linux/WSL2)
The font installation is handled automatically by ChezMoi via the `run_once_setup_fonts.sh.tmpl` script. This downloads and installs Monaspace Nerd Fonts to `~/.local/share/fonts`.

### Manual Installation (Windows)
For Windows Terminal and VS Code on Windows, you need to install fonts on the Windows host:

1. **Download Monaspace Nerd Font**:
   - Visit: https://github.com/githubnext/monaspace/releases
   - Download the latest `Monaspace.zip` release
   - Or download Nerd Font version from: https://github.com/ryanoasis/nerd-fonts/releases

2. **Install Fonts on Windows**:
   - Extract the downloaded ZIP file
   - Select all `.ttf` files in the `fonts/` directory
   - Right-click and select "Install" or "Install for all users"
   - Alternatively, copy to `C:\Windows\Fonts\`

3. **Verify Installation**:
   - Open Windows Terminal
   - Go to Settings → Profiles → Ubuntu → Appearance
   - "Monaspace Nerd Font" should appear in the font dropdown

## Terminal Configuration

### Windows Terminal
- Font configuration is automatically applied via the profile template
- Location: `~/.config/windows-terminal/profile.json.tmpl`
- Import this profile into Windows Terminal settings

### VS Code
- Font settings are automatically applied via ChezMoi
- Location: `~/.config/vscode/settings.json`
- Restart VS Code after running `chezmoi apply`

### WezTerm
- Font configuration is in `~/.config/wezterm/wezterm.lua`
- Uses font fallback hierarchy for best compatibility

## Testing Font Installation

### Icon Test
Run this command to test icon rendering:
```bash
echo "  📁 🐍 ⚡ 🔧 📋 🚀 ✅ ❌ ⚠️ 💡"
```

### Nerd Font Icons Test
```bash
echo "        "
```

### Powerline Symbols Test
```bash
echo "      "
```

If you see boxes (□) or question marks (?) instead of icons, the font isn't properly installed or configured.

## Troubleshooting

### Common Issues

1. **Icons not displaying correctly**:
   - Verify Nerd Font is installed on Windows host (for Windows Terminal)
   - Check terminal font settings
   - Restart terminal application

2. **Font not available in terminal**:
   - Refresh font cache: `fc-cache -fv` (Linux)
   - Restart Windows Terminal/VS Code
   - Check font is in correct directory

3. **VS Code terminal font differs from editor**:
   - Check both `editor.fontFamily` and `terminal.integrated.fontFamily` settings
   - Ensure settings are applied correctly

### Font Locations

- **Linux/WSL2**: `~/.local/share/fonts/`
- **Windows**: `C:\Windows\Fonts\` or `%LOCALAPPDATA%\Microsoft\Windows\Fonts\`
- **ChezMoi Config**: `~/.config/vscode/settings.json`, `~/.config/wezterm/wezterm.lua`

## Alternative Fonts

If Monaspace Nerd Font isn't available, these alternatives work well:

1. **JetBrains Mono Nerd Font** - Excellent for coding
2. **Fira Code Nerd Font** - Popular with developers
3. **Cascadia Code Nerd Font** - Microsoft's font with Nerd Font patches
4. **Source Code Pro Nerd Font** - Adobe's open source font

Update the font settings in your configurations as needed.

## Font Features

### Monaspace Font Family
- **Neon**: Sans-serif, geometric
- **Argon**: Humanist sans-serif  
- **Xenon**: Slab serif
- **Radon**: Handwriting-inspired
- **Krypton**: Mechanical monospace

The configuration uses **Neon** as primary with **Radon** as fallback for variety.

## Advanced Configuration

### Font Ligatures
Font ligatures are enabled in VS Code for better code readability:
```json
"editor.fontLigatures": true
```

### Font Weights
Different font weights can be configured:
- **normal**: Regular weight
- **bold**: Bold weight
- **light**: Light weight

### Font Sizing
Recommended sizes:
- **Terminal**: 11-12pt
- **Editor**: 11-13pt
- **UI**: 10-11pt

Adjust based on your display resolution and preferences.
