set encoding=utf8
set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif


"----------------------------------------
" zplug
"---------------------------------------
call plug#begin('$HOME/.vim/plugged')

  " Keyword Auto-completion
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
  Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }

  " Auto-completion for haskell
  Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }

  " Hoogle plugin
  Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }

  " Add import
  Plug 'ujihisa/unite-haskellimport', { 'for': 'haskell' }

call plug#end()


"----------------------------------------
" Vim settings
"---------------------------------------
filetype plugin indent on

colorscheme koehler
syntax on


" **TODO Add comment**
set nowrap

set ignorecase
set smartcase

set autoindent

set ruler
set number
set list
set wildmenu

set cursorline
set cursorcolumn
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab

set clipboard+=unnamed

" set guifont=Ricty\ Discord:h16
" set guifontwide=Ricty\ Discord:h16

set laststatus=2

set nobackup
set noswapfile

set viminfo+=h

set visualbell t_vb=


"----------------------------------------
" Variable
"---------------------------------------
" Use deoplete.
let g:deoplete#enable_at_startup = 1

"Python support
"let g:python_host_prog = '/usr/local/bin'

"Python3 support
"let g:python3_host_prog = '/usr/local/bin'


"----------------------------------------
" Autocmd
"---------------------------------------
autocmd BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd BufRead,BufNewFile,BufWrite *.hs set filetype=haskell
autocmd QuickFixCmdPost *grep* cwindow


"----------------------------------------
" KeyMapping
"---------------------------------------


"----------------------------------------
" Function
"---------------------------------------
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

