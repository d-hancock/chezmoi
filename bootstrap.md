# Bootstrap Setup

## Quick Start Flow
1. Initialize chezmoi with your dotfiles:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init d-hancock --apply
```

2. The setup script will automatically:
   - Install Pixi package manager
   - Install default tools (essential CLI utilities)
   - Install development tools (extended toolset)
   - Configure shell integrations

## Pixi Environment Management

### Default Environment (Essential Tools)
```bash
pixi shell --environment default  # Enter environment with basic tools
# or use alias
pxsd                              # Short alias for default environment
```

### Development Environment (Full Toolset)
```bash
pixi shell --environment dev      # Enter environment with all tools
# or use alias  
pxsdev                            # Short alias for dev environment
```

### Manual Installation
```bash
pixi install --environment default    # Install essential tools only
pixi install --environment dev        # Install development tools (includes default)

# Or use aliases
pxid                                   # Install default tools
pxidev                                # Install dev tools
```

## File Organization

### ChezMoi Integration
- **`.chezmoiignore`** - Excludes pixi lock files and caches from tracking
- **`pixi.toml`** - Profile-based tool configuration
- **`scripts/run_once_setup_tools.sh.tmpl`** - Automated tool installation

### Pixi Profiles
- **Default**: Navigation, search, shell enhancements, system utilities
- **Dev**: All default tools + development, networking, and performance tools

## Optional Enhancements
- **`.chezmoiexternal.toml`** - For pulling in large binaries, fonts, etc.
- **`.chezmoitemplates/`** - For reusable templates (e.g., shared secrets logic)

## Troubleshooting
```bash
# Verify pixi installation
pixi --version

# Check environment status
pixi info

# Reinstall tools if needed
pxidev  # Reinstall dev environment
```
