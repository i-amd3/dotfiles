if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim' , {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'thinca/vim-quickrun'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'tpope/vim-fugitive'

call neobundle#end()

filetype plugin indent on


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
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab

set clipboard+=unnamed
set clipboard=unnamed

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
set statusline=%<%F\ %m%r%h%w\%=%l,%v\ %p%%\ %L\ 
set statusline+=%{b:charCounterCount}\ 
set statusline+=%{Date()}

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

nnoremap <CR> a<CR><ESC>
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

highlight DiffAdd    gui=none guifg=green guibg=darkgreen
highlight DiffDelete gui=none guifg=green guibg=darkred
highlight DiffChange gui=none guifg=green guibg=darkblue
highlight DiffText   gui=none guifg=green guibg=blue

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
nnoremap wsp :sp<CR>
nnoremap wvsn :vs enew<CR>
nnoremap wspn :sp enew<CR>

nnoremap w= <C-w>=
nnoremap w> <C-w>>
nnoremap w< <C-w><
nnoremap w+ <C-w>+
nnoremap w- <C-w>-

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <F2> :tabe $MYVIMRC<CR>

set nobackup
set noswapfile

let $PATH = $PATH . ':' . expand('~/Library/Haskell/bin/')
let $PATH = $PATH . ':' . expand('~/bin/')

nnoremap ,gs :Gstatus<CR>
nnoremap ,ga :Gwrite<CR>
nnoremap ,gr :Gread<CR>
nnoremap ,gm :Gremove<CR>
nnoremap ,gd :Gdiff<CR>
nnoremap ,gc :Gcommit<CR>

command! Hsrun :QuickRun haskell
let g:quickrun_config = {
      \ "_" : {
      \   "runner" : "vimproc",
      \   "runner/vimproc/updatetime" : 60
      \ },
      \}
let g:quickrun_config.haskell = {
  \ 'outputter/buffer/split' : ":botright",
  \ 'outputter/buffer/clise_on_empty' : 1
  \}
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

command! -nargs=? FiveTenets call Fivetenets(<args>)
nnoremap ,ft :FiveTenets<CR>

function! Fivetenets(...)
  let ft = ["Give a good greeting!"
        \,"Try not to give up!"
        \,"Sleep well, eat well!"
        \,"If you're troubled, talk to someone!"
        \,"You're likely to succeed if you try!"]
  let rnd = system("getRnd 5")
  let n = rnd - 1
  let t = ft[n]
  echo "Hero Club Five Tenets!!"
  echo t
endfunction

augroup HeroClubMessage
    autocmd!
    autocmd BufNewFile * call Fivetenets()
augroup END

inoremap <C-f> <PageDown>
inoremap <C-b> <PageUp>

nnoremap <F3> :VimFiler<CR>
nnoremap <D-e> :VimFilerExplorer -split -winwidth=30 -toggle -no-quit<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <F4> :VimShell<CR>
nnoremap ,vs :VimShellPop<CR>

