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
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/unite-haddock'
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
set listchars=tab:?.,trail:_,eol:￢,extends:>,precedes:<,nbsp:%

set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab

set clipboard+=unnamed
set clipboard=unnamed

set nobackup

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>

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

nnoremap <CR> i<CR><ESC>
nnoremap <SPACE> i<SPACE><RIGHT><ESC>
nnoremap <TAB> i<TAB><RIGHT><ESC>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-h> <LEFT>
inoremap <C-l> <RIGHT>

nnoremap 0 $
nnoremap 1 0

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

highlight DiffAdd    gui=bold guifg=green ctermbg=darkgreen
highlight DiffDelete gui=bold guifg=green ctermbg=darkred
highlight DiffChange gui=bold guifg=green ctermbg=darkblue
highlight DiffText   gui=bold guifg=green ctermbg=blue

let g:git_diff_normal="git-diff-normal"
let g:git_diff_normal_opts=["--diff-algorithm=histogram"]

function! GitDiffNormal()
  let args=[g:git_diff_normal]
  if &diffopt =~ "iwhite"
    call add(args, "--ignore-all-space")
  endif
  call extend(args, g:git_diff_normal_opts)
  call extend(args, [v:fname_in, v:fname_new])
  let cmd="!" . join(args, " ") . ">" . v:fname_out
  silent execute cmd
  redraw!
endfunction

if executable(g:git_diff_normal)
  call system(g:git_diff_normal)
  if v:shell_error == 0
    set diffexpr=GitDiffNormal()
  endif
endif

nnoremap <S-a> <S-i>
nnoremap <S-i> <S-a>

nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wh <C-w>h
nnoremap wl <C-w>l

nnoremap wJ <C-w>J
nnoremap wK <C-w>K
nnoremap wH <C-w>H
nnoremap wL <C-w>L

nnoremap wvs :vs<CR>
nnoremap wsp :vp<CR>
nnoremap wvsn :vs enew<CR>
nnoremap wspn :vp enew<CR>

nnoremap w= <C-w>=
nnoremap w> <C-w>>
nnoremap w< <C-w><
nnoremap w+ <C-w>+
nnoremap w- <C-w>-

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <F2> :tabe $MYVIMRC<CR>
