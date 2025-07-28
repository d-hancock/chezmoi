# 🗂️ ChezMoi Dotfiles Structure & Stubs

> **Purpose:** Ready‑to‑fill skeleton of every file/folder your dotfile repo needs. Edit these stubs, then run `chezmoi apply`.

```
.chezmoi.toml                 # ChezMoi config (stub)
pixi.toml                     # Pixi dependencies (provided)
run_once_setup_tools.sh.tmpl  # Pixi + extra tool bootstrap
run_once_setup_fonts.sh.tmpl  # Nerd Font installer
run_once_setup_dirs.sh.tmpl   # Creates ~/dev etc.

dot_zshrc.tmpl                # Zsh + Zinit + Starship config
dot_gitconfig                 # Global Git settings

dot_config/
  starship/
    starship.toml             # Prompt theme
  wezterm/
    wezterm.lua               # Terminal config
  zsh/
    aliases.zsh               # Aliases stub
    completions.zsh           # Extra completions stub
  pixi/
    # future profiles here

dot_local/
  bin/
    sample-script.sh          # Custom scripts stub
```

---

## Stub Contents

### `.chezmoi.toml`

```toml
[source]
  directory = "~/.local/share/chezmoi"
```

### `run_once_setup_tools.sh.tmpl`

```bash
#!/usr/bin/env bash
set -e
# Install Pixi
if ! command -v pixi >/dev/null; then
  curl -sSf https://pixi.sh/install.sh | bash
fi
export PATH="$HOME/.pixi/bin:$PATH"
# Sync packages
cd "$(chezmoi source-path)"
pixi sync
# Fallback installs for tools not in conda-forge (edit list as needed)
cargo install gum lazydocker vipe || true
```

### `run_once_setup_fonts.sh.tmpl`

```bash
#!/usr/bin/env bash
set -e
mkdir -p ~/.local/share/fonts
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Monaspace.zip -o /tmp/Monaspace.zip
unzip -o /tmp/Monaspace.zip -d ~/.local/share/fonts/Monaspace
fc-cache -fv
```

### `dot_zshrc.tmpl`

```zsh
# Zinit
source ~/.zinit/bin/zinit.zsh
zinit ice from"gh-r" as"program"
zinit light starship/starship
eval "$(starship init zsh)"

# Plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Aliases & completions
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/completions.zsh
```

### `dot_config/starship/starship.toml`

```toml
# Minimal prompt preset – tweak freely
format = "\n[❯](bold green) "
[pixi]
format = "[$overlay]($style) "
```

### `dot_config/wezterm/wezterm.lua`

```lua
local wezterm = require 'wezterm'
return {
  font = wezterm.font_with_fallback { 'Monaspace Neon Nerd Font', 'Monaspace Radon Nerd Font' },
  color_scheme = 'Catppuccin Mocha',
  use_dead_keys = false,
}
```

### `dot_config/zsh/aliases.zsh`

```zsh
alias ll='eza -lah'
alias gs='git status'
```

### `dot_config/zsh/completions.zsh`

```zsh
# extra completions can be loaded here
```

### `sample-script.sh`

```bash
#!/usr/bin/env bash
# Example custom script – replace with your own utilities
echo "Hello from ~/.local/bin!"
```
