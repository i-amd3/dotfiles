set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif

augroup _vimrc
  autocmd!
augroup END

"----------------------------------------
" zplug
"---------------------------------------
call plug#begin('$HOME/.vim/plugged')

  "----------------------------------
  " util
  "---------------------------------
  " Keyword Auto-completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Repeatable f, F, t and T
  Plug 'rhysd/clever-f.vim'

  " Delete/change/add parentheses
  Plug 'tpope/vim-surround'

  " NOTE: vim-airline
  Plug 'itchyny/lightline.vim'

  " Text Browser
  Plug 'yuratomo/w3m.vim'

  " TODO
  Plug 'i-amd3/BlockDiff'

  " Directory Viewer
  Plug 'scrooloose/nerdtree'

  " Command line fuzzy finder
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf.vim'

  "----------------------------------
  " TODO Haskell
  "---------------------------------

  "----------------------------------
  " TODO Perl
  "---------------------------------

  "----------------------------------
  " TODO python
  "---------------------------------

  "----------------------------------
  " HTML or MD
  "---------------------------------
  " automatic table formatter
  Plug 'dhruvasagar/vim-table-mode', { 'for': [ 'html', 'md' ] }

  "----------------------------------
  " develop
  "---------------------------------
  " Snippet engine | Contains snippets files
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " View the tags of the current file
  Plug 'majutsushi/tagbar'

  " Asynchronous Lint. See :ALEinfo if it isn't running
  Plug 'w0rp/ale', { 'for': [ 'perl', 'python', 'haskell' ] }

  " Delete/add comment
  Plug 'tpope/vim-commentary'

  " LSP client
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

  " git client
  Plug 'lambdalisue/gina.vim'

call plug#end()

"----------------------------------------
" Vim settings
"---------------------------------------
filetype plugin indent on

colorscheme koehler
syntax on

" python provider
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Filetype
autocmd _vimrc BufReadPost,BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd _vimrc BufReadPost,BufRead,BufNewFile,BufWrite *.hs set filetype=haskell

set backup                           " create backup
set backupdir=$HOME/.vim/backup      " backupdir
set swapfile                         " create swap
set backupdir=$HOME/.vim/swap        " swapdir
set undofile                         " create undo
set undodir=$HOME/.vim/undo          " undodir
set hidden
set nowrap                    " Doesn't wrap
set ignorecase                " the case of normal letters is ignore
set autoindent                " When start a new line with \<CR\> in insert mode or command
set ruler                     " show the line and column number
set number                    " show the line number
set wildmenu                  " Command-line completion
set expandtab                 " Insert space using <TAB>
set smarttab                  " For shiftwidth
set tabstop=2                 " Number of spaces that a <TAB>
set clipboard+=unnamed        " TODO
set laststatus=2              " dispay status line
set viminfo+=h                " Not create viminfo
set visualbell t_vb=          " disable beeping
set tags=tags;/,codex.tags;/  " Set tags files
set ambiwidth=double          " TODO
set cursorline                " coloring cursor line and column

" Show tabs
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" Number of spaces thas a insert indent
set shiftwidth=2
set softtabstop=2

"----------------------------------------
" Variable
"---------------------------------------
let mapleader = "\<Space>"

" NERDTree
let g:NERDTreeWinPos = "right"

" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" TODO
let g:w3m#command = '/usr/local/Cellar/w3m/0.5.3_5/bin/w3m'

" TODO
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" -- Tagbar Settings
" --
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

" -- fzf Settings
" --
let g:fzf_layout = { 'up': '~30%' }
let g:fzf_buffers_jump = 1


" -- ale Settings
" --
let g:ale_open_list = 1

" language servers Settings
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ 'python': ['pyls']
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

"----------------------------------------
" Function
"---------------------------------------
" TODO
autocmd _vimrc QuickFixCmdPost *grep* cwindow

" TODO
function! Date()
  return strftime("%m/%d/%Y %H:%M")
endfunction

" TODO
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

" TODO
if has('syntax')
    autocmd _vimrc ColorScheme       * call ZenkakuSpace()
    autocmd _vimrc VimEnter,WinEnter * match ZenkakuSpace /　/
    call ZenkakuSpace()
endif

" TODO Rewrite
" command! -nargs=? FiveTenets call Fivetenets(<args>)

"----------------------------------------
" KeyMapping
"---------------------------------------
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
nnoremap <DEL> <Nop>
vnoremap <DEL> <Nop>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
inoremap <Leader>w <Esc>:w<CR>i
inoremap <Leader>q <Esc>:q<CR>i

nnoremap l <Space>
nnoremap h <BS>
nnoremap j gj
nnoremap k gk

nnoremap <Leader><Leader> v

nnoremap <Leader>l $
nnoremap <Leader>h 0
vnoremap <Leader>l $
vnoremap <Leader>h 0

" TODO Rewrite
" nnoremap <Space>ft :FiveTenets<CR>

" TODO DELETE ?
" nnoremap <S-h> <S-i>
" nnoremap <S-l> <S-a>
" vnoremap <S-h> <S-i>
" vnoremap <S-l> <S-a>

nnoremap w <Nop>
nnoremap W <Nop>
vnoremap w <Nop>
vnoremap W <Nop>

nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wh <C-w>h
nnoremap wl <C-w>l

nnoremap WJ <C-w>J
nnoremap WK <C-w>K
nnoremap WH <C-w>H
nnoremap WL <C-w>L

nnoremap wvs :vs<CR>
nnoremap wsp :sp<CR>
nnoremap wvsn :vs enew<CR>
nnoremap wspn :sp enew<CR>

nnoremap ww <C-w>=
nnoremap w. <C-w>>
nnoremap w, <C-w><
nnoremap w; <C-w>+
nnoremap w- <C-w>-

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <Leader>r :source $MYVIMRC<CR>

nnoremap <silent> <Leader>ay :%yank<CR>
nnoremap <silent> <Leader>ad :%delete<CR>
nnoremap <silent> <Leader>y yiw
nnoremap <silent> <Leader>d diw
nnoremap <silent> <Leader>i :set invrelativenumber<CR>

inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-h> <LEFT>
inoremap <C-l> <RIGHT>
inoremap {{ {}<LEFT>
inoremap [[ []<LEFT>
inoremap (( ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap << <><LEFT>

inoremap }} {}<LEFT>
inoremap ]] []<LEFT>
inoremap )) ()<LEFT>
inoremap >> <><LEFT>

inoremap <C-f> <PageDown>
inoremap <C-b> <PageUp>

nnoremap <Leader>g :vim<Space>"<C-r><C-w>"<Space><C-r>=getcwd()<CR>/**

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>

" --- Neovim
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F2> :TagbarToggle<CR>

nnoremap <Leader>tj :exe("tjump ".expand('<cword>'))<CR>
nnoremap <Leader>tv :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <Leader>ts :split<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <Leader>tb :pop<CR>

nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <leader>fm :Maps<CR>

nmap <silent> <Leader>ek <Plug>(ale_previous_wrap)
nmap <silent> <Leader>ej <Plug>(ale_next_wrap)
