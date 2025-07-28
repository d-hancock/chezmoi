# ===================================================================
# Modern CLI Tool Aliases
# ===================================================================
# This file contains aliases that replace traditional Unix tools with modern,
# feature-rich alternatives. All tools are managed via Pixi and should be
# available through the conda-forge ecosystem.
# Loaded by: ~/.zshrc via source command

# ===================================================================
# File and Directory Operations
# ===================================================================
# Replace 'ls' with 'eza' - modern ls replacement with git integration
alias ls='eza --color=auto --group-directories-first'
alias ll='eza -lah --color=auto --group-directories-first'  # Long format with all files
alias la='eza -la --color=auto --group-directories-first'   # All files in long format
alias lt='eza --tree --level=2 --color=auto'                # Tree view (2 levels deep)
alias l='eza -1 --color=auto'                               # One file per line

# Replace 'cat' and pagers with 'bat' - syntax highlighting and git integration
alias cat='bat --paging=never'        # Quick view without paging
alias less='bat --paging=always'      # Paged view with syntax highlighting
alias more='bat --paging=always'      # Same as less

# ===================================================================
# Search and System Tools
# ===================================================================
# Modern replacements for common system utilities
alias find='fd'          # fd - faster, more user-friendly find
alias grep='rg'          # ripgrep - faster grep with better output
alias ps='procs'         # procs - modern ps with colors and tree view
alias top='btop'         # btop - beautiful system monitor
alias htop='btop'        # Use btop instead of htop
alias du='dust'          # dust - more intuitive disk usage
alias df='duf'           # duf - better disk free with colors

# ===================================================================
# Git Workflow Aliases
# ===================================================================
# Comprehensive Git shortcuts for faster development workflow
alias g='git'                    # Quick git access
alias gs='git status'            # Check repository status
alias ga='git add'               # Stage files
alias gc='git commit'            # Commit changes
alias gp='git push'              # Push to remote
alias gl='git pull'              # Pull from remote
alias gd='git diff'              # Show differences
alias gb='git branch'            # List/manage branches
alias gco='git checkout'         # Switch branches/restore files
alias gcb='git checkout -b'      # Create and switch to new branch
alias gm='git merge'             # Merge branches
alias gr='git rebase'            # Rebase commits
alias glog='git log --oneline --graph --decorate'  # Pretty log format

# ===================================================================
# Directory Navigation
# ===================================================================
# Quick navigation shortcuts
alias ..='cd ..'               # Go up one directory
alias ...='cd ../..'           # Go up two directories
alias ....='cd ../../..'       # Go up three directories
alias .....='cd ../../../..'   # Go up four directories
alias ~='cd ~'                 # Go to home directory
alias -- -='cd -'              # Go to previous directory

# ===================================================================
# System Utilities
# ===================================================================
# Handy system and shell utilities
alias reload='exec $SHELL'                    # Reload shell configuration
alias path='echo -e ${PATH//:/\\n}'           # Display PATH components
alias now='date +"%T"'                       # Current time
alias nowtime=now                             # Alias for 'now'
alias nowdate='date +"%d-%m-%Y"'              # Current date (DD-MM-YYYY)

# ===================================================================
# Network Utilities
# ===================================================================
# Network diagnostics and information
alias ip='ip -color=auto'                     # Colorized ip command
alias ping='ping -c 5'                       # Limit ping to 5 packets
alias ports='netstat -tulanp'                # Show all listening ports
alias myip='curl -s http://whatismyip.akamai.com/'  # Get external IP address

# ===================================================================
# Package Management
# ===================================================================
# Shortcuts for Pixi package manager
alias px='pixi'                              # Quick Pixi access
alias pxi='pixi install'                     # Install dependencies
alias pxid='pixi install --environment default'  # Install default tools only
alias pxidev='pixi install --environment dev'    # Install dev tools
alias pxr='pixi run'                         # Run Pixi task
alias pxs='pixi shell'                       # Enter Pixi shell
alias pxsd='pixi shell --environment default'    # Enter default environment
alias pxsdev='pixi shell --environment dev'      # Enter dev environment
alias pxa='pixi add'                         # Add new dependency

# ===================================================================
# ChezMoi Dotfile Management
# ===================================================================
# Shortcuts for managing dotfiles with ChezMoi
alias cz='chezmoi'                            # Quick ChezMoi access
alias cza='chezmoi apply'                     # Apply changes to home directory
alias czd='chezmoi diff'                      # Show differences before applying
alias cze='chezmoi edit'                      # Edit files in ChezMoi source
alias czs='chezmoi status'                    # Show ChezMoi status
alias czcd='cd $(chezmoi source-path)'        # Navigate to ChezMoi source directory

# ===================================================================
# Development Shortcuts
# ===================================================================
# Common development tool shortcuts
alias j='just'                               # Justfile task runner
alias v='$EDITOR'                            # Open default editor
alias vim='$EDITOR'                          # Use default editor instead of vim
alias code='code .'                          # Open current directory in VS Code

# ===================================================================
# File Operations (Enhanced)
# ===================================================================
# Safer file operations with confirmations and verbose output
alias mkdir='mkdir -pv'                      # Create directories with parents, verbose
alias cp='cp -iv'                            # Interactive and verbose copy
alias mv='mv -iv'                            # Interactive and verbose move
alias rm='rm -iv'                            # Interactive and verbose remove
alias ln='ln -iv'                            # Interactive and verbose link
alias chmod='chmod -c'                       # Report changes made
alias chown='chown -c'                       # Report changes made

# ===================================================================
# Archive and Compression
# ===================================================================
# Smart archive extraction function that detects file type
alias extract='function _extract() { 
  case $1 in 
    *.tar.gz|*.tgz) tar -xzf "$1" ;; 
    *.tar.bz2|*.tbz2) tar -xjf "$1" ;; 
    *.tar.xz|*.txz) tar -xJf "$1" ;; 
    *.zip) unzip "$1" ;; 
    *.rar) unrar x "$1" ;; 
    *.7z) 7z x "$1" ;; 
    *) echo "Unsupported format" ;; 
  esac 
}; _extract'

# ===================================================================
# Development and Testing
# ===================================================================
# Quick development server and utilities
alias serve='python3 -m http.server 8000'        # Start HTTP server on port 8000
alias serve-here='python3 -m http.server 8000'    # Same as above

# ===================================================================
# Weather and Information
# ===================================================================
# Quick weather information using wttr.in service
alias weather='curl -s "wttr.in/?format=3"'       # Quick weather summary
alias forecast='curl -s "wttr.in/"'               # Detailed weather forecast
