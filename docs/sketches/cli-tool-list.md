# 🛠️ CLI Tooling Stack

A categorized list of CLI tools chosen to improve quality of life, usability, performance, and shell ergonomics. Intended for installation via Pixi and tracked through chezmoi.

Each entry includes:

- **Install**: Preferred package manager (`apt`, `pixi`, etc.)
- **Why**: What makes it useful in your workflow
- **Platform**: Compatibility tags (Linux, macOS, WSL)
- **Tags**: Profile relevance (dev, infra, minimal, etc.)

---

## 🔍 Navigation & Search

| Tool      | Install | Why It's Useful                                   | Platform        | Tags         |
| --------- | ------- | ------------------------------------------------- | --------------- | ------------ |
| `fzf`     | pixi    | Fast fuzzy file and command search                | Linux/macOS/WSL | dev, infra   |
| `ripgrep` | pixi    | Blazing-fast search across files                  | Linux/macOS/WSL | dev, search  |
| `fd`      | pixi    | Simpler `find` alternative with sensible defaults | Linux/macOS/WSL | dev, minimal |
| `zoxide`  | pixi    | Smarter, faster `cd` replacement with memory      | Linux/macOS/WSL | dev, minimal |
| `bat`     | pixi    | Syntax-highlighted `cat` with paging              | Linux/macOS/WSL | dev, minimal |
| `tldr`    | pixi    | Community-driven, simplified man pages            | Linux/macOS/WSL | minimal, dev |

---

## 🧑‍💻 Prompt & Shell Enhancements

| Tool                      | Install | Why It's Useful                                     | Platform        | Tags         |
| ------------------------- | ------- | --------------------------------------------------- | --------------- | ------------ |
| `starship`                | pixi    | Fast prompt with powerful customization             | Linux/macOS/WSL | dev, minimal |
| `zinit`                   | pixi    | Lightweight plugin manager for Zsh                  | Linux/macOS     | shell        |
| `zsh-autosuggestions`     | pixi    | Real-time typing hints based on history             | Linux/macOS     | shell        |
| `zsh-syntax-highlighting` | pixi    | Syntax colorization while typing                    | Linux/macOS     | shell        |
| `atuin`                   | pixi    | Searchable, syncable shell history                  | Linux/macOS/WSL | shell, dev   |
| `direnv`                  | pixi    | Auto-load per-project envs when `cd` into directory | Linux/macOS/WSL | dev, minimal |
| `gum`                     | pixi    | Build pretty interactive shell scripts              | Linux/macOS     | dev, scripts |
| `fm`                      | pixi    | Minimal terminal file manager                       | Linux           | minimal      |
| `mcfly`                   | pixi    | Predictive, context-aware shell history             | Linux/macOS/WSL | shell        |

---

## 🛠️ General Utilities

| Tool         | Install | Why It's Useful                           | Platform        | Tags            |
| ------------ | ------- | ----------------------------------------- | --------------- | --------------- |
| `eza`        | pixi    | Modern `ls` with icons, colors, tree view | Linux/macOS/WSL | minimal, dev    |
| `duf`        | pixi    | Disk usage viewer with UI                 | Linux/macOS/WSL | infra, sysadmin |
| `httpie`     | pixi    | Intuitive HTTP client                     | Linux/macOS/WSL | dev, testing    |
| `btop`       | pixi    | Graphical system monitor                  | Linux/macOS/WSL | infra, sysadmin |
| `entr`       | pixi    | Run commands on file changes              | Linux/macOS     | dev, build      |
| `ncdu`       | pixi    | Terminal disk usage explorer              | Linux/macOS/WSL | infra           |
| `hyperfine`  | pixi    | CLI benchmarking tool                     | Linux/macOS     | dev, perf       |
| `curlie`     | pixi    | Curl with simpler syntax                  | Linux/macOS/WSL | dev, testing    |
| `tmux`       | apt     | Terminal multiplexer                      | Linux/macOS/WSL | dev, sysadmin   |
| `htop`       | apt     | Interactive process viewer                | Linux/macOS/WSL | sysadmin        |
| `gitui`      | pixi    | TUI Git interface                         | Linux/macOS     | dev, git        |
| `lazydocker` | pixi    | TUI for Docker containers                 | Linux/macOS     | dev, docker     |
| `tig`        | apt     | Git history and patch staging UI          | Linux/macOS     | dev, git        |
| `fx`         | pixi    | JSON inspector and explorer               | Linux/macOS     | dev, tools      |
| `dust`       | pixi    | Modern, visual disk usage view            | Linux/macOS     | infra           |
| `bandwhich`  | pixi    | Per-process bandwidth monitor             | Linux           | infra, net      |
| `vipe`       | pixi    | Pipe tool for inserting editor            | Linux/macOS     | dev, scripting  |

---

## 📆 Developer Tools

| Tool        | Install | Why It's Useful                                  | Platform        | Tags              |
| ----------- | ------- | ------------------------------------------------ | --------------- | ----------------- |
| `pixi`      | pixi    | Environment + package manager w/ reproducibility | Linux/macOS/WSL | dev, env          |
| `git-delta` | pixi    | Enhanced diffs in color for git                  | Linux/macOS     | dev, git          |
| `gh`        | apt     | GitHub CLI for issues, PRs, repo management      | Linux/macOS/WSL | dev, git          |
| `chezmoi`   | apt     | Dotfile manager with templating                  | Linux/macOS/WSL | bootstrap, config |
| `just`      | pixi    | Command runner with Make-like syntax             | Linux/macOS     | dev, scripts      |
| `qsv`       | pixi    | Ultra-fast CSV processor                         | Linux/macOS     | dev, data         |
| `jq`        | pixi    | JSON processor with scripting                    | Linux/macOS/WSL | dev, data         |
| `sd`        | pixi    | Simpler find/replace over `sed`                  | Linux/macOS     | dev, scripts      |
| `tealdeer`  | pixi    | Fast Rust-based `tldr` client                    | Linux/macOS/WSL | help, minimal     |
| `runme`     | pixi    | Execute markdown doc snippets                    | Linux/macOS     | dev, docs         |
| `termdown`  | pixi    | Markdown presentation in terminal                | Linux/macOS     | dev, docs         |
| `cheat.sh`  | pixi    | Shell cheat sheet viewer                         | Linux/macOS     | help, shell       |
| `lf`        | pixi    | Terminal file explorer (vim-like)                | Linux/macOS     | dev, minimal      |
| `xsv`       | pixi    | CLI for slicing/analyzing CSV                    | Linux/macOS     | dev, data         |

---

## 📊 Suggested Improvements & Expansions

- **Categorize by use-case profiles**: Add tags like `dev`, `infra`, `obsidian`, `minimal` to group toolsets by use type.
- **Add install source info**: e.g., `apt`, `pixi`, `cargo`, `brew`, etc.
- **Describe real-world usage**: Add "why it’s useful" examples per tool.
- **Optional tool tier**: Mark extras as "core" vs "optional" for lightweight installs.
- **Add aliases/functions**: Include default `alias` or `function` examples alongside the tool, e.g. `alias cat='bat'`.
- **Cross-platform notes**: Annotate tools that work across Mac/Linux/WSL.

This list represents your core CLI experience. All tools can be declared in `pixi.toml` and auto-installed via chezmoi bootstrap scripts.
