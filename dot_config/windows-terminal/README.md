# Windows Terminal Configuration

## Overview

This directory contains configuration templates for Windows Terminal integration with your ChezMoi dotfiles setup.

## Files

- **`profile.json.tmpl`**: Windows Terminal profile template for WSL2 integration

## Setup Instructions

### 1. Generate Profile Configuration
After running `chezmoi apply`, the profile template will be processed and available at:
```
~/.config/windows-terminal/profile.json
```

### 2. Import into Windows Terminal
1. Open Windows Terminal
2. Press `Ctrl+Shift+,` to open settings
3. Click "Open JSON file" in the bottom left
4. Add the generated profile to the `profiles.list` array:

```json
{
    "profiles": {
        "list": [
            // ... existing profiles ...
            // Copy content from ~/.config/windows-terminal/profile.json here
        ]
    }
}
```

### 3. Set as Default (Optional)
To make this profile the default:
1. In Windows Terminal settings, go to "Startup"
2. Set "Default profile" to "Ubuntu (your-hostname)"

## Profile Features

### Font Configuration
- **Font**: Monaspace Nerd Font (install on Windows first)
- **Size**: 11pt for optimal readability
- **Rendering**: Antialiasing enabled for smooth text

### Visual Settings
- **Color Scheme**: One Half Dark (matches Starship prompt)
- **Cursor**: Bar style with white color
- **Icons**: Ubuntu WSL icon

### Behavior Settings
- **Starting Directory**: Your WSL2 home directory
- **History**: 9001 lines (over 9000!)
- **Bell**: Disabled (no annoying sounds)
- **Close on Exit**: Graceful (waits for processes to finish)

## Customization

### Change Color Scheme
Edit the `colorScheme` field in the profile template:
```json
"colorScheme": "Campbell Powershell"  // or any other scheme
```

Available schemes include:
- One Half Dark
- One Half Light
- Campbell
- Campbell Powershell
- Vintage
- Solarized Dark
- Solarized Light

### Adjust Font Size
Modify the `fontSize` field:
```json
"fontSize": 12  // Larger text
```

### Change Starting Directory
Update the `startingDirectory` field:
```json
"startingDirectory": "//wsl$/Ubuntu-22.04/home/username/projects"
```

## Troubleshooting

### Profile Not Working
1. **Check WSL Distribution Name**: Ensure the distribution name in the profile matches your actual WSL installation
2. **Verify Paths**: Make sure the starting directory path exists
3. **Font Issues**: Install Monaspace Nerd Font on Windows first

### Font Not Displaying
1. Download and install Monaspace Nerd Font on Windows
2. Restart Windows Terminal
3. Verify font appears in settings dropdown

### Icons Not Showing
1. Ensure Nerd Font is properly installed
2. Check terminal is using the correct font
3. Test with: `echo "  📁 🐍 ⚡ 🔧"`

## Advanced Configuration

### Multiple WSL Distributions
If you have multiple WSL distributions, create separate profiles:

```json
{
    "name": "Ubuntu 20.04",
    "commandline": "wsl.exe -d Ubuntu-20.04"
},
{
    "name": "Ubuntu 22.04", 
    "commandline": "wsl.exe -d Ubuntu-22.04"
}
```

### Custom Key Bindings
Add key bindings to Windows Terminal settings:

```json
"actions": [
    {
        "command": {"action": "newTab", "profile": "Ubuntu (hostname)"},
        "keys": "ctrl+shift+u"
    }
]
```

### Background Images
Add background image or transparency:

```json
"backgroundImage": "ms-appdata:///local/background.jpg",
"backgroundImageOpacity": 0.1,
"useAcrylic": true,
"acrylicOpacity": 0.9
```

## Integration with Chezmoi

The profile template uses ChezMoi variables:
- `{{ .chezmoi.hostname }}`: Your machine hostname
- `{{ .chezmoi.username }}`: Your username  
- `{{ .chezmoi.osRelease.versionId }}`: Ubuntu version (e.g., "22.04")

This ensures the profile is customized for your specific environment automatically.
