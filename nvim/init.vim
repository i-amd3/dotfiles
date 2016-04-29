set encoding=utf8
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


  "----------------------------------
  " haskell
  "---------------------------------
  " Syntax Highlighting and Indentation
  Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

  " ghc-mod plugin
  Plug 'neovimhaskell/neovim-ghcmod', { 'for': 'haskell' }
  " Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }

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


"----------------------------------------
" Variable
"---------------------------------------
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

" Enable neomake when to use haskell
let g:neomake_haskell_enabled_makers = ['hdevtool', 'hlint']

" Setting necoghc
let g:haskellmode_completion_ghc = 1
let g:necoghc_enable_detailed_browse = 1

"Python support
"let g:python_host_prog = '/usr/local/bin'

"Python3 support
"let g:python3_host_prog = '/usr/local/bin'


"----------------------------------------
" Autocmd
"---------------------------------------
" Filetype
autocmd! BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd! BufRead,BufNewFile,BufWrite *.hs set filetype=haskell
autocmd! BufRead,BufNewFile,BufWrite *.purs set filetype=purescript

autocmd! QuickFixCmdPost *grep* cwindow

" run cmd when filetype is haskell
autocmd! FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd! BufWritePost *.hs Neomake

"----------------------------------------
" KeyMapping
"---------------------------------------


"----------------------------------------
" Function
"---------------------------------------

