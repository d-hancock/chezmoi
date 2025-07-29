#!/usr/bin/env bash
# ===================================================================
# Shell Issues Fix Script
# ===================================================================
# This script fixes common shell startup issues after chezmoi apply

echo "🔧 Fixing shell configuration issues..."

# Fix 1: Allow direnv .envrc file
if [[ -f ~/.envrc ]]; then
    echo "📝 Allowing direnv .envrc file..."
    direnv allow ~/.envrc 2>/dev/null || echo "⚠️  direnv not available or .envrc already allowed"
fi

# Fix 2: Handle Docker completion issues
docker_completion="/usr/share/zsh/vendor-completions/_docker"
if [[ -f "$docker_completion" ]]; then
    echo "🐳 Checking Docker completion file..."
    # Test if the completion file is readable and valid
    if ! zsh -c "source '$docker_completion'" 2>/dev/null; then
        echo "⚠️  Docker completion file is problematic, backing up..."
        sudo mv "$docker_completion" "${docker_completion}.backup" 2>/dev/null || {
            echo "⚠️  Cannot move Docker completion (requires sudo)"
            echo "    Run: sudo mv '$docker_completion' '${docker_completion}.backup'"
        }
    fi
elif command -v docker >/dev/null 2>&1; then
    echo "🐳 Creating Docker completion file..."
    sudo mkdir -p "$(dirname "$docker_completion")" 2>/dev/null
    docker completion zsh | sudo tee "$docker_completion" >/dev/null 2>&1 || {
        echo "⚠️  Cannot create Docker completion (requires sudo)"
    }
fi

# Fix 3: Clear any problematic zi alias/function conflicts
echo "🧹 Clearing potential zi alias conflicts..."
unalias zi 2>/dev/null || true
unset -f zi 2>/dev/null || true

# Fix 4: Rebuild zsh completion cache
echo "🔄 Rebuilding zsh completion cache..."
rm -f ~/.zcompdump* 2>/dev/null
# Force rebuild by running compinit with -C flag
zsh -c "autoload -Uz compinit; compinit -C" 2>/dev/null || true

# Fix 5: Create local completion directories if they don't exist
echo "📁 Creating completion directories..."
mkdir -p ~/.local/share/zsh/site-functions
mkdir -p ~/.local/share/zinit/completions

# Fix 6: Check FZF installation and set up proper path
if command -v fzf >/dev/null 2>&1; then
    echo "🔍 Setting up FZF integration..."
    # Try to find FZF shell integration files
    fzf_locations=(
        "/usr/share/fzf"
        "/usr/local/share/fzf"
        "$(dirname $(which fzf 2>/dev/null) 2>/dev/null)/../share/fzf"
        "$HOME/.fzf"
    )
    
    for location in "${fzf_locations[@]}"; do
        if [[ -d "$location/shell" ]]; then
            echo "✅ Found FZF shell integration at: $location"
            echo "💡 Set FZF_BASE=\"$location\" in your shell config if needed"
            break
        fi
    done
fi

echo ""
echo "✅ Shell fixes applied!"
echo ""
echo "Next steps:"
echo "1. Open a new terminal window, OR"
echo "2. Run: source ~/.zshrc"
echo ""
echo "If issues persist, the Docker completion may need manual sudo access:"
echo "   sudo mv '$docker_completion' '${docker_completion}.backup'"
