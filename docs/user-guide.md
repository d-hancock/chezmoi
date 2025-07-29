# ChezMoi Dotfiles User Guide

## 📋 Overview

This guide walks you through using the comprehensive ChezMoi dotfiles setup from initial installation to daily workflow management. This setup provides a complete, reproducible development environment with modern CLI tools, shell enhancements, and cross-platform compatibility.

### What You Get
- **Modern Shell**: Zsh with Zinit plugins, Starship prompt, and enhanced workflow
- **Package Management**: Pixi for reproducible tool environments
- **Terminal**: WezTerm with GPU acceleration and developer-focused configuration
- **SSH & Git**: Automated key management and seamless Git integration
- **CLI Tools**: Comprehensive modern tool stack (bat, eza, fzf, ripgrep, etc.)
- **Cross-Platform**: Works on Linux, WSL2, and various terminal environments

---

## 🚀 Initial Setup

### Prerequisites
- Git installed on your system
- Internet connection for downloading tools
- Terminal with basic shell access

### Step 1: Install ChezMoi
```bash
# Download and install ChezMoi
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Step 2: Initialize Your Dotfiles
```bash
# Clone and initialize the dotfiles repository
chezmoi init https://github.com/d-hancock/chezmoi.git

# Or if you have SSH keys already set up:
chezmoi init git@github.com:yourusername/your-dotfiles-repo.git
```

### Step 3: Preview Changes (Recommended)
```bash
# See what changes will be made before applying
chezmoi diff
```

### Step 4: Apply Configuration
```bash
# Apply all dotfiles and run setup scripts
chezmoi apply
```

This will:
- Install Pixi package manager
- Download and install all CLI tools
- Set up SSH keys and configuration
- Install Monaspace Nerd Fonts
- Create development directory structure
- Configure Zsh with plugins and enhancements

### Step 5: Restart Your Shell
```bash
# Start a new shell session to load all configurations
exec zsh
```

### Step 6: Configure Windows Terminal (WSL Users)
If you're using WSL2, add the generated Windows Terminal profile:

1. **Copy the generated profile**:
   ```bash
   cat ~/.config/windows-terminal/profile.json
   ```

2. **Add to Windows Terminal**:
   - Open Windows Terminal settings (`Ctrl + ,`)
   - Click "Open JSON file" in the bottom left
   - Add the copied profile to the `profiles.list` array
   - Save and restart Windows Terminal

The profile includes Monaspace Nerd Font configuration and optimal WSL2 settings.

---

## 🔧 Configuration Process

### What Happens During Setup

#### 1. **Tool Installation** (`run_once_setup_tools.sh.tmpl`)
- Installs Pixi package manager
- Syncs all development tools from `pixi.toml`
- Installs fallback tools via cargo (gum, lazydocker, vipe)

#### 2. **SSH Setup** (`run_once_setup_ssh_keys.sh.tmpl`)
- Generates SSH keys (Ed25519) if they don't exist
- Sets up SSH configuration with security best practices
- Configures SSH agent for automatic key loading
- Creates connection multiplexing for better performance

#### 3. **Font Installation** (`run_once_setup_fonts.sh.tmpl`)
- Downloads Monaspace Nerd Font
- Installs fonts to `~/.local/share/fonts`
- Updates system font cache

#### 4. **Directory Structure** (`run_once_setup_dirs.sh.tmpl`)
- Creates standard development directories:
  - `~/dev` - Main development work
  - `~/workspace` - Active projects
  - `~/projects` - Personal projects
  - `~/tmp` - Temporary files

#### 5. **Shell Configuration**
- Zsh with Zinit plugin manager
- Starship prompt with development-focused information
- Comprehensive alias system with modern tool replacements
- Enhanced completions and history management

---

## 📚 Daily Workflow

### Basic ChezMoi Commands

#### Viewing Status
```bash
# Check what files would change
chezmoi diff

# Check ChezMoi status
chezmoi status
```

#### Making Changes
```bash
# Edit a config file through ChezMoi
chezmoi edit ~/.config/starship/starship.toml

# Or edit directly in the source
cd $(chezmoi source-path)
code .  # Open entire repo in VS Code
```

#### Applying Changes
```bash
# Apply specific file
chezmoi apply ~/.zshrc

# Apply all changes
chezmoi apply

# Apply with verbose output
chezmoi apply -v
```

#### Managing the Repository
```bash
# Navigate to ChezMoi source directory
cd $(chezmoi source-path)

# Add and commit changes
git add .
git commit -m "Update shell configuration"
git push

# Pull latest changes
git pull
chezmoi apply
```

### Shell Enhancements

#### Modern Tool Replacements
Your shell now includes these enhanced commands:
```bash
# File operations
ls        # → eza (with icons and git status)
ll        # → eza -alh (detailed list with icons)
cat       # → bat (syntax highlighting)
find      # → fd (faster, user-friendly)
grep      # → ripgrep (faster, better defaults)

# Navigation
cd        # Enhanced with zoxide (learns your habits)
z <name>  # Jump to frequently used directories

# System monitoring
top       # → btop (beautiful system monitor)
du        # → dust (better disk usage)
df        # → duf (better disk free)
```

#### Git Workflow
```bash
# Enhanced git aliases
gst       # git status
gco       # git checkout
gaa       # git add --all
gcm       # git commit -m
gp        # git push
gl        # git pull
glog      # git log --oneline --graph --decorate

# Git extras commands
git summary   # Project summary
git effort    # Contributor effort analysis
git undo      # Undo last commit
```

#### Pixi Environment Management
```bash
# Check Pixi project status
pixi-status

# Activate Pixi environment
pixi-shell

# Run tasks with fuzzy selection
pixi-task

# Search for packages
pixi-search <package-name>

# Basic Pixi commands (aliased)
px        # pixi
pxr       # pixi run
pxi       # pixi install
pxa       # pixi add
```

### SSH and Git Integration

#### SSH Key Management
Your SSH keys are automatically managed:
- Keys are generated on first setup
- SSH agent starts automatically with shell
- Keys are loaded automatically
- Connection multiplexing for better performance

#### Adding SSH Keys to Services
After setup, add your public key to Git hosting services:
```bash
# Display your public key
cat ~/.ssh/id_ed25519.pub

# Copy to clipboard (Linux)
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard

# Copy to clipboard (WSL)
cat ~/.ssh/id_ed25519.pub | clip.exe
```

Then add the key to:
- **GitHub**: Settings → SSH and GPG keys → New SSH key
- **GitLab**: Profile → SSH Keys → Add key

#### Testing SSH Connection
```bash
# Test GitHub connection
ssh -T git@github.com

# Test GitLab connection
ssh -T git@gitlab.com
```

---

## 🛠️ Customization Guide

### Adding New Aliases
Edit the aliases file:
```bash
chezmoi edit ~/.config/zsh/aliases.zsh
```

Add your alias:
```bash
# Development shortcuts
alias myproject='cd ~/dev/my-important-project'
alias serve='python3 -m http.server 8000'
```

Apply changes:
```bash
chezmoi apply
source ~/.config/zsh/aliases.zsh
```

### Adding New Tools

#### Via Pixi (Recommended)
1. Add to `pixi.toml`:
```bash
chezmoi edit $(chezmoi source-path)/pixi.toml
```

2. Add the tool to appropriate section:
```toml
[feature.dev.dependencies]
newtool = "*"
```

3. Install the tool:
```bash
cd $(chezmoi source-path)
pixi install --environment dev
```

#### Via Package Manager
For tools not in conda-forge, add to setup script:
```bash
chezmoi edit $(chezmoi source-path)/scripts/run_once_setup_tools.sh.tmpl
```

### Adding Custom Functions
Create a new function file:
```bash
chezmoi edit ~/.config/zsh/functions/myfunction.zsh
```

Add your function:
```bash
# My custom function
myfunction() {
    echo "This is my custom function"
    # Function logic here
}
```

Functions are automatically loaded when shell starts.

### Customizing Starship Prompt
Edit the Starship configuration:
```bash
chezmoi edit ~/.config/starship/starship.toml
```

Common customizations:
```toml
# Change prompt format
format = """
[](color_orange)\
$username\
$directory\
$git_branch\
$character"""

# Add custom module
[custom.mymodule]
command = "echo 'custom'"
when = "true"
format = "[$output]($style) "
```

### Customizing WezTerm
Edit the terminal configuration:
```bash
chezmoi edit ~/.config/wezterm/wezterm.lua
```

Common customizations:
```lua
-- Change font size
config.font_size = 12.0

-- Change color scheme
config.color_scheme = 'Tokyo Night'

-- Add custom key binding
table.insert(config.keys, {
  key = 'n', 
  mods = 'CTRL|SHIFT', 
  action = wezterm.action.SpawnWindow
})
```

---

## 🔍 Troubleshooting

### Common Issues

#### Shell Not Loading Properly
```bash
# Check for errors in zsh config
zsh -n ~/.zshrc

# Reset shell configuration
exec zsh

# Check plugin loading
zinit times
```

#### Tools Not Found
```bash
# Quick fix: Reload shell configuration
source ~/.zshrc

# Check PATH
echo $PATH

# Verify Pixi installation
which pixi
pixi --version

# Reinstall tools if needed
cd $(chezmoi source-path)
pixi install --environment dev
```

#### SSH Issues
```bash
# Check SSH agent
echo $SSH_AUTH_SOCK
ssh-add -l

# Restart SSH agent
pkill ssh-agent
exec zsh

# Test SSH connection
ssh -T git@github.com
```

#### Font Issues
```bash
# Update font cache
fc-cache -fv

# Check installed fonts
fc-list | grep -i monaspace

# Reinstall fonts
$(chezmoi source-path)/scripts/run_once_setup_fonts.sh.tmpl
```

### Getting Help

#### ChezMoi Help
```bash
# General help
chezmoi help

# Command-specific help
chezmoi help apply
chezmoi help edit
```

#### Plugin Information
```bash
# List loaded plugins
zinit list

# Plugin loading times
zinit times

# Update all plugins
zinit update --all
```

#### Environment Information
```bash
# Show environment info
pixi info

# Show tool versions
starship --version
bat --version
eza --version
```

---

## 🚀 Advanced Usage

### Multiple Machines

#### Syncing Changes
On machine A:
```bash
cd $(chezmoi source-path)
# Make changes
git add . && git commit -m "Update config" && git push
```

On machine B:
```bash
cd $(chezmoi source-path)
git pull
chezmoi apply
```

#### Machine-Specific Configurations
Use ChezMoi templates for machine-specific settings:
```bash
chezmoi edit ~/.config/zsh/machine-config.zsh
```

Example template:
```bash
{{- if eq .chezmoi.hostname "workstation" }}
export WORK_VAR="work-value"
{{- else if eq .chezmoi.hostname "laptop" }}
export PERSONAL_VAR="personal-value"
{{- end }}
```

### Environment Profiles

#### Using Different Pixi Environments
```bash
# Development environment (default)
pixi shell --environment dev

# Minimal environment
pixi shell --environment default

# Server environment
pixi shell --environment server
```

#### Creating Custom Profiles
Edit `pixi.toml`:
```toml
[feature.custom.dependencies]
mytool = "*"

[environments]
custom = ["default", "custom"]
```

### Backup and Recovery

#### Backup Current Configuration
```bash
# Backup current dotfiles
cp -r ~ ~/backup-$(date +%Y%m%d)

# Or backup specific configs
chezmoi archive > dotfiles-backup-$(date +%Y%m%d).tar
```

#### Recovery
```bash
# Reset to clean state
chezmoi state delete-bucket --bucket=entryState
chezmoi apply --force

# Or start fresh
rm -rf $(chezmoi source-path)
chezmoi init <your-repo-url>
chezmoi apply
```

---

## 📖 Reference

### Key Files and Locations

#### ChezMoi Source Files
```
~/.local/share/chezmoi/          # ChezMoi source directory
├── dot_zshrc.tmpl               # Main shell configuration
├── pixi.toml                    # Tool dependencies
├── dot_config/
│   ├── starship/starship.toml   # Prompt configuration
│   ├── wezterm/wezterm.lua      # Terminal configuration
│   └── zsh/                     # Shell enhancements
└── scripts/                     # Setup scripts
```

#### Applied Configurations
```
~/.zshrc                         # Shell configuration
~/.config/starship/starship.toml # Prompt
~/.config/wezterm/wezterm.lua    # Terminal
~/.config/zsh/                   # Shell modules
~/.ssh/config                    # SSH configuration
```

### Important Commands Reference

#### ChezMoi
```bash
chezmoi init <repo>              # Initialize repository
chezmoi apply                    # Apply configurations
chezmoi diff                     # Show pending changes
chezmoi edit <file>              # Edit source file
chezmoi status                   # Show status
chezmoi source-path              # Show source directory
```

#### Pixi
```bash
pixi install                     # Install dependencies
pixi shell                       # Activate environment
pixi run <task>                  # Run task
pixi add <package>               # Add package
pixi search <term>               # Search packages
```

#### Git Workflow
```bash
cd $(chezmoi source-path)        # Go to source
git add . && git commit && git push  # Save changes
git pull && chezmoi apply        # Update from remote
```

This comprehensive setup provides a modern, efficient, and maintainable development environment. The modular design makes it easy to customize while keeping everything organized and reproducible across machines.

---

## 🎯 Quick Start Checklist

- [ ] Install ChezMoi: `sh -c "$(curl -fsLS get.chezmoi.io)"`
- [ ] Initialize repo: `chezmoi init <your-repo-url>`
- [ ] Preview changes: `chezmoi diff`
- [ ] Apply configuration: `chezmoi apply`
- [ ] Restart shell: `exec zsh`
- [ ] Add SSH key to GitHub/GitLab
- [ ] Test setup: `gst`, `ll`, `pixi-status`
- [ ] Customize as needed

Welcome to your new development environment! 🎉
