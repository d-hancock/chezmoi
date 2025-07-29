#!/bin/bash
# ===================================================================
# Fix ZSH Issues Script
# ===================================================================
# This script fixes common ZSH configuration issues including:
# - Zinit plugin loading problems
# - Missing completions
# - FZF path issues
# - Docker completion errors

set -e

echo "🔧 Fixing ZSH configuration issues..."

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p "$HOME/.local/share/zsh/site-functions"
mkdir -p "$HOME/.cache/zsh"
mkdir -p "$HOME/.local/share/zsh"

# Clean up problematic zinit state
echo "🧹 Cleaning up Zinit state..."
if [[ -d "$HOME/.local/share/zinit/plugins/_unknown" ]]; then
    echo "  Removing broken _unknown plugin..."
    rm -rf "$HOME/.local/share/zinit/plugins/_unknown"
fi

# Fix FZF path if FZF is installed
if command -v fzf >/dev/null 2>&1; then
    echo "🔍 Setting up FZF..."
    FZF_PATH="$(dirname $(dirname $(which fzf)))"
    
    # Update .fzf.zsh with correct path
    if [[ -f "$HOME/.fzf.zsh" ]]; then
        sed -i "s|\${FZF_PATH}|${FZF_PATH}|g" "$HOME/.fzf.zsh"
        echo "  Updated FZF path in ~/.fzf.zsh"
    fi
fi

# Fix Docker completions if Docker is available
if command -v docker >/dev/null 2>&1; then
    echo "🐳 Setting up Docker completions..."
    
    # Create a simple Docker completion fallback
    cat > "$HOME/.local/share/zsh/site-functions/_docker" << 'EOF'
#compdef docker
# Basic Docker completion fallback
_docker() {
    local state
    _arguments \
        '1: :->commands' \
        '*: :->args'
    
    case $state in
        commands)
            _values 'docker commands' \
                'build[Build an image]' \
                'run[Run a container]' \
                'ps[List containers]' \
                'images[List images]' \
                'pull[Pull an image]' \
                'push[Push an image]' \
                'exec[Execute command in container]' \
                'logs[Show container logs]' \
                'stop[Stop container]' \
                'start[Start container]' \
                'restart[Restart container]' \
                'rm[Remove container]' \
                'rmi[Remove image]'
            ;;
    esac
}

_docker "$@"
EOF
    echo "  Created Docker completion fallback"
fi

# Install bat if not available and pixi is present
if ! command -v bat >/dev/null 2>&1 && command -v pixi >/dev/null 2>&1; then
    echo "🦇 Installing bat via Pixi..."
    pixi add bat || echo "  Failed to install bat, continuing..."
fi

# Fix shell history permissions
echo "📚 Fixing shell history..."
touch "$HOME/.local/share/zsh/history"
chmod 600 "$HOME/.local/share/zsh/history"

# Rebuild zsh completions
echo "🔄 Rebuilding completions..."
rm -f ~/.zcompdump*
zsh -c "autoload -Uz compinit && compinit -i" 2>/dev/null || true

echo "✅ ZSH fixes applied! Please restart your shell or run 'exec zsh' to reload."
echo ""
echo "If you still see issues, try:"
echo "  1. Run 'exec zsh' to reload the shell"
echo "  2. Check 'pixi add fzf bat' to install missing tools"
echo "  3. Run 'zinit update' to update plugins"
