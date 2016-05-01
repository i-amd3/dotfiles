set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif

let $PATH = $PATH . ':' . expand('$HOME/.local/bin/')

"----------------------------------------
" zplug
"---------------------------------------
call plug#begin('$HOME/.vim/plugged')

  " Keyword Auto-completion
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }


  "----------------------------------
  " util
  "---------------------------------
  " Repeatable f, F, t and T
  Plug 'rhysd/clever-f.vim'

  " Delete/change/add parentheses
  Plug 'tpope/vim-surround'

  " Delete/add comment
  Plug 'tpope/vim-commentary'


  "----------------------------------
  " develop
  "---------------------------------
  " Asynchronous :make
  Plug 'benekastah/neomake'

  " Snippet engine
  Plug 'SirVer/ultisnips'

  " Contains snippets files
  Plug 'honza/vim-snippets'

  " View the tags of the current file
  Plug 'majutsushi/tagbar'

  "----------------------------------
  " haskell
  "---------------------------------
  " Syntax Highlighting and Indentation
  Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

  " ghc-mod plugin
  Plug 'neovimhaskell/neovim-ghcmod', { 'for': 'haskell' }

  " Auto-completion for haskell
  Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }

  " Hoogle plugin
  Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }

  " Add import
  Plug 'ujihisa/unite-haskellimport', { 'for': 'haskell' }


  "----------------------------------
  " purescript
  "---------------------------------
  " Syntax Highlighting and Indentation
  Plug 'raichoo/purescript-vim', { 'for': 'purescript' }

  " psc-ide plugin
  Plug 'FrigoEU/psc-ide-vim', { 'for': 'purescript' }

call plug#end()


"----------------------------------------
" Vim settings
"---------------------------------------
filetype on
filetype plugin indent on

colorscheme koehler
syntax on


" Filetype
autocmd BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd BufRead,BufNewFile,BufWrite *.hs set filetype=haskell
autocmd BufRead,BufNewFile,BufWrite *.purs set filetype=purescript

" Doesn't wrap
set nowrap

" the case of normal letters is ignore
set ignorecase

" When start a new line with <CR> in insert mode or command
set autoindent

" show the line and column number
set ruler

" show the line number
set number

" Show tabs
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" Command-line completion
set wildmenu

" coloring cursor line and column
set cursorline
set cursorcolumn

" Insert space using <TAB>
set expandtab

" For shiftwidth
set smarttab

" Number of spaces that a <TAB>
set tabstop=2

" Number of spaces thas a insert indent
set shiftwidth=2
set softtabstop=2

set clipboard+=unnamed

" set guifont=Ricty\ Discord:h16
" set guifontwide=Ricty\ Discord:h16

" dispay status line
set laststatus=2

" Not create backup
set nobackup

" Not create swap
set noswapfile

" Not create viminfo
set viminfo=

" disable beeping
set visualbell t_vb=

" Set tags files
set tags=tags;/,codex.tags;/

"----------------------------------------
" Variable
"---------------------------------------
let mapleader = "\<Space>"

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Open window when error is found
let g:neomake_open_list = 2

" run cmd when filetype is haskell
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable makers when to use haskell
let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']

" Setting necoghc
let g:haskellmode_completion_ghc = 1
let g:necoghc_enable_detailed_browse = 1

" Setting tagbar
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

"Python support
"let g:python_host_prog = '/usr/local/bin'

"Python3 support
"let g:python3_host_prog = '/usr/local/bin'


"----------------------------------------
" Function
"---------------------------------------
autocmd BufWritePost *.hs Neomake
autocmd! QuickFixCmdPost *grep* cwindow

"----------------------------------------
" KeyMapping
"---------------------------------------
nnoremap <Space> <Nop>
nnoremap <DEL> <Nop>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

nnoremap l <Space>
nnoremap h <BS>
nnoremap j gj
nnoremap k gk

nnoremap <Leader>h <S-i>
nnoremap <Leader>l <S-a>

" nnoremap <Leader>wj <C-w>j
" nnoremap <Leader>wk <C-w>k
" nnoremap <Leader>wh <C-w>h
" nnoremap <Leader>wl <C-w>l

" nnoremap <Leader>wvs :vs<CR>
" nnoremap <Leader>wsp :sp<CR>

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <Leader>r :source $MYVIMRC<CR>

nnoremap <silent> <Leader>y yiw
nnoremap <silent> <Leader>d diw

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>

tnoremap <Esc> <C-\><C-n>

