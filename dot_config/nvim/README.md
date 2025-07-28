# Vim & Neovim Configuration

## Overview

This directory contains both Vim and Neovim configurations optimized for modern development workflows, integrated with the rest of the dotfiles setup.

## Files

- **`~/.vimrc`**: Classic Vim configuration (compatible with Vim 8+)
- **`~/.config/nvim/init.lua`**: Modern Neovim configuration in Lua

## Editor Priority

The setup automatically chooses the best available editor:

1. **Neovim** (preferred) - Modern features, better performance, Lua configuration
2. **Vim** (fallback) - Classic Vim with modern settings
3. **Vi** (last resort) - Basic editor if others unavailable

## Key Features

### Vim Configuration (`~/.vimrc`)
- **Modern Defaults**: Sensible settings for development
- **File Management**: Backup, swap, and undo files in organized directories
- **Search**: Smart case-insensitive search with highlighting
- **Indentation**: Smart indenting with 4-space tabs by default
- **Navigation**: Vim-style split navigation with Ctrl+hjkl
- **Status Line**: Informative status line showing file info
- **File Types**: Language-specific settings for Python, YAML, JSON, etc.

### Neovim Configuration (`~/.config/nvim/init.lua`)
- **Lua-based**: Modern Lua configuration for better performance
- **Enhanced UI**: Better defaults with true color support
- **LSP Ready**: Built-in LSP highlighting and features
- **Terminal Mode**: Better terminal integration within Neovim
- **Modern Features**: Leverages Neovim-specific improvements

## Key Mappings

Both configurations use **Space** as the leader key:

### File Operations
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>x` - Save and quit
- `<leader>Q` - Force quit without saving

### Navigation
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer
- `Ctrl+h/j/k/l` - Navigate splits (Vim-style)

### Utility
- `<leader>/` - Clear search highlighting
- `<leader>n` - Toggle relative line numbers
- `<leader>ev` - Edit config file
- `<leader>sv` - Reload config file

### Window Management
- `<leader>+/-` - Resize height
- `<leader></>` - Resize width

## Integration with Dotfiles

### Terminal Compatibility
- **VS Code**: Automatically uses `code --wait` as editor in VS Code terminal
- **Standard Terminal**: Prefers Neovim, falls back to Vim
- **Git Integration**: Set as merge and diff tool in `dot_gitconfig`

### Clipboard Integration
- **System Clipboard**: Automatically uses system clipboard when available
- **WSL2**: Works with Windows clipboard through terminal-compat.zsh

### Font Support
- **Nerd Fonts**: Fully compatible with Monaspace Nerd Font
- **Terminal**: Inherits font settings from WezTerm/Windows Terminal

## File Type Settings

### Python
- 4-space indentation
- 88-character line width (Black formatter compatible)

### YAML/JSON
- 2-space indentation
- Appropriate syntax highlighting

### Markdown
- Text wrapping enabled
- 80-character line width

### Shell Scripts
- 2-space indentation
- Shell-specific settings

## Customization

### Local Configuration
Both editors support local customization files:

- **Vim**: `~/.vimrc.local`
- **Neovim**: `~/.config/nvim/local.lua`

These files are loaded automatically and ignored by ChezMoi, allowing machine-specific customizations.

### Adding Plugins
For a minimal setup, consider these modern alternatives:

#### Built-in Features (Neovim)
- Built-in LSP client
- Tree-sitter syntax highlighting
- Telescope (fuzzy finder)
- Built-in terminal

#### Classic Vim Plugins
If you prefer plugins, consider:
- **fzf.vim** - Fuzzy finder
- **vim-fugitive** - Git integration  
- **vim-airline** - Status line
- **nerdtree** - File explorer

### Color Schemes
Both configurations use sensible defaults but can be customized:

- **Vim**: Uses `desert` colorscheme (built-in)
- **Neovim**: Uses `habamax` (modern built-in scheme)

To change, modify the colorscheme line in the respective config.

## Performance

### Optimization Features
- **Lazy Redraw**: Don't redraw during macros
- **Fast Timeouts**: Optimized key sequence timing
- **Efficient Scrolling**: Smart scroll offset settings
- **Background Processes**: Organized backup/swap/undo files

### Startup Time
- **Vim**: Lightweight configuration, fast startup
- **Neovim**: Lua-based for better performance
- **Plugin-free**: No external dependencies for core functionality

## Troubleshooting

### Editor Not Found
```bash
# Check which editors are available
which nvim vim vi

# Check current EDITOR setting
echo $EDITOR
```

### Configuration Not Loading
```bash
# For Vim
vim --version | head -5

# For Neovim  
nvim --version | head -5

# Check config file exists
ls -la ~/.vimrc ~/.config/nvim/init.lua
```

### Clipboard Issues
The configuration automatically detects and uses system clipboard. If clipboard integration doesn't work:

1. **Linux**: Ensure `xclip` or `wl-clipboard` is installed
2. **WSL2**: Use the clipboard integration from terminal-compat.zsh
3. **Terminal**: Check if terminal supports OSC 52 clipboard sequences

### Font/Display Issues
Both editors inherit terminal font settings. If you see display issues:

1. **Check Terminal Font**: Ensure Nerd Font is properly configured
2. **Color Support**: Verify `$COLORTERM` is set to `truecolor`
3. **Terminal Compatibility**: Some features require modern terminal emulators

## Migration from Existing Setup

### From Basic Vim
The new configuration maintains compatibility with standard Vim usage while adding modern conveniences.

### From Heavy Plugin Setup
This configuration provides a solid foundation. You can gradually add plugins as needed in your local config files.

### From IDE
The editor integrates well with VS Code via the terminal, allowing you to use both as needed.

## Integration Points

### With Git
- **Merge Tool**: Both editors configured as Git merge tools
- **Commit Messages**: Optimized for writing commit messages
- **Diff Tool**: Can be used for reviewing diffs

### With Terminal
- **WezTerm**: Vim-style navigation keybindings
- **Shell**: Editor aliases respect context (VS Code vs terminal)
- **Jobs**: Background file operations don't interfere

### With Package Manager
- **Pixi**: Neovim installed via Pixi for consistency
- **System**: Falls back to system packages if needed
- **Portability**: Configuration works across different installations
