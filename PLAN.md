# Neovim TODO Cleanup Plan

## Summary

Keep the config on `vim-plug`, but modernize the overlapping plugin areas with current Neovim-compatible tools. Main changes: replace NERDTree, replace or trial CtrlP with a faster finder, move formatting to one dedicated formatter layer, use Astral's `ty` and native `ruff server` for Python, remove JavaScript debugging from scope, and make keymaps platform-aware.

Current upstream facts checked:

- Ruff's current editor backend is the native Rust `ruff server`, available through the `ruff` CLI and intended as the replacement for `ruff-lsp`.
- `ty` is Astral's Rust Python type checker and language server. It supports completion, navigation, diagnostics, rename, code actions, hover, inlay hints, semantic tokens, and workspace symbols. Its own docs say formatting should be handled by Ruff.
- `conform.nvim` is a formatter orchestrator, not a language-server replacement. It should replace `vim-prettier`, `coc-prettier` formatting-on-save, and ad hoc formatter autocmds, but not necessarily every CoC language feature by itself.
- `fff.nvim` is now broader than just a file picker: it provides Rust-backed file search, live grep, frecency, git status, and an index. Its speed comes from a persistent Rust backend and cached/indexed state, which can use more resident memory than one-shot `rg`/`fzf` commands.

## Key Changes

- Do not edit documentation files as part of this implementation. Keep all behavioral changes in config files only; update `README.md`/`docs.md` later only if explicitly requested.
- File tree: replace `preservim/nerdtree`, `nerdtree-git-plugin`, and `vim-nerdtree-syntax-highlight` with `nvim-tree/nvim-tree.lua` plus `nvim-tree/nvim-web-devicons`; map tree toggle to `,n` and reveal current file to `,N`.
- Search decision: run a short trial between `ibhagwan/fzf-lua` and `dmtrKovalenko/fff.nvim`.
  - Default recommendation: use `fzf-lua` if the goal is one mature picker for files, buffers, grep, git, diagnostics, LSP symbols, commands, and help with low config risk.
  - Choose `fff.nvim` instead if the priority is fastest repeated repo search, typo-tolerant matching, frecency ranking, and a Rust-backed index, accepting extra binary/index complexity and baseline memory use.
  - Planned mappings for either option: `,p` files, `,b` buffers, `,g` live grep, `,r` recent files, `,s` symbols where supported.
- Formatting: remove `vim-prettier` and disable CoC/prettier format-on-save. Add `stevearc/conform.nvim` as the only save-time formatter layer.
  - Python: `ruff_fix`, `ruff_organize_imports`, then `ruff_format`.
  - JSON/YAML/Markdown: `prettier` or `prettierd`.
  - TOML: `taplo`.
  - C/C++: `clang-format`.
  - Bash/sh: `shfmt`.
  - Vimscript: use a formatter only if a stable local tool is installed; otherwise leave Vimscript manual to avoid unreliable rewrites.
- Python language tooling: replace deprecated `ruff-lsp` with native `ruff server`; add `ty server` for Python type checking and language features. Prefer Neovim native LSP via `nvim-lspconfig` for `ty` and `ruff`, because Astral's Neovim docs target native LSP/lspconfig.
- CoC overlap: do not treat `conform.nvim` as a full CoC replacement. The practical cleanup is:
  - Move all formatting out of CoC and into Conform.
  - Move Python LSP from CoC custom servers to native LSP using `ty` and `ruff`.
  - Keep CoC temporarily for existing non-Python completion/LSP extensions only if removing it would break current workflows.
  - After Python and formatting are stable, decide whether to remove CoC entirely and replace remaining completion/LSP features with native LSP plus a completion plugin.
- Debugging: remove JavaScript/Node debug support from scope. If debugger support remains desired, keep it Python-focused first, with optional C/C++ later; do not install or configure `js-debug`.
- Platform-aware keymaps:
  - Linux/Windows: Ctrl mappings may remain for quick navigation where they work well.
  - macOS: prefer Command mappings only if the terminal or GUI Neovim sends distinguishable Command key sequences; otherwise use leader mappings as the portable fallback.
  - Keep comma leader mappings for every important command so the config works consistently across terminals.
- Line moving: enable normal/visual line moving with `<A-j>` down and `<A-k>` up, preserving indentation and visual selection.
- Python/mamba/conda: add `linux-cultist/venv-selector.nvim` for Python env selection because it supports Anaconda/Miniconda-style workflows and can integrate with picker plugins; map `,ve` to select env.
- Remote SSH: add `nosduco/remote-sshfs.nvim` for local UI + SSHFS workflow; map `,rc` connect, `,rd` disconnect, `,rf` remote files, `,rg` remote grep. Heavy LSP/debug tasks may still be better run directly on the remote machine if SSHFS latency or path mapping becomes a problem.
- Plugin cleanup: remove undeclared/stale local plugin assumptions, especially local `plugged/nerdcommenter`; keep `vim-commentary`, `vim-tmux-navigator`, `vim-gitgutter`, `startify`, `emmet-vim`, `yats.vim`, and `gruvbox` unless testing shows breakage.

## Performance Notes

- Lua plugins are usually a better fit for modern Neovim than Python or Node plugins because Lua runs in-process through Neovim's LuaJIT and avoids external host/plugin-provider overhead. This does not automatically mean every Lua plugin is faster; startup cost, lazy loading, indexing, and external processes matter more than language alone.
- Node/Python plugins can be excellent when they wrap strong tools, but long-running hosts and duplicate language servers increase memory use. Current overlap examples are CoC formatting plus `vim-prettier`, and `ruff-lsp` plus newer Ruff server.
- Rust-backed tools like Ruff, ty, ripgrep, fd, fzf, and fff are good choices for heavy analysis/search/formatting work. For `fff`, the speed model is persistent indexing and cached state, so repeated searches can be very fast, but memory use is a real tradeoff.
- Best rule for this config: use Lua for Neovim UI/orchestration, Rust/compiled CLIs for heavy work, and avoid duplicate Node/Python background services unless they provide unique value.

## Test Plan

- Run `nvim --headless -i NONE +qa` to verify startup loads without config errors.
- Run `:PlugInstall`/`:PlugUpdate`, then `:checkhealth` for `nvim-tree`, the chosen finder, `conform`, native LSP, and remote SSHFS dependencies.
- Verify formatting on Python, JSON, TOML, C/C++, Bash, YAML, Vimscript, and Markdown samples.
- Verify Python tooling with one project: `ty` diagnostics/navigation/completion and Ruff diagnostics/fixes/formatting.
- Compare finder candidates on the same repo: startup behavior, file search, live grep, result quality with typos, memory footprint, and dependency friction.
- Remote smoke test: connect to one SSH host via SSHFS, open a file, run remote find/grep, save a file, then disconnect cleanly.

## Assumptions

- Keep `vim-plug` as requested; use `lua << EOF` blocks inside `init.vim` for Lua plugins instead of migrating to `init.lua`.
- Current Neovim `0.12.2` is sufficient for the recommended plugins.
- Primary portable keybinding prefix remains comma leader.
- Remote development target is local Neovim UI with SSHFS, not a full VSCode-style remote runtime.
- Headless startup currently only showed sandbox-related ShaDa/log permission issues; use `-i NONE` for verification in this environment.
