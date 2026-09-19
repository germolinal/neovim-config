# Neovim configuration

A small Neovim configuration managed with [lazy.nvim](https://github.com/folke/lazy.nvim). It includes Telescope, Neo-tree, completion, Treesitter, Git signs, comments, and LSP support for Rust, Go, TypeScript, Svelte, Terraform, YAML, TOML, and Python.

## Install

This configuration uses the Neovim 0.11+ LSP API. Install Neovim 0.11 or newer, then clone this repository into `~/.config/nvim`:

```sh
git clone https://github.com/germolinal/neovim-config.git ~/.config/nvim
nvim
```

On the first launch, lazy.nvim bootstraps itself and installs the plugins. Mason then installs the configured language servers. Use `:Lazy` to inspect plugin installation and `:Mason` to inspect or reinstall servers. Restart Neovim after Mason finishes.

> Back up or remove an existing `~/.config/nvim` before cloning there.

### macOS (Homebrew)

```sh
brew install neovim git fd ripgrep node python
```

For clipboard support, Neovim uses macOS's built-in `pbcopy`/`pbpaste` integration.

### Debian/Ubuntu Linux

```sh
sudo apt update
sudo apt install -y neovim git fd-find ripgrep nodejs npm python3 python3-pip cargo wl-clipboard
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
```

Ensure `~/.local/bin` is on `PATH` (it normally is on current Linux distributions). The `fd` symlink matters because Telescope invokes the command as `fd`. On X11, install `xclip` instead of `wl-clipboard`:

```sh
sudo apt install -y xclip
```

Other Linux distributions need the equivalent packages: `neovim`, `git`, `fd`, `ripgrep`, Node/npm, Python, Cargo, and either `wl-clipboard` (Wayland) or `xclip` (X11).

### Language servers

The recommended route is to let Mason install everything automatically. The relevant `:Mason` packages are:

| Language | Server / Mason package |
| --- | --- |
| Terraform | `terraform-ls` / `terraformls` |
| YAML | `yaml-language-server` / `yamlls` |
| TOML | `taplo` / `taplo` |
| Python | `pyright` / `pyright` |

If Mason is unavailable or you want the executables managed by the operating system instead, install them manually.

**macOS:**

```sh
brew install terraform-ls yaml-language-server taplo pyright
```

**Linux (portable manual approach):**

```sh
npm install -g yaml-language-server pyright
cargo install taplo-cli --locked
```

Install `terraform-ls` from the [HashiCorp terraform-ls releases](https://github.com/hashicorp/terraform-ls/releases) for your architecture and put the `terraform-ls` binary on `PATH`. Mason avoids this manual release download on both macOS and Linux.

Verify external installations with:

```sh
terraform-ls --version
yaml-language-server --version
taplo --version
pyright --version
```

Open a Terraform (`.tf`), YAML (`.yml`/`.yaml`), TOML (`.toml`), or Python (`.py`) file and run `:LspInfo` to confirm that its server attached.

## Keymaps

The leader key is `<Space>`. In key notation, `<C-p>` means Control-P and `<leader>` means Space.

### Configuration keymaps

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gd` | Go to LSP definition (Telescope) |
| Normal | `gr` | Find LSP references (Telescope) |
| Normal | `<C-S-O>` | List document symbols |
| Normal | `<C-p>` | Find files with Telescope |
| Normal | `<leader>fI` | Find files including Git-ignored files |
| Normal | `<leader>xx` | List diagnostics |
| Normal | `<leader>e` | Show diagnostic under cursor |
| Normal | `<leader>b` | Toggle Neo-tree |
| Normal/Visual | `<leader>y` | Yank selection/text to the system clipboard |
| Normal | `<leader>Y` | Yank current line to the system clipboard |
| Normal | `<leader>rl` | Run the current line as a shell command in a bottom terminal split |
| Normal | `<leader>fd` | Confirm and delete the current file |
| Normal | `gcc` | Toggle a comment on the current line |
| Visual | `gc` | Toggle comments on the selected lines |

`gcc` and visual `gc` are supplied by Comment.nvim. Because this config sets `clipboard=unnamedplus`, ordinary Vim `y`, `d`, `p`, and their variants use the system clipboard too. The explicit leader clipboard mappings are convenient reminders.

`<leader>rl` is intentionally shell-oriented: it sends the literal current line to a new terminal. It is useful for commands such as `pytest` or `terraform plan`; it does **not** interpret a Python/YAML/Terraform source line as language-specific code. For an interactive terminal use `:terminal` (or `:split | terminal`).

`<leader>fd` deletes the file on disk after confirmation and force-closes its buffer. It does not delete directories.

### Useful built-in Vim/Neovim commands

| Task | Keys / command |
| --- | --- |
| Comment without plugin | Insert `#`, `//`, etc. appropriate to the filetype; use `gcc`/`gc` for automatic comment syntax |
| Copy/yank | `y{motion}`, `yy` (line), `yaw` (word), `"+y` (explicit system clipboard) |
| Paste | `p` after cursor, `P` before cursor |
| Delete | `d{motion}`, `dd` (line), `x` (character) |
| Undo / redo | `u` / `<C-r>` |
| Horizontal / vertical split | `:split` / `:vsplit`, or `<C-w>s` / `<C-w>v` |
| Move between splits | `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l` |
| Close a split | `:close` or `<C-w>c` |
| Save / quit | `:write` (`:w`), `:quit` (`:q`), `:wq`, `:q!` |
| Search forward / backward | `/pattern<CR>` / `?pattern<CR>`; `n` next and `N` previous |
| Search word under cursor | `*` forward, `#` backward |
| Case-insensitive search | `:set ignorecase smartcase` — lowercase queries ignore case; a query containing uppercase becomes case-sensitive |
| Force case-sensitive / insensitive once | Add `\C` / `\c` to a pattern, e.g. `/Name\C` or `/Name\c` |
| Replace | `:%s/old/new/g`; add `c` (`:%s/old/new/gc`) to confirm each replacement |
| Run one shell command | `:!command` (for example, `:!pytest`) |
| Open terminal | `:terminal` or `:split | terminal`; use `<C-\\><C-n>` to leave Terminal mode |

## Telescope and ignored files

Regular `<C-p>` searches include hidden files but respect `.gitignore`, so ignored secrets such as `.env` do not clutter normal results. Use `<leader>fI` only when needed; it invokes Telescope with `no_ignore`, so typing `.env` finds an untracked, ignored `.env` without adding it to Git.

This is preferable to weakening `.gitignore`: `.env` stays ignored by Git and is absent from routine searches, while it remains available in the explicit ignored-file picker. If it contains secrets, never add it to the repository just to make it searchable.
