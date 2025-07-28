# ===================================================================
# Additional Zinit Plugin Configuration
# ===================================================================
# This file loads additional plugins beyond the core setup in .zshrc
# It's sourced after the main Zinit setup is complete
# Add extra plugins here without duplicating core functionality

# Note: Core plugins are loaded in dot_zshrc.tmpl:
# - zdharma-continuum/fast-syntax-highlighting
# - zsh-users/zsh-completions  
# - zsh-users/zsh-autosuggestions
# - OMZL::git.zsh, OMZP::git, OMZP::sudo, OMZP::command-not-found

# ===================================================================
# Optional Additional Plugins
# ===================================================================
# Uncomment plugins below as needed for your workflow

# Enhanced Git integration
# zinit light "wfxr/forgit"                    # Interactive git commands with fzf

# Enhanced directory navigation  
# zinit light "agkozak/zsh-z"                  # Alternative to zoxide

# Docker integration
# zinit light "akarzim/zsh-docker-aliases"     # Docker command aliases

# Python development
# zinit light "davidparsson/zsh-pyenv-lazy"    # Lazy pyenv loading

# Node.js development
# zinit light "lukechilds/zsh-nvm"             # Node version manager

# Kubernetes integration
# zinit light "dbz/kube-aliases"               # Kubernetes command aliases

# ===================================================================
# Example: Conditional Plugin Loading
# ===================================================================
# Load plugins based on available tools or environment

# Load kubectl plugins only if kubectl is available
# if command -v kubectl >/dev/null 2>&1; then
#     zinit light "ahmetb/kubectx"
# fi

# Load AWS plugins only in AWS environments
# if [[ -n "$AWS_PROFILE" ]] || [[ -f ~/.aws/credentials ]]; then
#     zinit light "antonbabenko/oh-my-zsh-is-cache-credential-helper"
# fi

# ===================================================================
# Local Plugin Customizations
# ===================================================================
# Add your custom plugin configurations here
