### 🧩 Your End-to-End Setup at a Glance

| Layer                          | Chosen Technology                                             | Why                                                              | How it’s Managed                                                                    |
| ------------------------------ | ------------------------------------------------------------- | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **OS & Desktop**               | Ubuntu 22.04 LTS + GNOME (with optional tweaks)               | Stable base, Wayland-ready                                       | GNOME settings exported via `dconf` (optional) and theming files in `dot_config/`   |
| **Terminal UI**                | **WezTerm** + **Monaspace Nerd Font**                         | GPU-accelerated, Lua-configurable; dev-focused font with glyphs  | `dot_config/wezterm/wezterm.lua` (chezmoi-managed)                                  |
| **Shell**                      | **Zsh**                                                       | Familiar syntax, plugin ecosystem                                | `dot_zshrc.tmpl` (templated), modular alias / completion files in `dot_config/zsh/` |
| **Prompt**                     | **Starship**                                                  | Cross-shell, superfast, TOML config                              | `dot_config/starship/starship.toml`                                                 |
| **Plugin Manager**             | **Zinit (zi)**                                                | Lazy / async plugin loading                                      | Loaded in `.zshrc.tmpl`; plugins declared there                                     |
| **History & Env Helpers**      | Atuin, Direnv, McFly, Gum                                     | Searchable history, per-dir envs, interactive scripts            | Installed via Pixi; minimal config in shell stubs                                   |
| **Core CLI Toolkit**           | Fzf, Ripgrep, Bat, Eza, Dust, Duf, Btop, Gitui, etc.          | Modern replacements for GNU classics                             | *All* packaged in `pixi.toml`; `pixi sync` puts them on `$PATH`                     |
| **Dev / Data Tools**           | Pixi, Just, jq, qsv, xsv, git-delta, gh, cheat-sh, tealdeer   | Reproducible env, data wrangling, better git UX                  | Same `pixi.toml`; `run_once_setup_tools.sh.tmpl` installs hold-outs via `cargo`     |
| **Dotfile Manager**            | **ChezMoi**                                                   | Declarative rendering, templating, secrets                       | Everything lives in `~/.local/share/chezmoi/`; synced to GitHub                     |
| **Bootstrap Flow**             | run-once scripts (`setup_tools`, `setup_fonts`, `setup_dirs`) | One-time tasks (Pixi install, font fetch, directory scaffolding) | Executed automatically on first `chezmoi apply`                                     |
| **Profiles / Tags** *(future)* | ChezMoi templates + Pixi `[feature.*]`                        | Minimal vs Dev vs Infra installs                                 | Use `.tmpl` conditionals or Pixi features to include/exclude blocks                 |

---

### 🚀 How a Fresh Machine Bootstraps

1. **Install ChezMoi & Clone Repo**

   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   chezmoi init git@github.com:<you>/dotfiles.git
   chezmoi apply            # ← runs run_once scripts
   ```

2. **run\_once\_setup\_tools.sh.tmpl**

   * Detects / installs Pixi
   * Executes `pixi sync` → pulls every conda-forge package in `pixi.toml`
   * Falls back to `cargo install` for tools missing from conda-forge (e.g. `gum`, `lazydocker`)

3. **Fonts & Dirs**
   `run_once_setup_fonts.sh.tmpl` drops Monaspace Nerd Font into `~/.local/share/fonts`;
   `run_once_setup_dirs.sh.tmpl` creates `~/dev`, `~/workspace`, etc.

4. **Shell Reload** – on first new Zsh session you get:

   * Starship prompt (shows active Pixi env)
   * Zinit-loaded plugins (syntax highlighting, autosuggestions, fzf-tab)
   * All Pixi tools on `$PATH`

---

### 🔄 Making Changes

1. **Edit in Source**
   `chezmoi edit ~/.config/wezterm/wezterm.lua` (or open repo in VS Code).
2. **Preview** with `chezmoi diff`
3. **Apply** to home with `chezmoi apply`
4. **Commit & Push** inside `$(chezmoi source-path)` to sync dotfiles repo.

---

### 🗂️ Key Files You Already Have Stubbed

```
.chezmoi.toml                  # chezmoi config
pixi.toml                      # all conda-forge dependencies
run_once_setup_tools.sh.tmpl   # Pixi + extra tools
run_once_setup_fonts.sh.tmpl   # Nerd font installer
dot_zshrc.tmpl                 # Zsh, Zinit, Starship
dot_config/starship/starship.toml
dot_config/wezterm/wezterm.lua
dot_gitconfig
```

Add or refine any stub, rerun `chezmoi apply`, and your environment will stay reproducible across every machine you touch.

---

### ✅ Next Logical Steps

1. **Fill in stubs** (aliases, WezTerm theme, Starship sections).
2. **Test** in a VM or new user: `chezmoi init … && chezmoi apply`.
3. (Optional) **Add Pixi feature profiles** (e.g., `[feature.minimal]`, `[feature.infra]`).
4. **Write README.md** with one-liner install instructions.

