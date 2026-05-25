call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main', 'do': ':TSUpdate'}
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'nvim-tree/nvim-tree.lua'
function! BuildFFF(info)
  lua require("fff.download").download_or_build_binary()
endfunction

Plug 'dmtrKovalenko/fff.nvim', { 'do': function('BuildFFF') }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug '907th/vim-auto-save'

Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'stevearc/conform.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'linux-cultist/venv-selector.nvim'
Plug 'nosduco/remote-sshfs.nvim'

" HTML, CSS and JavaScript
Plug 'mattn/emmet-vim'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

" Design
Plug 'morhetz/gruvbox'
call plug#end()

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:python3_host_prog = '/opt/homebrew/Caskroom/miniforge/base/bin/python'

" map leader to comma
let mapleader = "," 

" using system clipboard filetype plugin on
" map ,clip :set clipboard=unnamedplus<CR>
set clipboard=unnamedplus

set mouse=a " enable mouse
set encoding=utf8
set relativenumber
set number
set cursorline
set noswapfile            " disable creating swap file
set backupdir=~/.cache/nvim " Directory to store backup files.

set smarttab
set smartindent
set softtabstop=2
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab

" fast exit from Insert mode 
inoremap jk <ESC>
inoremap kj <ESC>

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" turn off search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" exit from neovim with different modes
nmap <silent> <leader>q :q<CR>
nmap <silent> <leader>w :w<CR>
nmap <silent> <leader>x :x<CR> 

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
" map <leader>tm :tabmove 

map <leader>e :tabedit <C-r>=expand("%:p:h")<CR>/
map <leader>v :vsplit <C-r>=expand("%:p:h")<CR>/
map <leader>s :split <C-r>=expand("%:p:h")<CR>/

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <leader>0 :exe "tabn ".g:lasttab<CR>
vnoremap <silent> <leader>0 :exe "tabn ".g:lasttab<CR>

" open file in a text by placing text and gf
nnoremap gf :vert winc f<CR>

" copies filepath to clipboard by pressing yf
nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
nnoremap <silent> yd :let @+=expand('%:p:h')<CR>

" open new split panes to right and below
set splitright
set splitbelow

" move line or visually selected block
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
" portable fallbacks for terminals that do not send Alt keys distinctly
nnoremap <silent> <leader>j :m .+1<CR>==
nnoremap <silent> <leader>k :m .-2<CR>==
vnoremap <silent> <leader>j :m '>+1<CR>gv=gv
vnoremap <silent> <leader>k :m '<-2<CR>gv=gv

" Surround lines in parenthesis/brackets etc. in visual mode
vnoremap <silent> a( <esc>`>a)<esc>`<i(<esc>
vnoremap <silent> a[ <esc>`>a]<esc>`<i[<esc>
vnoremap <silent> a{ <esc>`>a}<esc>`<i{<esc>
vnoremap <silent> a< <esc>`>a><esc>`<i<<esc>
vnoremap <silent> a" <esc>`>a"<esc>`<i"<esc>
vnoremap <silent> a' <esc>`>a'<esc>`<i'<esc>
vnoremap <silent> a` <esc>`>a`<esc>`<i`<esc>

" Add blank lines above/below line
nnoremap <silent><leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent><leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>

" move split panes to left/bottom/top/right
nnoremap <silent> ,H <C-W>H
nnoremap <silent> ,J <C-W>J
nnoremap <silent> ,K <C-W>K
nnoremap <silent> ,L <C-W>L

" move between panes to left/bottom/top/right
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l


" Plugin: gruvbox
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax enable
let g:gruvbox_italic=1
let g:gruvbox_transparent_bg=1

colorscheme gruvbox
" day/night theme
if strftime("%H") <= 6 || strftime("%H") >= 19 
  set background=dark
else
  set background=light 
endif


" Plugin: modern Lua tools
lua << EOF
local ok_tree, nvim_tree = pcall(require, "nvim-tree")
if ok_tree then
  nvim_tree.setup({
    git = { enable = true },
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = { show = { git = true, file = true, folder = true, folder_arrow = true } },
    },
    update_focused_file = { enable = true, update_root = false },
  })
end

local function safe_require(name)
  local ok, mod = pcall(require, name)
  return ok and mod or nil
end

local treesitter_languages = { "markdown", "markdown_inline", "html", "yaml" }
local treesitter = safe_require("nvim-treesitter")
if treesitter and treesitter.install then
  treesitter.setup({})
  local installed_languages = treesitter.get_installed()
  local missing_languages = {}
  for _, language in ipairs(treesitter_languages) do
    if not vim.tbl_contains(installed_languages, language) then
      table.insert(missing_languages, language)
    end
  end
  if #missing_languages > 0 then
    treesitter.install(missing_languages)
  end
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "html", "yaml" },
    callback = function()
      vim.treesitter.start()
    end,
  })
else
  local treesitter_configs = safe_require("nvim-treesitter.configs")
  if treesitter_configs then
    treesitter_configs.setup({
      ensure_installed = treesitter_languages,
      highlight = { enable = true },
    })
  end
end

local render_markdown = safe_require("render-markdown")
if render_markdown then
  render_markdown.setup({})
  vim.keymap.set("n", "<leader>m", "<cmd>RenderMarkdown toggle<CR>", {
    desc = "Toggle Markdown rendering",
    silent = true,
  })
end

local fff = safe_require("fff")
if fff then
  fff.setup({
    lazy_sync = true,
    prompt_vim_mode = true,
  })
end

local conform = safe_require("conform")
if conform then
  conform.setup({
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      less = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      graphql = { "prettierd", "prettier", stop_after_first = true },
      toml = { "taplo" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
  })
end

local function native_lsp_on_attach(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
end

if vim.lsp and vim.lsp.config then
  vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    on_attach = native_lsp_on_attach,
  })
  vim.lsp.enable("ruff")

  vim.lsp.config("ty", {
    cmd = { "ty", "server" },
    filetypes = { "python" },
    root_markers = { "ty.toml", "pyproject.toml", ".git" },
    on_attach = native_lsp_on_attach,
  })
  vim.lsp.enable("ty")
else
  local lspconfig = safe_require("lspconfig")
  if lspconfig and lspconfig.ruff then
    lspconfig.ruff.setup({
      cmd = { "ruff", "server" },
      filetypes = { "python" },
      on_attach = native_lsp_on_attach,
    })
  end
end

local ok_venv, venv_selector = pcall(require, "venv-selector")
if ok_venv then
  local fd_binary_name = nil
  if vim.fn.executable("fd") == 1 then
    fd_binary_name = "fd"
  elseif vim.fn.executable("fdfind") == 1 then
    fd_binary_name = "fdfind"
  end

  if fd_binary_name then
    pcall(venv_selector.setup, {
      options = {
        activate_venv_in_terminal = true,
        fd_binary_name = fd_binary_name,
        set_environment_variables = true,
      },
    })
  end
end

local ok_remote, remote_sshfs = pcall(require, "remote-sshfs")
if ok_remote then
  pcall(remote_sshfs.setup, {
    connections = {
      ssh_configs = {
        vim.fn.expand("$HOME") .. "/.ssh/config",
        "/etc/ssh/ssh_config",
      },
      ssh_known_hosts = vim.fn.expand("$HOME") .. "/.ssh/known_hosts",
      sshfs_args = {
        "-o reconnect",
        "-o ConnectTimeout=5",
      },
    },
    mounts = {
      base_dir = vim.fn.expand("$HOME") .. "/.sshfs/",
      unmount_on_exit = true,
    },
    handlers = {
      on_connect = { change_dir = true },
      on_disconnect = { clean_mount_folders = false },
    },
    ui = {
      picker = "telescope",
      confirm = { connect = true, change_dir = false },
    },
  })

  pcall(function()
    require("telescope").load_extension("remote-sshfs")
  end)
end
EOF

" Plugin: nvim-tree
nnoremap <silent> <leader>n :NvimTreeToggle<CR>
nnoremap <silent> <leader>t :NvimTreeFocus<CR>
nnoremap <silent> <leader>b :wincmd p<CR>
nnoremap <silent> <leader>N :NvimTreeFindFile<CR>

" Plugin: fff.nvim
nnoremap <silent> <leader>p :lua require('fff').find_files()<CR>
nnoremap <silent> <leader>g :lua if require('fff').live_grep then require('fff').live_grep() else vim.notify('fff.nvim live_grep is unavailable in this installed version', vim.log.levels.WARN) end<CR>
nnoremap <silent> <leader>r :FFFScan<CR>
nnoremap <silent> <leader>s :lua if require('fff').live_grep then require('fff').live_grep({ query = vim.fn.expand('<cword>') }) else vim.notify('fff.nvim live_grep is unavailable in this installed version', vim.log.levels.WARN) end<CR>

" Plugin: venv-selector.nvim
nnoremap <silent> <leader>ve :VenvSelect<CR>

" Plugin: remote-sshfs.nvim
nnoremap <silent> <leader>rc :RemoteSSHFSConnect<CR>
nnoremap <silent> <leader>rd :RemoteSSHFSDisconnect<CR>
nnoremap <silent> <leader>rf :RemoteSSHFSFindFiles<CR>
nnoremap <silent> <leader>rg :RemoteSSHFSLiveGrep<CR>


" Plugin: coc.nvim
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-json', 
  \ 'coc-clangd', 
  \ 'coc-sh'
  \ ]

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Format file
nnoremap <silent> <leader>f :Format<CR>

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format lua require("conform").format({ async = false, timeout_ms = 3000, lsp_format = "never" })

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR lua require("conform").format({ formatters = { "ruff_organize_imports" }, async = false, timeout_ms = 3000 })

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Plugin: vim-auto-save
autocmd VimEnter * AutoSaveToggle
let g:auto_save_silent = 1  " do not display the auto-save notification


" Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | 

autocmd FileType cpp map <buffer> <F7> :w<CR>:exec '!g++' shellescape(@%, 1) && ./a.out<CR>
autocmd FileType cpp imap <buffer> <F7> :w<CR>:exec '!g++' shellescape(@%, 1) && ./a.out<CR>
autocmd FileType c map <buffer> <F7> :w<CR>:exec '!gcc' shellescape(@%, 1) && ./a.out<CR>
autocmd FileType c imap <buffer> <F7> :w<CR>:exec '!gcc' shellescape(@%, 1) && ./a.out<CR>
autocmd Filetype python call SetPythonOptions()
autocmd Filetype javascript call SetJSOptions()

function SetJSOptions()
  set colorcolumn=80
endfunction

function SetPythonOptions()
  set colorcolumn=79
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4

  map <buffer> <F7> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  imap <buffer> <F7> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
endfunction
