# ===================================================================
# Enhanced Zsh Completion Configuration
# ===================================================================
# This file configures Zsh's completion system for better usability
# and more intelligent behavior. It's loaded by ~/.zshrc and enhances
# the default completion system with:
# - Better matching algorithms
# - Visual improvements
# - Context-aware completions
# - Custom completions for modern tools

# ===================================================================
# Completion System Initialization
# ===================================================================
# Initialize the completion system with proper paths
autoload -Uz compinit

# Add local completion directories to fpath
fpath=(
    "$HOME/.local/share/zsh/site-functions"
    "$HOME/.local/share/zinit/completions"
    $fpath
)

# Initialize completions with safety check for /usr/share/zsh issues
if [[ -d /usr/share/zsh/vendor-completions ]]; then
    # Check for problematic completions and exclude them
    for compfile in /usr/share/zsh/vendor-completions/*; do
        if [[ -f "$compfile" ]] && [[ -r "$compfile" ]]; then
            # Skip known problematic completion files
            case "$(basename "$compfile")" in
                _docker) 
                    # Skip docker completion if it's causing issues
                    echo "⚠️  Skipping problematic Docker completion at $compfile" >&2
                    continue
                    ;;
                *)
                    fpath+=("$(dirname "$compfile")")
                    ;;
            esac
        fi
    done
fi

# Run compinit with error suppression for missing files
compinit -i 2>/dev/null

# ===================================================================
# Completion Behavior Configuration
# ===================================================================
# Configure how completions are generated and matched
zstyle ':completion:*' completer _complete _match _approximate  # Try exact, then fuzzy matching
zstyle ':completion:*' expand 'yes'                            # Expand globs before completion
zstyle ':completion:*' squeeze-slashes 'yes'                   # Normalize multiple slashes
# Case-insensitive and partial matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ===================================================================
# Visual Completion Styling
# ===================================================================
# Configure how completion menus look and behave
zstyle ':completion:*:*:*:*:*' menu select                    # Enable interactive menu selection
zstyle ':completion:*:matches' group 'yes'                    # Group similar completions
zstyle ':completion:*:options' description 'yes'             # Show descriptions for options
zstyle ':completion:*:options' auto-description '%d'          # Auto-generate descriptions

# Completion menu colors and formatting
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''                          # Don't show group names
zstyle ':completion:*' verbose yes                            # Show verbose completions

# ===================================================================
# Fuzzy Matching and Error Tolerance
# ===================================================================
# Configure approximate matching for typos and similar strings
zstyle ':completion:*' completer _complete _match _approximate  # Enable fuzzy matching
zstyle ':completion:*:match:*' original only                   # Show original when using match completer
zstyle ':completion:*:approximate:*' max-errors 1 numeric      # Allow 1 error for short words

# Scale error tolerance based on word length (longer words = more errors allowed)
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# ===================================================================
# System and Command Filtering
# ===================================================================
# Don't complete unavailable or internal commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ===================================================================
# Directory and File Completion
# ===================================================================
# Enhanced directory completion with colors and intelligent ordering
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # Use LS_COLORS for file listings
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true                     # Clean up multiple slashes

# ===================================================================
# History Completion
# ===================================================================
# Configure history word completion behavior
zstyle ':completion:*:history-words' stop yes                  # Stop at word boundaries
zstyle ':completion:*:history-words' remove-all-dups yes       # Remove all duplicate entries
zstyle ':completion:*:history-words' list false               # Don't list all history words
zstyle ':completion:*:history-words' menu yes                 # Enable menu for history

# ===================================================================
# Environment Variables
# ===================================================================
# Populate environmental variable completions
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# ===================================================================
# Network Host Completion
# ===================================================================
# Intelligent hostname completion from various sources
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*\]/\]}//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# ===================================================================
# User Filtering
# ===================================================================
# Don't complete system/service users in most contexts
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
  clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
  gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
  ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
  operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
  usbmux uucp vcsa wwwrun xfs '_*'

# Show ignored patterns when specifically requested
zstyle '*' single-ignored show

# ===================================================================
# Command-Specific Completion Behavior
# ===================================================================
# Ignore duplicate entries for certain commands
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# ===================================================================
# Process and System Command Completion
# ===================================================================
# Enhanced completion for process management commands
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# ===================================================================
# Manual Page Completion
# ===================================================================
# Better organization of manual pages by section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-tab true

# ===================================================================
# Media File Completion
# ===================================================================
# File type filtering for media players
zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

# ===================================================================
# SSH/SCP/RSYNC Completion
# ===================================================================
# Advanced completion for remote file operations
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr

# Filter out unwanted hosts and addresses
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# ===================================================================
# Modern Tool Completions
# ===================================================================
# Load completions for modern CLI tools managed by Pixi
# These tools provide their own completion scripts

# Pixi package manager completions
if command -v pixi >/dev/null; then
  eval "$(pixi completion --shell zsh)"
fi

# GitHub CLI completions
if command -v gh >/dev/null; then
  eval "$(gh completion -s zsh)"
fi

# Just task runner completions
if command -v just >/dev/null; then
  eval "$(just --completions zsh)"
fi

# ChezMoi dotfile manager completions
if command -v chezmoi >/dev/null; then
  eval "$(chezmoi completion zsh)"
fi
