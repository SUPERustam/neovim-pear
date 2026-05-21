# Neovim Setup

This is a Vimscript-based Neovim setup managed with
[vim-plug](https://github.com/junegunn/vim-plug). The leader key is `,`.

## Update Everything

Copy-paste this script from anywhere. It updates Neovim when the local package
manager is known, updates this config repository, refreshes vim-plug, updates
all Vim plugins, updates CoC extensions, and refreshes the supporting Python and
Node packages used by the config.

```sh
set -eu

NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

echo "==> Updating Neovim"
if command -v brew >/dev/null 2>&1; then
  brew update
  brew upgrade neovim || brew install neovim
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y neovim
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf upgrade -y neovim || sudo dnf install -y neovim
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --needed neovim
else
  echo "No supported package manager found. Update Neovim manually:"
  echo "https://github.com/neovim/neovim/blob/master/INSTALL.md"
fi

echo "==> Updating this config"
if [ -d "$NVIM_CONFIG/.git" ]; then
  git -C "$NVIM_CONFIG" pull --rebase --autostash
else
  echo "Config repo not found at $NVIM_CONFIG; skipping git update."
fi

echo "==> Updating vim-plug"
curl -fLo "$NVIM_DATA/site/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "==> Updating Python support"
python3 -m pip install --upgrade pip setuptools pynvim debugpy

echo "==> Updating Node support"
if command -v npm >/dev/null 2>&1; then
  npm install -g neovim eslint vscode-cpptools
else
  echo "npm is not installed; skipping Node package updates."
fi

echo "==> Updating Vim plugins and CoC extensions"
nvim --headless +'PlugUpgrade' +'PlugUpdate --sync' +'CocUpdateSync' +qa

echo "==> Done"
```

## Dependencies

| Dependency | Required by | Why it is needed | Where it appears |
| --- | --- | --- | --- |
| Neovim | Everything | Runs the editor and loads this config. | `README.md`, `setup.sh`, update script |
| Homebrew | Update script on macOS | Updates or installs Neovim on macOS. | `docs.md` update script |
| `git` | `sync.sh`, `ctrlp.vim`, `vim-gitgutter`, `nerdtree-git-plugin`, update script | Pulls this config, lists project files for CtrlP, and powers Git UI/status plugins. | `sync.sh`, `init.vim:11`, `init.vim:12`, `init.vim:219` |
| `curl` | `setup.sh`, update script | Downloads `vim-plug` and the Node installer fallback. | `setup.sh` |
| `vim-plug` | All Vim plugins | Plugin manager used by every `Plug ...` entry. | `autoload/plug.vim`, `init.vim:1` |
| Python 3 | Python run shortcut, Python host support, Vimspector, `ruff-lsp` | Runs Python files with `<F7>`, provides Neovim Python integration, and supports Python debugging/linting tools. | `setup.sh`, `init.vim:405`, `coc-settings.json` |
| `pip` | `pynvim`, `debugpy`, `ruff-lsp` | Installs and updates Python packages used by Neovim and language tooling. | `setup.sh` |
| `pynvim` | Neovim Python provider | Lets Python-based Neovim integrations talk to the editor. | `setup.sh` |
| `debugpy` | `vimspector` | Python debug adapter installed as one of the Vimspector gadgets. | `setup.sh`, `init.vim:382` |
| `uv` | Optional Python tooling | Not referenced directly by this config today; useful if you prefer installing Python CLI tools such as `ruff-lsp` outside `pip`. | Not referenced |
| Node.js | `coc.nvim`, CoC extensions, `vim-prettier`, `eslint`, Vimspector Node debugger | Runs CoC, language servers, formatter tooling, and JavaScript debug adapters. | `setup.sh`, `init.vim:2`, `init.vim:18` |
| `npm` | `neovim` npm package, `eslint`, `vscode-cpptools` | Installs global Node packages used by this setup. | `setup.sh` |
| `neovim` npm package | Node-based Neovim integrations | Provides Node client support for Neovim plugins/tools. | `setup.sh` |
| `eslint` | `coc-eslint` | Provides JavaScript/TypeScript lint diagnostics and fixes. | `setup.sh`, `init.vim:230` |
| `yarn` | `vim-prettier` | Runs the plugin install hook: `yarn install --frozen-lockfile --production`. | `init.vim:18` |
| Prettier | `vim-prettier`, `coc-prettier` | Formats JS, TS, CSS, JSON, Markdown, Vue, YAML, HTML, and related filetypes. | `init.vim:18`, `init.vim:231` |
| `clangd` | `coc-clangd` | C/C++ language server for completion, diagnostics, and navigation. | `setup.sh`, `init.vim:233`, `coc-settings.json` |
| `vscode-cpptools` | `vimspector` | C/C++ debug adapter gadget for Vimspector. | `setup.sh`, `init.vim:382` |
| `vscode-node-debug2` | `vimspector` | Node.js debug adapter gadget for Vimspector. | `init.vim:382` |
| `gcc` | C `<F7>` run shortcut | Compiles and runs C files. | `init.vim:390` |
| `g++` | C++ `<F7>` run shortcut | Compiles and runs C++ files. | `init.vim:388` |
| `ruff-lsp` | CoC custom Python language server | Provides Python language-server behavior configured for `python` filetypes. | `coc-settings.json` |
| `tmux` | `vim-tmux-navigator` | Enables moving between Vim splits and tmux panes with the same navigation keys. | `init.vim:5` |

## Plugins

### Vim Plugins

| Plugin | Purpose |
| --- | --- |
| `neoclide/coc.nvim` | LSP, completion, diagnostics, code actions, and extensions. |
| `preservim/nerdtree` | File tree sidebar. |
| `ctrlpvim/ctrlp.vim` | Fuzzy file finder. |
| `christoomey/vim-tmux-navigator` | Seamless pane navigation between Vim and tmux. |
| `tpope/vim-commentary` | Comment and uncomment code with motions. |
| `907th/vim-auto-save` | Automatic saving. |
| `puremourning/vimspector` | Debugger UI and debugger controls. |
| `mhinz/vim-startify` | Start screen and recent files. |
| `Xuyuanp/nerdtree-git-plugin` | Git status inside NERDTree. |
| `airblade/vim-gitgutter` | Git diff signs in the gutter. |
| `tiagofumo/vim-nerdtree-syntax-highlight` | NERDTree filetype coloring. |
| `mattn/emmet-vim` | Emmet expansion for HTML/CSS workflows. |
| `HerringtonDarkholme/yats.vim` | TypeScript syntax. |
| `prettier/vim-prettier` | Prettier formatting integration. |
| `morhetz/gruvbox` | Gruvbox colorscheme. |

### CoC Extensions

| Extension | Purpose |
| --- | --- |
| `coc-snippets` | Snippet support. |
| `coc-pairs` | Automatic pair insertion. |
| `coc-html` | HTML language support. |
| `coc-css` | CSS language support. |
| `coc-tsserver` | JavaScript and TypeScript language server. |
| `coc-eslint` | ESLint diagnostics and fixes. |
| `coc-prettier` | Prettier integration through CoC. |
| `coc-json` | JSON language support. |
| `coc-clangd` | C/C++ language server. |
| `coc-sh` | Shell language support. |
| `coc-markdownlint` | Markdown linting. |

## Shortcuts

Source means:

- `builtin`: the shortcut is a default Vim/Neovim behavior.
- plugin name: the shortcut is provided by that plugin.
- `init.vim:<line>`: the shortcut is created in this config.

### Core Editing

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Insert | `jk` | Leave Insert mode. | `init.vim:51` |
| Insert | `kj` | Leave Insert mode. | `init.vim:52` |
| Normal/Visual/Operator | `j` | Move down by visual screen line when no count is given. | `init.vim:55` |
| Normal/Visual/Operator | `k` | Move up by visual screen line when no count is given. | `init.vim:56` |
| Normal | `,<space>` | Clear search highlight. | `init.vim:59` |
| Normal | `,q` | Quit current window. | `init.vim:62` |
| Normal | `,w` | Write current buffer. | `init.vim:63` |
| Normal | `,x` | Write and quit. | `init.vim:64` |
| Normal | `gf` | Open file under cursor in a vertical split. | `init.vim:91` |
| Normal | `yf` | Copy current file path to clipboard. | `init.vim:94` |
| Normal | `yd` | Copy current file directory to clipboard. | `init.vim:96` |
| Visual | `a(` | Wrap selection in parentheses. | `init.vim:109` |
| Visual | `a[` | Wrap selection in brackets. | `init.vim:110` |
| Visual | `a{` | Wrap selection in braces. | `init.vim:111` |
| Visual | `a<` | Wrap selection in angle brackets. | `init.vim:112` |
| Visual | `a"` | Wrap selection in double quotes. | `init.vim:113` |
| Visual | `a'` | Wrap selection in single quotes. | `init.vim:114` |
| Visual | `` a` `` | Wrap selection in backticks. | `init.vim:115` |
| Normal | `,O` | Insert blank line above without staying in Insert mode. | `init.vim:118` |
| Normal | `,o` | Insert blank line below without staying in Insert mode. | `init.vim:119` |
| Normal | `u` | Undo. | `builtin` |
| Normal | `<C-r>` | Redo. | `builtin` |
| Normal | `yy` | Yank current line. | `builtin` |
| Normal | `dd` | Delete current line. | `builtin` |
| Normal | `p` | Paste after cursor. | `builtin` |
| Normal | `P` | Paste before cursor. | `builtin` |
| Normal | `/` | Search forward. | `builtin` |
| Normal | `?` | Search backward. | `builtin` |
| Normal | `n` | Next search result. | `builtin` |
| Normal | `N` | Previous search result. | `builtin` |
| Normal | `*` | Search word under cursor forward. | `builtin` |
| Normal | `#` | Search word under cursor backward. | `builtin` |

### Tabs, Splits, And Windows

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Normal/Visual/Operator | `,tn` | Open a new tab. | `init.vim:66` |
| Normal/Visual/Operator | `,to` | Keep only the current tab. | `init.vim:67` |
| Normal/Visual/Operator | `,e` | Edit a file from the current file's directory in a new tab. | `init.vim:70` |
| Normal/Visual/Operator | `,v` | Open a vertical split from the current file's directory. | `init.vim:71` |
| Normal/Visual/Operator | `,s` | Open a horizontal split from the current file's directory. | `init.vim:72` |
| Normal/Visual/Operator | `,1` ... `,9` | Jump to tab 1 through 9. | `init.vim:75` |
| Normal | `,0` | Jump to the last active tab. | `init.vim:87` |
| Visual | `,0` | Jump to the last active tab. | `init.vim:88` |
| Normal | `,<C-h>` | Move current split to the far left. | `init.vim:122` |
| Normal | `,<C-j>` | Move current split to the bottom. | `init.vim:123` |
| Normal | `,<C-k>` | Move current split to the top. | `init.vim:124` |
| Normal | `,<C-l>` | Move current split to the far right. | `init.vim:125` |
| Normal | `<C-h>` | Move to the split on the left. | `init.vim:128` |
| Normal | `<C-j>` | Move to the split below. | `init.vim:129` |
| Normal | `<C-k>` | Move to the split above. | `init.vim:130` |
| Normal | `<C-l>` | Move to the split on the right. | `init.vim:131` |
| Normal | `<C-w>h` | Move to the split on the left. | `builtin` |
| Normal | `<C-w>j` | Move to the split below. | `builtin` |
| Normal | `<C-w>k` | Move to the split above. | `builtin` |
| Normal | `<C-w>l` | Move to the split on the right. | `builtin` |
| Normal | `<C-w>v` | Create vertical split. | `builtin` |
| Normal | `<C-w>s` | Create horizontal split. | `builtin` |
| Normal | `gt` | Go to next tab. | `builtin` |
| Normal | `gT` | Go to previous tab. | `builtin` |

### Files And Project Navigation

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Normal | `<C-n>` | Toggle NERDTree. | `init.vim:165` |
| Normal | `<C-p>` | Open CtrlP file finder. | `ctrlp.vim` |
| Normal | `<C-h>` | Navigate left between Vim/tmux panes when tmux integration is active. | `vim-tmux-navigator` and `init.vim:128` |
| Normal | `<C-j>` | Navigate down between Vim/tmux panes when tmux integration is active. | `vim-tmux-navigator` and `init.vim:129` |
| Normal | `<C-k>` | Navigate up between Vim/tmux panes when tmux integration is active. | `vim-tmux-navigator` and `init.vim:130` |
| Normal | `<C-l>` | Navigate right between Vim/tmux panes when tmux integration is active. | `vim-tmux-navigator` and `init.vim:131` |

### Completion, LSP, And CoC

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Insert | `<Tab>` | Select next completion item, insert a tab after whitespace, or trigger completion. | `init.vim:254` |
| Insert | `<S-Tab>` | Select previous completion item. | `init.vim:258` |
| Insert | `<C-Space>` | Trigger completion. | `init.vim:270` |
| Insert | `<CR>` | Confirm completion when menu is visible; otherwise insert a newline. | `init.vim:274` |
| Normal | `[g` | Go to previous diagnostic. | `init.vim:279` |
| Normal | `]g` | Go to next diagnostic. | `init.vim:280` |
| Normal | `gd` | Go to definition. | `init.vim:283` |
| Normal | `gy` | Go to type definition. | `init.vim:284` |
| Normal | `gi` | Go to implementation. | `init.vim:285` |
| Normal | `gr` | Go to references. | `init.vim:286` |
| Normal | `K` | Show help for Vim/help buffers, otherwise show CoC hover docs. | `init.vim:289` |
| Normal | `<F2>` | Rename symbol. | `init.vim:303` |
| Normal/Visual/Operator | `,f` | Format with CoC. | `init.vim:306` |
| Visual | `,a` | Code action for selected region. | `init.vim:317` |
| Normal | `,a` | Code action for selected region. | `init.vim:318` |
| Normal | `,ac` | Code action for current line. | `init.vim:321` |
| Normal | `,qf` | Apply quick fix for current line. | `init.vim:323` |
| Visual | `if` | Inner function text object. | `init.vim:326` |
| Visual | `af` | Around function text object. | `init.vim:327` |
| Operator-pending | `if` | Inner function text object. | `init.vim:328` |
| Operator-pending | `af` | Around function text object. | `init.vim:329` |
| Normal | `<C-d>` | Start range selection. | `init.vim:332` |
| Visual | `<C-d>` | Expand range selection. | `init.vim:333` |
| Normal | `<space>a` | Open CoC diagnostics list. | `init.vim:349` |
| Normal | `<space>e` | Open CoC extensions list. | `init.vim:351` |
| Normal | `<space>c` | Open CoC commands list. | `init.vim:353` |
| Normal | `<space>o` | Open CoC outline. | `init.vim:355` |
| Normal | `<space>s` | Search workspace symbols. | `init.vim:357` |
| Normal | `<space>j` | Apply default action for next CoC list item. | `init.vim:359` |
| Normal | `<space>k` | Apply default action for previous CoC list item. | `init.vim:361` |
| Normal | `<space>p` | Resume the latest CoC list. | `init.vim:363` |

### Formatting, Comments, And Web Editing

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Command | `:Prettier` | Format current file through `CocCommand prettier.formatFile`. | `init.vim:212` |
| Command | `:Format` | Format current buffer through CoC. | `init.vim:336` |
| Command | `:Fold` | Fold current buffer through CoC. | `init.vim:339` |
| Command | `:OR` | Organize imports through CoC. | `init.vim:342` |
| Normal/Visual | `gc` + motion | Comment or uncomment using a motion or selection. | `vim-commentary` |
| Normal | `gcc` | Comment or uncomment current line. | `vim-commentary` |
| Insert | `<C-y>,` | Expand Emmet abbreviation. | `emmet-vim` |

### Debugging

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Normal | `,dl` | Launch Vimspector. | `init.vim:374` |
| Normal | `,dr` | Reset Vimspector. | `init.vim:375` |
| Normal | `,de` | Evaluate expression in Vimspector. | `init.vim:376` |
| Normal | `,dw` | Add Vimspector watch expression. | `init.vim:377` |
| Normal | `,do` | Show Vimspector output. | `init.vim:378` |
| Normal | `,di` | Evaluate expression under cursor in a Vimspector balloon. | `init.vim:379` |
| Visual | `,di` | Evaluate selected expression in a Vimspector balloon. | `init.vim:380` |
| Normal | `<F5>` | Start or continue debugging. | `vimspector` |
| Normal | `<F3>` | Stop debugging. | `vimspector` |
| Normal | `<F4>` | Restart debugging. | `vimspector` |
| Normal | `<F6>` | Pause debugging. | `vimspector` |
| Normal | `<F9>` | Toggle breakpoint. | `vimspector` |
| Normal | `,<F9>` | Toggle conditional breakpoint. | `vimspector` |
| Normal | `<F8>` | Add function breakpoint. | `vimspector` |
| Normal | `<F10>` | Step over. | `vimspector` |
| Normal | `<F11>` | Step into. | `vimspector` |
| Normal | `<F12>` | Step out. | `vimspector` |

### Language-Specific Run Shortcuts

| Mode | Shortcut | Action | Source |
| --- | --- | --- | --- |
| Normal/Visual/Operator | `<F7>` in C++ files | Save, compile with `g++`, and run `./a.out`. | `init.vim:388` |
| Insert | `<F7>` in C++ files | Save, compile with `g++`, and run `./a.out`. | `init.vim:389` |
| Normal/Visual/Operator | `<F7>` in C files | Save, compile with `gcc`, and run `./a.out`. | `init.vim:390` |
| Insert | `<F7>` in C files | Save, compile with `gcc`, and run `./a.out`. | `init.vim:391` |
| Normal/Visual/Operator | `<F7>` in Python files | Save and run with `python3`. | `init.vim:405` |
| Insert | `<F7>` in Python files | Save and run with `python3`. | `init.vim:406` |
