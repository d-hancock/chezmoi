# Modern CLI tool replacements
alias ls='eza --color=auto --group-directories-first'
alias ll='eza -lah --color=auto --group-directories-first'
alias la='eza -la --color=auto --group-directories-first'
alias lt='eza --tree --level=2 --color=auto'
alias l='eza -1 --color=auto'

alias cat='bat --paging=never'
alias less='bat --paging=always'
alias more='bat --paging=always'

alias find='fd'
alias grep='rg'
alias ps='procs'
alias top='btop'
alias htop='btop'
alias du='dust'
alias df='duf'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias glog='git log --oneline --graph --decorate'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# System utilities
alias reload='exec $SHELL'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Networking
alias ip='ip -color=auto'
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias myip='curl -s http://whatismyip.akamai.com/'

# Package management
alias px='pixi'
alias pxi='pixi install'
alias pxr='pixi run'
alias pxs='pixi shell'
alias pxa='pixi add'

# ChezMoi shortcuts
alias cz='chezmoi'
alias cza='chezmoi apply'
alias czd='chezmoi diff'
alias cze='chezmoi edit'
alias czs='chezmoi status'
alias czcd='cd $(chezmoi source-path)'

# Development shortcuts
alias j='just'
alias v='$EDITOR'
alias vim='$EDITOR'
alias code='code .'

# Quick file operations
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -iv'
alias chmod='chmod -c'
alias chown='chown -c'

# Archive extraction
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

# Quick server
alias serve='python3 -m http.server 8000'
alias serve-here='python3 -m http.server 8000'

# Weather
alias weather='curl -s "wttr.in/?format=3"'
alias forecast='curl -s "wttr.in/"'
