# Neovim configuration

A small Neovim configuration managed with [lazy.nvim](https://github.com/folke/lazy.nvim). It provides Telescope search, Neo-tree file browsing, LSP completion and navigation, Treesitter highlighting, Git signs, comments, and an Onedark theme.

## Requirements and installation

Neovim **0.11 or newer** is required because the configuration uses the `vim.lsp.config()` and `vim.lsp.enable()` APIs. `git` is required to bootstrap lazy.nvim. Telescope is configured to use `fd` for file searches, and `ripgrep` is useful for Telescope text searches.

Clone the repository into Neovim's configuration directory:

```sh
git clone https://github.com/germolinal/neovim-config.git ~/.config/nvim
nvim
```

On the first launch, lazy.nvim installs the plugins from `lazy-lock.json`. Mason then installs the configured language servers. Use `:Lazy` to inspect plugins and `:Mason` to inspect or reinstall language servers. Restart Neovim after installation if a server does not attach.

> Back up or remove an existing `~/.config/nvim` before cloning there.

### macOS

```sh
brew install neovim git fd ripgrep
```

Neovim uses macOS's built-in `pbcopy`/`pbpaste` integration for the system clipboard.

### Debian/Ubuntu

```sh
sudo apt update
sudo apt install -y neovim git fd-find ripgrep wl-clipboard
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
```

Ensure `~/.local/bin` is on `PATH`. On X11, install `xclip` instead of `wl-clipboard`:

```sh
sudo apt install -y xclip
```

Other Linux distributions need equivalent packages for Neovim, Git, `fd`, `ripgrep`, and a clipboard provider.

## Language servers

Mason is configured to ensure these servers are installed:

| File types | LSP server | Mason package |
| --- | --- | --- |
| Rust | `rust_analyzer` | `rust-analyzer` |
| Go | `gopls` | `gopls` |
| JavaScript/TypeScript | `ts_ls` | `typescript-language-server` |
| Svelte | `svelte` | `svelte-language-server` |
| Terraform | `terraformls` | `terraform-ls` |
| YAML | `yamlls` | `yaml-language-server` |
| TOML | `taplo` | `taplo` |
| Python | `pyright` | `pyright` |

All servers receive nvim-cmp capabilities, and LSP inlay hints are enabled globally. To check an active buffer, use `:LspInfo`. If Mason cannot install a server, install the corresponding executable manually and make sure it is on `PATH`.

## Keymaps

The global leader and local leader are both `<Space>`. `<C-p>` means Control-P; `<C-S-O>` means Control-Shift-O.

### Configuration keymaps

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gd` | Go to LSP definitions with Telescope |
| Normal | `gr` | Find LSP references with Telescope |
| Normal | `<C-S-O>` | Find symbols in the current file |
| Normal | `<C-p>` | Find files with Telescope (hidden files allowed, Git-ignored files excluded) |
| Normal | `<leader>fI` | Find files including hidden and Git-ignored files |
| Normal | `<leader>xx` | List diagnostics with Telescope |
| Normal | `<leader>e` | Show the diagnostic under the cursor |
| Normal | `<leader>b` | Toggle Neo-tree |
| Normal/Visual | `<leader>y` | Yank text to the system clipboard |
| Normal | `<leader>Y` | Yank the current line to the system clipboard |
| Normal | `<leader>fd` | Confirm and delete the current file, then close its buffer |
| Normal | `<leader>zd` | Open uncommitted changes with zdiff |
| Normal | `<leader>zD` | Compare the working tree with `main` using zdiff |
| Normal | `gcc` | Toggle a comment on the current line |
| Visual | `gc` | Toggle comments on the selection |

The `gcc` and visual `gc` mappings are provided by Comment.nvim. Since `clipboard=unnamedplus` is enabled, ordinary yanks, deletes, and puts also use the system clipboard. `<leader>fd` only deletes files, not directories, and asks for confirmation first.

Zdiff is lazy-loaded when `:Zdiff` or either zdiff mapping is used. The `main` comparison assumes a local `main` branch.

### Completion keymaps (Insert mode)

| Key | Action |
| --- | --- |
| `<C-Space>` | Open the completion menu |
| `<CR>` | Confirm the selected completion (selects the first item if needed) |
| `<Tab>` / `<S-Tab>` | Select the next / previous completion |

Completion suggestions currently come from LSP (`nvim_lsp`) only.

## Plugins and behavior

- **lazy.nvim** bootstraps and manages plugins; the exact revisions are recorded in `lazy-lock.json`.
- **Telescope** provides file search, LSP definitions/references/symbols, and diagnostics. File search uses `fd`, includes hidden files, and excludes `.git` while respecting Git ignore rules by default.
- **Neo-tree** provides the file explorer, toggled with `<leader>b`.
- **nvim-lspconfig**, **mason.nvim**, and **mason-lspconfig.nvim** configure and install the language servers listed above.
- **nvim-cmp** and **cmp-nvim-lsp** provide LSP completion.
- **nvim-treesitter** starts Treesitter highlighting when a parser is available and runs `:TSUpdate` when installed or updated.
- **gitsigns.nvim** displays Git changes in the sign column using its default setup.
- **Comment.nvim** supplies the `gcc` and `gc` comment mappings.
- **zdiff.nvim** opens diffs for uncommitted changes or changes relative to `main`.
- **onedark.nvim** is loaded with the `darker` style.

The configuration also enables line numbers and sets both `mapleader` and `maplocalleader` to Space.

## Useful built-in commands

| Task | Keys / command |
| --- | --- |
| Copy / yank | `y{motion}`, `yy`, or `"+y` |
| Paste | `p` / `P` |
| Undo / redo | `u` / `<C-r>` |
| Split | `:split` / `:vsplit` or `<C-w>s` / `<C-w>v` |
| Move between splits | `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l` |
| Save / quit | `:w`, `:q`, `:wq`, `:q!` |
| Search | `/pattern<CR>` / `?pattern<CR>`; `n` and `N` navigate |
| Replace | `:%s/old/new/g` (add `c` to confirm) |
| Run a shell command | `:!command` |
| Open a terminal | `:terminal`; leave Terminal mode with `<C-\\><C-n>` |

For routine searches use `<C-p>`. Use `<leader>fI` deliberately when looking for ignored files such as `.env`; those files remain ignored by Git.
