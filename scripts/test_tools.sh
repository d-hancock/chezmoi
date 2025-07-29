#!/bin/bash
# ===================================================================
# Test Essential Tools Script
# ===================================================================
# This script tests if our essential development tools are available
# and provides helpful installation commands if they're missing

echo "🔍 Testing essential development tools..."
echo ""

# Test function
test_tool() {
    local tool="$1"
    local install_cmd="$2"
    
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool: $(which $tool)"
    else
        echo "❌ $tool: NOT FOUND"
        if [[ -n "$install_cmd" ]]; then
            echo "   💡 Install with: $install_cmd"
        fi
    fi
}

echo "📦 Core Tools:"
test_tool "pixi" "curl -sSf https://pixi.sh/install.sh | bash"
test_tool "chezmoi" "pixi add chezmoi"
test_tool "git" "sudo apt install git"

echo ""
echo "🚀 Navigation & Search:"
test_tool "fzf" "sudo apt install fzf"
test_tool "rg" "pixi add ripgrep"
test_tool "fd" "pixi add fd-find"
test_tool "bat" "sudo apt install bat"
test_tool "eza" "sudo apt install eza"

echo ""
echo "⭐ Shell Enhancement:"
test_tool "starship" "pixi add starship"
test_tool "zoxide" "pixi add zoxide"
test_tool "atuin" "pixi add atuin (Linux/macOS only)"
test_tool "direnv" "pixi add direnv"

echo ""
echo "🔧 System Tools:"
test_tool "btop" "pixi add btop"
test_tool "duf" "pixi add duf"
test_tool "dust" "pixi add dust"
test_tool "ncdu" "pixi add ncdu"
test_tool "tmux" "pixi add tmux"

echo ""
echo "📝 Editors & Dev:"
test_tool "nvim" "pixi add neovim"
test_tool "jq" "pixi add jq"

echo ""
echo "🎨 Optional Tools:"
test_tool "lazygit" "cargo install lazygit"
test_tool "lazydocker" "cargo install lazydocker"
test_tool "gum" "cargo install gum"

echo ""
if command -v pixi >/dev/null 2>&1; then
    echo "📋 Pixi Environment Status:"
    echo "   Project: $(pwd)"
    if [[ -f "pixi.toml" ]]; then
        echo "   ✅ pixi.toml found"
        echo "   📦 Available environments:"
        pixi info | grep -A 10 "Environments" || echo "   No environments configured"
    else
        echo "   ❌ No pixi.toml in current directory"
    fi
fi

echo ""
echo "🏁 Test complete!"
echo "💡 Run 'pixi install' in a directory with pixi.toml to install tools"
echo "💡 Run the setup script to install missing system tools"
