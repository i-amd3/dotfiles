" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-haskellimport'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tpope/vim-fugitive'

" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


colorscheme koehler
syntax on

set encoding=utf8
set fileencoding=utf8

set nowrap

set hlsearch
set ignorecase
set smartcase

set autoindent

set ruler
set number
set list
set wildmenu

set cursorline
set cursorcolumn
set listchars=tab:▸.,trail:_,eol:¬,extends:>,precedes:<,nbsp:%

set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab

set clipboard+=unnamed
set clipboard=unnamed

set nobackup

imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

set guifont=Ricty\ Discord:h16
set guifontwide=Ricty\ Discord:h16

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.hs set filetype=haskell

function! Date()
  return strftime("%m/%d/%Y %H:%M")
endfunction

set laststatus=2
set statusline=[PATH=%<%F]\ %m%r%h%w\%=[POS=%l,%v][%p%%]\ [LEN=%L]\ 
set statusline+=[NumOfChara=%{b:charCounterCount}]\ 
set statusline+=[TIME=%{Date()}]

function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

augroup CharCounter
    autocmd!
    autocmd BufNew,BufEnter,BufWrite,InsertLeave * call <SID>Update()
augroup END

function! s:Update()
    let b:charCounterCount = s:CharCount()
endfunction

function! s:CharCount()
    let l:result = 0
    for l:linenum in range(0, line('$'))
        let l:line = getline(l:linenum)
        let l:result += strlen(substitute(l:line, ".", "x", "g"))
    endfor
    return l:result
endfunction

augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END


