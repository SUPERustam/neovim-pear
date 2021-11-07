call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug '907th/vim-auto-save'
Plug 'puremourning/vimspector'

Plug 'mhinz/vim-startify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
" Plug 'prettier/vim-pettier', { 'do': 'yarn install' }

Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set mouse=a " enable mouse
set encoding=utf-8
set relativenumber
set number
set clipboard=unnamedplus  " using system clipboard filetype plugin on
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

syntax enable
colorscheme gruvbox

" turn off search highlight
nnoremap <silent> ,<space> :nohlsearch<CR>

nmap ,x :x<CR>

" map ,tn :tabnew<cr>
" map ,to :tabonly<cr>
" map ,tc :tabclose<cr>
" map ,tm :tabmove 

map ,e :tabedit <C-r>=expand("%:p:h")<CR>/

" Go to tab by number
noremap ,1 1gt
noremap ,2 2gt
noremap ,3 3gt
noremap ,4 4gt
noremap ,5 5gt
noremap ,6 6gt
noremap ,7 7gt
noremap ,8 8gt
noremap ,9 9gt

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> ,0 :exe "tabn ".g:lasttab<CR>
vnoremap <silent> ,0 :exe "tabn ".g:lasttab<CR>

" open file in a text by placing text and gf
nnoremap gf :vert winc f<CR>

" copies filepath to clipboard by pressing yf
nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
nnoremap <silent> yd :let @+=expand('%:p:h')<CR>

" open new split panes to right and below
set splitright
set splitbelow

" move line or visually selected block - Ctrl+Shift+j/k
nnoremap <silent> <C-Down> :m .+1<CR>==
nnoremap <silent> <C-Up> :m .-2<CR>==
inoremap <silent> <C-Down> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-Up> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-Down> :m '>+1<CR>gv=gv
vnoremap <silent> <C-Up> :m '<-2<CR>gv=gv

" Surround lines in parenthesis/brackets etc. in visual mode
vnoremap <silent> a( <esc>`>a)<esc>`<i(<esc>
vnoremap <silent> a[ <esc>`>a]<esc>`<i[<esc>
vnoremap <silent> a{ <esc>`>a}<esc>`<i{<esc>
vnoremap <silent> a" <esc>`>a"<esc>`<i"<esc>
vnoremap <silent> a' <esc>`>a'<esc>`<i'<esc>
vnoremap <silent> a` <esc>`>a`<esc>`<i`<esc>

" move split panes to left/bottom/top/right
nnoremap <silent> <A-h> <C-W>H
nnoremap <silent> <A-j> <C-W>J
nnoremap <silent> <A-k> <C-W>K
nnoremap <silent> <A-l> <C-W>L

" move between panes to left/bottom/top/right
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l


" Plugin: NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" open NERDTree automatically
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         

" let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()


" Plugin: vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync


" Plugin: ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" Plugin: coc.nvim
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-clangd',
  \ 'coc-pyright'
  \ ]

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
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
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
nnoremap <silent> <space> p  :<C-u>CocListResume<CR>


" Plugin: vim-auto-save
autocmd VimEnter * AutoSaveToggle
let g:auto_save_silent = 1  " do not display the auto-save notification

" Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | 

autocmd FileType cpp map <buffer> <F5> :w<CR>:exec '!g++' shellescape(@%, 1) '-o .cpp.out && ./.cpp.out'<CR>
autocmd Filetype python call SetPythonOptions()

function SetPythonOptions()
  set colorcolumn=79
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4

  map <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
  imap <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
endfunction
