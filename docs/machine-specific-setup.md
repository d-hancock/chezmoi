# Machine-Specific Setup

This dotfiles configuration now supports automatic machine-specific setup for different environments. The system automatically detects your machine type and configures tools and settings accordingly.

## Supported Machine Types

### 🖥️ **Generic Linux Server**
- **Detection**: No desktop environment detected
- **Tools**: System monitoring, security tools, minimal setup
- **Package Manager**: apt/yum/dnf based on distribution
- **Features**:
  - Server monitoring tools (htop, iotop, nethogs)
  - Security tools (fail2ban, ufw/firewalld)
  - Terminal-focused environment
  - Auto-logout after inactivity

### 🐧 **Ubuntu Desktop**
- **Detection**: Ubuntu with desktop environment (GNOME/other)
- **Tools**: Desktop applications, development tools
- **Package Manager**: apt with PPA support
- **Features**:
  - Desktop applications (Firefox, VS Code)
  - GNOME tweaks and utilities
  - XDG directory standards
  - Desktop-specific aliases

### 🪟 **Ubuntu WSL2**
- **Detection**: `$WSL_DISTRO_NAME` environment variable
- **Tools**: Windows integration tools, cross-platform utilities
- **Package Manager**: apt with WSL-specific packages
- **Features**:
  - Windows clipboard integration
  - WSL utilities (wslview, wslpath)
  - Cross-platform file operations
  - Windows Terminal integration

## How It Works

### 1. **Automatic Detection**
The setup script (`run_once_setup_machine_specific.sh.tmpl`) automatically detects your machine type:

```bash
# Detection logic
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    # WSL2 detected
elif grep -q "Ubuntu" /etc/os-release && [[ -n "$DISPLAY" ]]; then
    # Ubuntu desktop detected
else
    # Generic Linux server
fi
```

### 2. **Pixi Environment Selection**
Different Pixi environments are used based on machine type:

```bash
# Machine-specific environments
pixi install --environment wsl2-dev      # WSL2
pixi install --environment ubuntu-dev    # Ubuntu desktop
pixi install --environment server        # Linux server
```

### 3. **Configuration Templates**
Machine-specific configuration is generated using ChezMoi templates:

```bash
# Template example (dot_config/zsh/machine-config.zsh.tmpl)
{{- if eq $machineType "server" }}
export EDITOR="vim"      # Lightweight editor for servers
{{- else }}
export EDITOR="nvim"     # Full-featured editor for desktop/WSL2
{{- end }}
```

## Pixi Environment Profiles

### Environment Definitions
```toml
[environments]
default = ["default"]                    # Essential tools only
dev = ["default", "dev"]                # Development tools
server = ["default", "server"]          # Server-specific tools
ubuntu = ["default", "ubuntu"]          # Ubuntu desktop tools
ubuntu-dev = ["default", "dev", "ubuntu"]  # Ubuntu + development
wsl2 = ["default", "wsl2"]              # WSL2-specific tools
wsl2-dev = ["default", "dev", "wsl2"]   # WSL2 + development
```

### Tool Categories
- **default**: Core CLI tools (fzf, ripgrep, bat, etc.)
- **dev**: Development tools (git-delta, gh, just, etc.)
- **server**: System administration tools (fail2ban, rsync, etc.)
- **ubuntu**: Desktop applications (when available via conda-forge)
- **wsl2**: WSL integration utilities

## Machine-Specific Features

### Server-Specific
```bash
# Aliases
alias monitor='server_status'      # System status overview
alias connections='active_connections'  # Network connections
alias secure='sudo fail2ban-client status'  # Security status

# Functions
server_status()          # Display system metrics
active_connections()     # Show network activity
```

### Ubuntu Desktop-Specific
```bash
# Aliases
alias desktop='desktop_info'       # Desktop environment info
alias install-deb='install_deb'    # Install .deb packages
alias update='sudo apt update && sudo apt upgrade'  # System update

# Functions
desktop_info()          # Show desktop environment details
install_deb()          # Download and install .deb packages
```

### WSL2-Specific
```bash
# Aliases
alias winpath='windows_path'      # Convert to Windows path
alias linuxpath='linux_path'      # Convert to Linux path
alias open='open_in_windows'      # Open files in Windows

# Functions
windows_path()         # Path conversion utilities
linux_path()
open_in_windows()      # Windows integration
```

## Prompt Integration

The machine type is displayed in your Starship prompt:
- 🖥️ Linux Server
- 🐧 Ubuntu Desktop  
- 🪟 WSL2

## Configuration Files

### Generated Files
- `~/.config/dotfiles/machine-type` - Machine type indicator
- `~/.config/zsh/machine-config.zsh` - Machine-specific configuration
- `~/.config/zsh/local-aliases.zsh` - Machine-specific aliases

### Template Files
- `scripts/run_once_setup_machine_specific.sh.tmpl` - Setup script
- `dot_config/zsh/machine-config.zsh.tmpl` - Configuration template

## Manual Override

You can manually set your machine type by creating the indicator file:

```bash
# Force server setup
echo "server" > ~/.config/dotfiles/machine-type

# Force Ubuntu desktop setup
echo "ubuntu" > ~/.config/dotfiles/machine-type

# Force WSL2 setup
echo "wsl2" > ~/.config/dotfiles/machine-type
```

Then run `chezmoi apply` to regenerate configurations.

## Testing Different Environments

You can test different Pixi environments without changing your machine type:

```bash
# Test server environment
pixi shell --environment server

# Test Ubuntu development environment
pixi shell --environment ubuntu-dev

# Test WSL2 environment
pixi shell --environment wsl2-dev
```

This machine-specific setup ensures you get the right tools and configuration for your environment while maintaining a single, unified dotfiles repository.
