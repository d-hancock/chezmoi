# ===================================================================
# Terminal Compatibility Configuration
# ===================================================================
# This file provides compatibility fixes for Windows Terminal, VS Code,
# and WSL2 environments to ensure seamless cross-platform operation.
# Loaded by: ~/.zshrc via source command

# ===================================================================
# Terminal Environment Detection and Configuration
# ===================================================================
# Set TERM for better compatibility across different terminals
export TERM=${TERM:-xterm-256color}

# Enable truecolor support in supported terminals
export COLORTERM=truecolor

# ===================================================================
# VS Code Integration
# ===================================================================
# Configure environment when running in VS Code integrated terminal
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    export EDITOR="code --wait"
    export VISUAL="code --wait"
    export GIT_EDITOR="code --wait"
    
    # Optimize for VS Code terminal performance
    export DISABLE_AUTO_TITLE="true"
    
    # Add alias for quick editor access while still in VS Code
    alias vim='code'
    alias nvim='code'
fi

# ===================================================================
# Windows Terminal Optimization
# ===================================================================
# Detect and optimize for Windows Terminal
if [[ -n "$WT_SESSION" ]]; then
    # Windows Terminal specific settings
    export COLORTERM=truecolor
    export TERM=xterm-256color
    
    # Enable Windows Terminal features
    export WT_PROFILE_ID="$WT_PROFILE_ID"
fi

# ===================================================================
# WSL2 Clipboard Integration
# ===================================================================
# Provide unified clipboard commands across different environments

# Unalias any existing clipboard commands to avoid conflicts
unalias pbcopy 2>/dev/null || true
unalias pbpaste 2>/dev/null || true

  # Primary: Use Windows clipboard if available (WSL2)
  if command -v clip.exe >/dev/null 2>&1; then
      pbcopy() { clip.exe; }
      pbpaste() { powershell.exe -command "Get-Clipboard" 2>/dev/null || echo ""; }
  # Fallback 1: Use wl-clipboard for Wayland
  elif command -v wl-copy >/dev/null 2>&1; then
      pbcopy() { wl-copy; }
      pbpaste() { wl-paste; }
  # Fallback 2: Use xclip if available (X11/WSL2 with X server)
  elif command -v xclip >/dev/null 2>&1; then
      pbcopy() { xclip -selection clipboard; }
      pbpaste() { xclip -selection clipboard -o; }
  # Fallback 3: Provide no-op functions with helpful messages
  else
      pbcopy() { echo "No clipboard utility available. Install xclip, wl-clipboard, or use WSL2." >&2; }
      pbpaste() { echo "No clipboard utility available. Install xclip, wl-clipboard, or use WSL2." >&2; }
fi

# ===================================================================
# Path Compatibility
# ===================================================================
# Ensure Windows paths work correctly in WSL2
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    # Add Windows system paths for convenience (optional)
    # export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows"
    
    # Unalias any existing winpath to avoid conflicts
    unalias winpath 2>/dev/null || true
    
    # Helper function to convert Windows paths to WSL paths
    winpath() {
        if [[ $1 =~ ^[A-Za-z]: ]]; then
            echo "$1" | sed 's|\\|/|g' | sed 's|^\([A-Za-z]\):|/mnt/\L\1|'
        else
            echo "$1"
        fi
    }
    
    # Helper function to convert WSL paths to Windows paths
    wslpath() {
        wslpath -w "$1" 2>/dev/null || echo "$1"
    }
fi

# ===================================================================
# Font and Display Compatibility
# ===================================================================
# Ensure proper font rendering across terminals
if [[ "$TERM_PROGRAM" == "WezTerm" ]] || [[ -n "$WEZTERM_EXECUTABLE" ]]; then
    # WezTerm specific optimizations
    export TERM=wezterm
fi

# ===================================================================
# Shell Integration Fixes
# ===================================================================
# Fix common shell integration issues

# Ensure proper signal handling in different terminals
trap 'echo "Shell interrupted"' INT

# Handle terminal resize events properly
# Check if resize command is available before using it
if command -v resize >/dev/null 2>&1; then
    trap 'eval $(resize)' WINCH 2>/dev/null || true
else
    # Fallback: Use stty to handle terminal resize if resize command is not available
    trap 'stty size >/dev/null 2>&1' WINCH 2>/dev/null || true
fi

# ===================================================================
# Environment Variable Compatibility
# ===================================================================
# Set environment variables that may be missing in different contexts

# Ensure SHELL is set correctly
export SHELL=${SHELL:-$(which zsh)}

# Set default editor preference: Neovim > Vim > fallback
if command -v nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
    export VISUAL="nvim"
elif command -v vim >/dev/null 2>&1; then
    export EDITOR="vim"
    export VISUAL="vim"
else
    export EDITOR="vi"
    export VISUAL="vi"
fi

# Set browser for WSL2 (opens in Windows)
if [[ -n "$WSL_DISTRO_NAME" ]] && command -v wslview >/dev/null 2>&1; then
    export BROWSER=wslview
fi
