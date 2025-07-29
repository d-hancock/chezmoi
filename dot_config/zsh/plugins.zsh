# ===================================================================
# Zinit Plugin Stack - ChezMoi Managed
# ===================================================================
# Comprehensive Zinit plugin configuration for Linux developer workflow
# This file is sourced by dot_zshrc.tmpl after core Zinit setup
# Organized by function: QOL, Navigation, Git, System, Development

# Note: Core Zinit initialization and fast-syntax-highlighting are handled in dot_zshrc.tmpl
# This file focuses on additional plugin loading and configuration

# ===================================================================
# Plugin Loading Error Handling
# ===================================================================
# Set up error handling for plugin loading
setopt local_options no_warn_create_global

# Function to safely load zinit plugins with error handling
safe_zinit_load() {
    local plugin_type="$1"
    local plugin_name="$2"
    
    case "$plugin_type" in
        "light")
            zinit light "$plugin_name" 2>/dev/null || echo "⚠️  Failed to load plugin: $plugin_name"
            ;;
        "snippet")
            zinit snippet "$plugin_name" 2>/dev/null || echo "⚠️  Failed to load snippet: $plugin_name"
            ;;
    esac
}

# ===================================================================
# CORE QUALITY OF LIFE PLUGINS
# ===================================================================
# Essential plugins for improved shell experience

# Fish-like autosuggestions from shell history
# Suggests commands as you type based on history and completions
zinit light zsh-users/zsh-autosuggestions

# Additional completion definitions for common tools
# Extends built-in completions for git, docker, npm, etc.
zinit light zsh-users/zsh-completions

# Search shell history by substring using up/down arrows
# Press up/down to cycle through commands matching current input
zinit light zsh-users/zsh-history-substring-search

# Note: zsh-syntax-highlighting is loaded as fast-syntax-highlighting in main zshrc

# ===================================================================
# NAVIGATION & DIRECTORY MANAGEMENT
# ===================================================================
# Tools for efficient filesystem navigation

# Jump to frequently used directories (alternative to zoxide)
# Usage: z <partial-directory-name>
# Note: zoxide is initialized in main zshrc if available via Pixi
zinit light agkozak/zsh-z

# FZF integration for fuzzy finding and navigation
# NOTE: FZF shell integration is handled in dot_zshrc.tmpl to avoid conflicts
# Provides fuzzy search for files, history, processes
if command -v fzf >/dev/null 2>&1; then
    # Disabled to avoid conflicts with main .zshrc FZF setup
    # FZF integration and file management
# NOTE: FZF is configured in dot_zshrc.tmpl - avoid duplicate integrations
# zinit light junegunn/fzf  # DISABLED - using manual integration in .zshrc
# zinit light unixorn/fzf-zsh-plugin  # DISABLED - conflicts with manual setup
    
    # FZF shell integration is handled in dot_zshrc.tmpl to ensure it's loaded correctly.
    echo "🔍 FZF available - shell integration loaded via .zshrc"
elif command -v pixi >/dev/null 2>&1; then
    echo "💡 FZF not found. Consider installing with: pixi add fzf"
fi

# Alternative: Directory bookmarking and fuzzy jump
# Uncomment if you prefer anyframe over fzf/zsh-z combination
# zinit light mollifier/anyframe

# ===================================================================
# GIT WORKFLOW ENHANCEMENT
# ===================================================================
# Advanced Git integration and utilities

# Oh My Zsh Git plugin - comprehensive Git aliases and functions
# Provides aliases like gst, gco, gaa, gcm, etc.
zinit snippet OMZ::plugins/git

# Git extras - additional Git commands for workflow enhancement
# Adds commands like git-summary, git-effort, git-undo, git-release
zinit light tj/git-extras

# ===================================================================
# PACKAGE MANAGEMENT & ENVIRONMENT
# ===================================================================
# Tools for managing development environments and packages

# Pixi environment integration and helpers
# Load Pixi shell integration if available
if command -v pixi >/dev/null 2>&1; then
    # Note: Pixi completions are loaded in completions.zsh to avoid duplication
    
    # Custom Pixi environment switcher function
    pixi-activate() {
        if [[ -f "pixi.toml" ]]; then
            eval "$(pixi shell-hook)"
            echo "🐍 Activated Pixi environment: $(basename $PWD)"
        else
            echo "❌ No pixi.toml found in current directory"
        fi
    }
    
    # Auto-activate Pixi environment when entering directory with pixi.toml
    pixi-auto-activate() {
        if [[ -f "pixi.toml" ]] && [[ "$PIXI_PROJECT_ROOT" != "$PWD" ]]; then
            echo "🔧 Pixi project detected, use 'pixi-activate' to activate environment"
        fi
    }
    
    # Hook into directory change
    autoload -U add-zsh-hook
    add-zsh-hook chpwd pixi-auto-activate
fi

# ASDF version manager for multiple programming languages
# Manages Node.js, Python, Ruby, Go, and other language runtimes
# Note: Only load if not using Pixi for language management
if ! command -v pixi >/dev/null 2>&1; then
    zinit light asdf-vm/asdf
fi

# ===================================================================
# SYSTEM & GENERAL TOOLING
# ===================================================================
# System administration and general utility plugins

# Universal archive extraction - handles tar, zip, rar, etc.
# Usage: extract <archive-file>
zinit snippet OMZ::plugins/extract

# Systemd service management helpers
# Provides aliases like sc-start, sc-stop, sc-status, sc-reload
zinit snippet OMZ::plugins/systemd

# Oh My Zsh library functions and plugins for enhanced functionality
zinit wait lucid for \
  OMZL::git.zsh            # Git helper functions

# Load Oh My Zsh plugins individually to avoid syntax errors
zinit snippet OMZ::plugins/sudo               # Double-tap ESC to prefix command with sudo
zinit snippet OMZ::plugins/command-not-found  # Suggests package installation for missing commands

# ===================================================================
# DEVELOPMENT & LANGUAGE MANAGEMENT
# ===================================================================
# Tools for software development and language version management

# Docker command integration and aliases
# Provides Docker-specific completions and shortcuts
if command -v docker >/dev/null 2>&1; then
    # Load Docker plugin with error handling
    zinit snippet OMZ::plugins/docker 2>/dev/null || {
        echo "⚠️  Failed to load Docker plugin from OMZ, using fallback"
        # Create a simple Docker completion fallback if the plugin fails
        if ! command -v _docker >/dev/null 2>&1; then
            # Simple Docker alias as fallback
            alias dk='docker'
            alias dkc='docker-compose'
            alias dkps='docker ps'
            alias dkimg='docker images'
        fi
    }
fi

# ===================================================================
# PERFORMANCE & SAFETY ENHANCEMENTS
# ===================================================================
# Plugins that improve shell performance and safety

# Defer plugin loading to speed up shell initialization
# Improves startup time by lazy-loading heavy plugins
zinit light romkatv/zsh-defer

# Replace dangerous rm command with safer trash behavior
# Moves files to trash instead of permanent deletion
zinit light mattmc3/zsh-safe-rm

# Suggest alias usage when full command is typed - DISABLED FOR DEBUGGING
# Reminds you to use aliases you've defined: "gst" instead of "git status"
# zinit light MichaelAquilina/zsh-you-should-use

# Navigate up directory hierarchy by name
# Usage: bd <directory-name> to jump up to any parent directory
zinit light tarrasch/zsh-bd

# ===================================================================
# CONDITIONAL PLUGIN LOADING
# ===================================================================
# Load plugins based on available tools or environment

# Load kubectl plugins only if Kubernetes CLI is available
if command -v kubectl >/dev/null 2>&1; then
    echo "🚢 Loading Kubernetes plugins..."
    # Kubernetes context and namespace switching
    zinit light "ahmetb/kubectx"
    # Kubernetes command aliases (k, kgp, kgs, etc.)
    zinit snippet OMZ::plugins/kubectl
fi

# Load AWS plugins only in AWS environments
if [[ -n "$AWS_PROFILE" ]] || [[ -f ~/.aws/credentials ]]; then
    echo "☁️  Loading AWS plugins..."
    # AWS CLI helpers and credential management
    zinit snippet OMZ::plugins/aws
fi

# Load Python development plugins if Python is available
if command -v python3 >/dev/null 2>&1; then
    # Only load pyenv if not using Pixi for Python management
    if ! command -v pixi >/dev/null 2>&1; then
        # Lazy pyenv loading for better startup performance
        zinit light "davidparsson/zsh-pyenv-lazy"
    fi
    
    # Poetry plugin for Python package management (compatible with Pixi)
    if command -v poetry >/dev/null 2>&1; then
        zinit snippet OMZ::plugins/poetry
    fi
fi

# Load Node.js plugins if Node is available
if command -v node >/dev/null 2>&1; then
    # Only load nvm if not using Pixi for Node management
    if ! command -v pixi >/dev/null 2>&1; then
        # Node Version Manager integration
        zinit light "lukechilds/zsh-nvm"
    fi
    
    # NPM and Yarn completions (always useful)
    zinit snippet OMZ::plugins/npm
    if command -v yarn >/dev/null 2>&1; then
        zinit snippet OMZ::plugins/yarn
    fi
fi

# Load Rust/Cargo plugins if available
if command -v cargo >/dev/null 2>&1; then
    zinit snippet OMZ::plugins/rust
fi

# Load Go plugins if available
if command -v go >/dev/null 2>&1; then
    zinit snippet OMZ::plugins/golang
fi

# ===================================================================
# PLUGIN CONFIGURATION
# ===================================================================
# Configure plugin behavior and settings

# ZSH Autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

# History substring search configuration  
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=white,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=white,bold"
HISTORY_SUBSTRING_SEARCH_FUZZY=1

# Bind history substring search to up/down arrows
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# You-should-use configuration - DISABLED
# YSU_MESSAGE_POSITION="after"
# YSU_HARDCORE=1

# Safe-rm configuration - protect important directories
ZSH_SAFE_RM_OPTS="-I"

# ===================================================================
# FZF INTEGRATION SETTINGS
# ===================================================================
# Configure FZF for optimal developer experience (only if FZF is available)

if command -v fzf >/dev/null 2>&1; then
    # Use fd for file searching if available (faster than find)
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .pixi'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude .pixi'
    fi

    # Use ripgrep for text searching if available
    if command -v rg >/dev/null 2>&1; then
        export FZF_DEFAULT_OPTS='--ansi --preview "rg --color=always --line-number --no-heading --smart-case {q} || true"'
    fi

    # Enhanced FZF key bindings
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
else
    echo "💡 FZF not found. Install with: sudo apt install fzf (or via your package manager)"
fi

# ===================================================================
# PIXI INTEGRATION & ENVIRONMENT MANAGEMENT
# ===================================================================
# Enhanced Pixi integration for package and environment management

# Pixi environment directories following XDG standards
export PIXI_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/pixi"
export PIXI_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pixi"

# Ensure Pixi directories exist
mkdir -p "$PIXI_CACHE_DIR" "$PIXI_CONFIG_DIR"

# Pixi project detection and auto-activation helper
pixi-status() {
    if [[ -f "pixi.toml" ]]; then
        echo "📦 Pixi project detected in $(pwd)"
        echo "🔧 Environment: $(pixi info --json 2>/dev/null | jq -r '.environment_name // "default"' 2>/dev/null || echo "default")"
        echo "📋 Available tasks:"
        pixi task list 2>/dev/null || echo "  No tasks defined"
    else
        echo "❌ No pixi.toml found in current directory"
    fi
}

# Enhanced Pixi environment switcher
pixi-shell() {
    if [[ -f "pixi.toml" ]]; then
        echo "🐍 Activating Pixi environment..."
        pixi shell
    else
        echo "❌ No pixi.toml found in current directory"
        return 1
    fi
}

# Pixi task runner with fuzzy search
pixi-task() {
    if [[ -f "pixi.toml" ]]; then
        if command -v fzf >/dev/null 2>&1; then
            local task=$(pixi task list --summary 2>/dev/null | fzf --prompt="Select task: " --height=40%)
            if [[ -n "$task" ]]; then
                echo "🚀 Running task: $task"
                pixi run "$task"
            fi
        else
            echo "📋 Available tasks:"
            pixi task list
            echo ""
            echo "💡 Usage: pixi run <task-name>"
        fi
    else
        echo "❌ No pixi.toml found in current directory"
    fi
}

# Pixi package search and install helper
pixi-search() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: pixi-search <package-name>"
        return 1
    fi
    
    echo "🔍 Searching for packages matching: $1"
    pixi search "$1"
}

# ===================================================================
# ASDF INTEGRATION (when not using Pixi)
# ===================================================================
# Configure ASDF version manager (fallback when Pixi is not used)

if ! command -v pixi >/dev/null 2>&1; then
    # Set ASDF data directory to follow XDG specification
    export ASDF_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf"
fi

# ===================================================================
# POST-PLUGIN SETUP
# ===================================================================
# Actions to take after all plugins are loaded

# Post-plugin setup - Clean up any plugin loading issues
# Reload completions after all plugins are loaded
autoload -Uz compinit
compinit -i 2>/dev/null  # Suppress errors from missing completion files

# Load Pixi completions if available
if command -v pixi >/dev/null 2>&1; then
    # Note: Pixi completions are loaded in completions.zsh to avoid duplication
    :
fi

echo "🔌 Zinit plugin stack loaded successfully"

# Display environment info on new shell
if [[ -f "pixi.toml" ]] && [[ -z "$PIXI_PROJECT_ROOT" ]]; then
    echo "💡 Pixi project detected! Use 'pixi-status' for info or 'pixi-shell' to activate"
fi

# ===================================================================
# ALIASES & SHORTCUTS FOR ENHANCED WORKFLOW
# ===================================================================
# Additional aliases for Pixi and development workflow
# Note: Main aliases are in ~/.config/zsh/aliases.zsh

# Enhanced Pixi workflow shortcuts (beyond basic px alias)
alias pxt='pixi-task'     # Fuzzy task selector
alias pxs='pixi-status'   # Show project status
alias pxsh='pixi-shell'   # Activate environment
alias pxsearch='pixi-search'  # Search packages

# Development tool shortcuts for quick access (with fallbacks)
if command -v lazygit >/dev/null 2>&1; then
    alias lg='lazygit'
else
    alias lg='echo "💡 lazygit not installed. Install with: cargo install lazygit"'
fi

if command -v lazydocker >/dev/null 2>&1; then
    alias lzd='lazydocker'
else
    alias lzd='echo "💡 lazydocker not installed. Install with: cargo install lazydocker"'
fi

if command -v btop >/dev/null 2>&1; then
    alias btm='btop'
elif command -v htop >/dev/null 2>&1; then
    alias btm='htop'
else
    alias btm='top'
fi

# Smart cat replacement
if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    alias catt='bat'  # Full bat with paging
elif command -v batcat >/dev/null 2>&1; then
    alias cat='batcat --paging=never'
    alias catt='batcat'
fi

# ===================================================================
# Local Plugin Customizations
# ===================================================================
# Add your custom plugin configurations here
