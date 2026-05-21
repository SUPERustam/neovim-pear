# Neovim TODO Cleanup Plan

## Summary

Keep the config on `vim-plug`, but modernize the weak plugin areas with current Neovim-compatible tools. Main changes: replace NERDTree/CtrlP/prettier overlap, move primary mappings away from Ctrl, use Ruff's native server, add reliable formatting/debug/remote workflows, and update docs so each TODO is closed with documented commands.

Research basis: current config in `README.md`, `init.vim`, `coc-settings.json`; upstream docs for `nvim-tree`, `fzf-lua`, `conform.nvim`, Ruff's native server, `nvim-dap`, `remote-sshfs.nvim`, and `venv-selector.nvim`.

## Key Changes

- Documentation: rewrite `README.md` TODO into completed feature docs; make `docs.md` the full reference for install, dependencies, plugins, shortcuts, formatting, debugging, Python envs, and remote SSHFS.
- File tree: replace `preservim/nerdtree`, `nerdtree-git-plugin`, and `vim-nerdtree-syntax-highlight` with `nvim-tree/nvim-tree.lua` plus `nvim-tree/nvim-web-devicons`; map tree toggle to `,n` and reveal current file to `,N`.
- Search: replace `ctrlp.vim` with `ibhagwan/fzf-lua`; add `,p` files, `,b` buffers, `,g` live grep, `,r` recent files, `,s` symbols/CoC symbols where available. Do not use `fff.nvim` for this config because it is narrower and Rust-backed, while `fzf-lua` covers files, grep, buffers, git, diagnostics, and works cleanly from Vimscript via Lua blocks.
- Formatting: remove `vim-prettier` and keep only one formatting path. Add `stevearc/conform.nvim` for format-on-save across Python, bash/sh, TOML, YAML, JSON, Markdown, HTML/CSS/JS/TS; use `ruff format` for Python, `shfmt` for shell, `taplo` for TOML, `prettier` for YAML/JSON/web formats. Keep `coc-prettier` only if CoC needs it for code actions, not as the save formatter.
- CoC shortcuts: document and normalize CoC mappings under leader: `,d` diagnostics list, `,a` code action, `,rn` rename, `,f` format, `gd/gy/gi/gr` navigation, `K` hover. Replace deprecated `ruff-lsp` with `ruff server` in `coc-settings.json`.
- Debugging: replace `vimspector` with `nvim-dap`, `nvim-dap-ui`, and `nvim-dap-python`; configure Python via `debugpy`, C/C++ via `cpptools` or `codelldb`, and Node via `js-debug` if installed. Use mappings `,dc` continue, `,db` breakpoint, `,do` step over, `,di` step into, `,du` toggle UI, `,dr` repl/reset.
- Ctrl migration: move custom `<C-n>`, `<C-p>`, `<C-d>`, and pane-navigation mappings to leader-based equivalents. Use `,h`, `,j`, `,k`, `,l` for window movement and `,H`, `,J`, `,K`, `,L` for moving windows. Keep no Ctrl mappings as primary documented shortcuts.
- Line moving: enable normal/visual line moving with `<A-j>` down and `<A-k>` up, preserving indentation and visual selection.
- Python/mamba/conda: add `linux-cultist/venv-selector.nvim` for Python env selection because it supports Anaconda/Miniconda and fzf-lua; map `,ve` to select env and document launching Neovim from an activated mamba/conda shell as the default for tools/debugging.
- Remote SSH: add `nosduco/remote-sshfs.nvim` for local UI + SSHFS workflow; map `,rc` connect, `,rd` disconnect, `,rf` remote files, `,rg` remote grep. Document that heavy LSP/debug tasks may still be better run on the remote machine if SSHFS latency or path mapping becomes a problem.
- Plugin cleanup: remove undeclared/stale local plugin assumptions from docs, especially local `plugged/nerdcommenter`; keep `vim-commentary`, `vim-tmux-navigator`, `vim-gitgutter`, `startify`, `emmet-vim`, `yats.vim`, and `gruvbox` unless later testing shows breakage.

## Test Plan

- Run `nvim --headless -i NONE +qa` to verify startup loads without config errors.
- Run `:PlugInstall`/`:PlugUpdate`, then `:checkhealth` for `nvim-tree`, `fzf-lua`, `conform`, `dap`, and remote SSHFS dependencies.
- Manual smoke tests: open a repo, toggle tree, reveal file, find files, live grep, move lines, format Python/sh/TOML/YAML/JSON buffers, use CoC hover/rename/action, select a conda/mamba env, and start a Python debug session.
- Remote smoke test: connect to one SSH host via SSHFS, open a file, run remote find/grep, save a file, then disconnect cleanly.

## Assumptions

- Keep `vim-plug` as requested; use `lua << EOF` blocks inside `init.vim` for Lua plugins instead of migrating to `init.lua`.
- Current Neovim `0.12.2` is sufficient for the recommended plugins.
- Primary keybinding prefix remains comma leader.
- Remote development target is local Neovim UI with SSHFS, not a full VSCode-style remote runtime.
- Headless startup currently only showed sandbox-related ShaDa/log permission issues; use `-i NONE` for verification in this environment.
