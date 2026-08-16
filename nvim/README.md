# Neovim Configuration

A lightweight Neovim IDE configuration built for an external coding-agent workflow: the agent handles project discovery, builds, tests, and execution, while Neovim focuses on editing, language intelligence, navigation, and code review.

## Language support

- Lua
- Bash / Shell
- Python
- Markdown
- JSON and JSONC
- TOML
- YAML

KDL and Rust are intentionally not configured.

## Requirements

Install these dependencies **before starting Neovim for the first time**.

### Required

- Neovim 0.12 or newer (`vim.pack` is used for plugin management)
- Git
- cURL
- `unzip`, `tar`, and `gzip`
- Node.js and npm (required by several Mason language-server packages)
- A C compiler and standard build tools (required for Tree-sitter parsers)
- ripgrep (`rg`, used by file and live-grep pickers)
- `wl-clipboard` on Wayland (required by `clipboard=unnamedplus`)

### Recommended

- fd
- GNU Stow
- A Nerd Font
- A terminal with true-color support

On Arch Linux / Arch Linux ARM:

```bash
sudo pacman -S --needed \
  neovim git curl unzip tar gzip \
  nodejs npm base-devel ripgrep fd \
  wl-clipboard stow
```

Verify the Neovim version:

```bash
nvim --version | head -1
```

## Installation

### Clone only the Neovim package

```bash
git clone --filter=blob:none --sparse \
  https://github.com/Nivella-Raven/dotfiles.git ~/dotfiles

cd ~/dotfiles
git sparse-checkout set nvim
stow --target="$HOME" nvim
```

The Stow command creates:

```text
~/.config/nvim -> ~/dotfiles/nvim/.config/nvim
```

The target path must not already contain another Neovim configuration. Back up an existing configuration before running Stow.

### Clone the complete dotfiles repository

```bash
git clone https://github.com/Nivella-Raven/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --target="$HOME" nvim
```

## First start

Start Neovim normally; do not set `NVIM_APPNAME`:

```bash
nvim
```

On the first start, the configuration automatically:

1. Downloads 25 plugins with `vim.pack`.
2. Refreshes the Mason registry.
3. Installs the configured development tools.
4. Installs the configured Tree-sitter parsers after `tree-sitter-cli` becomes available.

Keep Neovim open while the initial installation is running. Use the following commands to inspect or retry installation:

```vim
:Mason
:ToolBootstrap
:messages
```

## Managed development tools

Mason automatically installs these tools; they do not need to be installed globally:

- `tree-sitter-cli`
- `shellcheck`
- `shfmt`
- `lua-language-server`
- `bash-language-server`
- `marksman`
- `json-lsp`
- `taplo`
- `yaml-language-server`
- `pyright`
- `ruff`

The configuration installs these Tree-sitter parsers:

- Lua
- Bash
- Python
- Markdown
- Markdown Inline
- JSON (also used for JSONC)
- TOML
- YAML

## Language tooling

| Language | Language servers and tools | Formatting |
| --- | --- | --- |
| Lua | LuaLS | LuaLS |
| Bash / Shell | BashLS, ShellCheck | shfmt through BashLS |
| Python | Pyright, Ruff | Ruff |
| Markdown | Marksman | None |
| JSON / JSONC | JSONLS, SchemaStore | JSONLS |
| TOML | Taplo | Taplo |
| YAML | YAML Language Server, SchemaStore | YAML Language Server |

Formatting is LSP-only and is never run automatically on save.

## Core keybindings

The leader key is `Space`.

| Key | Action |
| --- | --- |
| `<Space>e` | Open MiniFiles |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>fb` | Find buffers |
| `<Space>fd` | Find diagnostics in the current buffer |
| `<Space>fD` | Find diagnostics in all buffers |
| `<Space>cf` | Format the current buffer with LSP |
| `<Space>ch` | Toggle LSP inlay hints |
| `<Space>cn` | Insert an annotated comment |
| `<Space>gg` | Git status |
| `<Space>gd` | Diff the current file |
| `<Space>gD` | Diff the repository |
| `K` | LSP hover documentation |
| `grn` | LSP rename |
| `gra` | LSP code action |

MiniClue displays additional keybinding hints after a prefix is pressed.

## Design scope

This configuration intentionally does not provide:

- Embedded agent integration
- Project or workspace management
- Automatic working-directory changes
- Build, run, or test commands
- Embedded terminal management
- Debug Adapter Protocol support
- Session management
- Format-on-save

Those responsibilities are expected to be handled by the surrounding shell, multiplexer, or external coding agent.
