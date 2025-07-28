# Navigation Guide

## Finding What You Need

This guide helps you quickly locate and understand different parts of the ChezMoi dotfiles project. Use this as a reference to navigate the repository structure effectively.

## 🗺️ Repository Map

### Root Level Files
```
/home/dale/.local/share/chezmoi/
├── README.md                 # Main project documentation
├── .chezmoi.toml            # ChezMoi configuration
├── pixi.toml                # Tool dependencies
├── dot_zshrc.tmpl           # Main shell configuration
├── dot_gitconfig            # Git settings
├── dot_gitignore_global     # Global gitignore patterns
├── run_once_setup_*.sh.tmpl # Bootstrap scripts
├── docs/                    # Project documentation
├── sketches/                # Development notes
└── notes/                   # Setup notes
```

### Configuration Directory (`dot_config/`)
```
dot_config/
├── README.md               # Configuration overview
├── starship/
│   └── starship.toml      # Prompt configuration
├── wezterm/
│   └── wezterm.lua        # Terminal configuration
├── zsh/
│   ├── aliases.zsh        # Command shortcuts
│   └── completions.zsh    # Enhanced completions
└── pixi/
    └── README.md          # Future pixi configs
```

### Local Directory (`dot_local/`)
```
dot_local/
├── README.md              # Local tools overview
└── bin/
    └── sample-script.sh   # Custom scripts template
```

## 🎯 What's Where

### Looking for Shell Configuration?
- **Main Config**: `dot_zshrc.tmpl` - Core shell setup
- **Aliases**: `dot_config/zsh/aliases.zsh` - Command shortcuts
- **Completions**: `dot_config/zsh/completions.zsh` - Enhanced tab completion
- **Prompt**: `dot_config/starship/starship.toml` - Prompt appearance

### Looking for Tool Management?
- **Package List**: `pixi.toml` - All managed CLI tools
- **Installation**: `run_once_setup_tools.sh.tmpl` - Tool installation script
- **Manual Tools**: Look for `cargo install` commands in setup scripts

### Looking for Terminal Setup?
- **Terminal Config**: `dot_config/wezterm/wezterm.lua` - WezTerm settings
- **Font Setup**: `run_once_setup_fonts.sh.tmpl` - Font installation
- **Key Bindings**: Inside WezTerm config file

### Looking for Git Configuration?
- **Main Config**: `dot_gitconfig` - Git settings and aliases
- **Global Ignore**: `dot_gitignore_global` - Files to ignore everywhere
- **Integration**: Git delta configured in both git and starship

### Looking for Documentation?
- **Project Docs**: `docs/` directory - Comprehensive guides
- **Setup Notes**: `notes/setup-notes.md` - Installation guidance
- **Inline Docs**: Comments throughout all config files
- **Directory Guides**: README files in major directories

## 🔍 Common Tasks

### I Want to Add a New Tool
1. **Check if it's in conda-forge**: Search at https://anaconda.org/conda-forge
2. **If available**: Add to `pixi.toml` dependencies section
3. **If not available**: Add to `run_once_setup_tools.sh.tmpl` fallback section
4. **Add configuration**: Create config in appropriate `dot_config/` subdirectory
5. **Add aliases**: Update `dot_config/zsh/aliases.zsh` if needed

### I Want to Customize the Prompt
1. **Main config**: Edit `dot_config/starship/starship.toml`
2. **Color scheme**: Modify the `[palettes.gruvbox_dark]` section
3. **Modules**: Add/remove modules in the `format` string
4. **Custom sections**: Add `[custom.name]` sections

### I Want to Change Terminal Behavior
1. **Appearance**: Edit `dot_config/wezterm/wezterm.lua`
2. **Key bindings**: Modify the `config.keys` table
3. **Font settings**: Update font configuration
4. **Color scheme**: Change `config.color_scheme`

### I Want to Add Custom Scripts
1. **Location**: Add to `dot_local/bin/` directory
2. **Template**: Use `sample-script.sh` as starting point
3. **Permissions**: Make executable with `chmod +x`
4. **Testing**: Scripts are automatically on PATH

### I Want to Modify Aliases
1. **File**: Edit `dot_config/zsh/aliases.zsh`
2. **Categories**: Follow existing organization
3. **Documentation**: Add comments explaining purpose
4. **Testing**: Source file or restart shell to test

## 📂 File Naming Conventions

### ChezMoi Conventions
- **`dot_*`** - Files that go to `~/.*` (dotfiles)
- **`run_once_*`** - Scripts that run only on first apply
- **`.tmpl`** - Template files that can use ChezMoi variables

### Internal Conventions
- **`README.md`** - Documentation for directory contents
- **`*.zsh`** - Zsh-specific configuration files
- **`*.toml`** - TOML configuration files
- **`*.lua`** - Lua configuration files

## 🔗 Configuration Flow

### Understanding Dependencies
```
ChezMoi Apply
├── Bootstrap Scripts (run_once_*)
│   ├── Install Pixi → Install CLI tools
│   ├── Install Fonts → Enable terminal icons
│   └── Create Directories → Set up workspace
├── Configuration Files (dot_*)
│   ├── Shell Config → Load plugins and tools
│   ├── Terminal Config → Set appearance
│   └── Tool Configs → Configure behavior
└── Result: Complete Environment
```

### Startup Sequence
1. **Terminal Launch** - WezTerm starts with configured appearance
2. **Shell Init** - Zsh loads with Zinit plugins
3. **Tool Init** - Modern tools initialize (direnv, zoxide, etc.)
4. **Prompt Load** - Starship displays configured prompt
5. **Ready** - Full environment available

## 🛠️ Troubleshooting Navigation

### Can't Find a Configuration?
1. **Check file naming**: Remember `dot_` prefix for dotfiles
2. **Look in subdirectories**: Many configs are in `dot_config/`
3. **Check templates**: Look for `.tmpl` extension
4. **Read comments**: Inline documentation explains purpose

### Tool Not Working?
1. **Check pixi.toml**: Ensure tool is listed as dependency
2. **Check PATH**: Use `which toolname` to verify installation
3. **Check aliases**: Tool might be aliased differently
4. **Check setup script**: Look in bootstrap scripts for manual installation

### Configuration Not Applied?
1. **Run chezmoi diff**: See what would change
2. **Run chezmoi apply**: Apply pending changes
3. **Check file paths**: Ensure correct dot_ prefix
4. **Restart shell**: Some changes require shell restart

This navigation guide should help you quickly find and understand any part of the dotfiles system!
