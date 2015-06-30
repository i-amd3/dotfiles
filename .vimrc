set encoding=utf8
set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif

filetype off
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
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-surround'

NeoBundle 'majutsushi/tagbar'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'mhinz/vim-startify'

call neobundle#end()

filetype plugin indent on

colorscheme koehler
syntax on

let $PATH = $PATH . ':' . expand('~/bin/')

let g:git_diff_normal="git-diff-normal"
let g:git_diff_normal_opts=["--diff-algorithm=histogram"]

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#use_vimproc = 1

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'filelen', 'date' ],
      \              [ 'syntastic', 'lineinfo' ], ['percent'],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'date': '%{Date()}',
      \   'filelen': '%{b:charCounterCount}',
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'lef': '', 'right': ''},
      \ 'subseparator': { 'left': '|', 'right': '|'},
      \ }

let g:vimfiler_ignore_pattern = '\%(\.git\|\.DS_Store\)$'

let g:startify_custom_header = map(split(system('date +"%m/%d/%Y %p %I:%M:%S"'), '\n'), '"   ". v:val') + ['','']

let g:startify_list_order = [
  \ ['   LRU:'],
  \ 'files',
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ]

let g:startify_bookmarks = [
  \ '$MYVIMRC',
  \ '~/.vim/after/ftplugin/haskell.vim',
  \ '~/.vim/colors/koehler.vim'
  \ ]

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

set guifont=Ricty\ Discord:h16
set guifontwide=Ricty\ Discord:h16

set laststatus=2

set nobackup
set noswapfile

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nnoremap <Space><Space> v

nnoremap <Space>l $
nnoremap <Space>h 0
vnoremap <Space>l $
vnoremap <Space>h 0

nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
inoremap <Space>w <Esc>:w<CR>i
inoremap <Space>q <Esc>:q<CR>i

nnoremap <F3> :tabe<CR>:VimFiler<CR>
nnoremap <D-e> :VimFilerExplorer -split -winwidth=30 -toggle -no-quit<CR>

nnoremap <F4> :tabe<CR>:VimShell<CR>
nnoremap <Space>vs :VimShellPop<CR><Esc><C-w>Ja

nnoremap <Space>ft :FiveTenets<CR>

nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>ga :Gwrite<CR>
nnoremap <Space>gr :Gread<CR>
nnoremap <Space>gm :Gremove<CR>
nnoremap <Space>gd :Gdiff<CR>
nnoremap <Space>gc :Gcommit<CR>

nnoremap <S-h> <S-i>
nnoremap <S-l> <S-a>
vnoremap <S-h> <S-i>
vnoremap <S-l> <S-a>

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
nnoremap <silent> <F2> :tabe<CR>:Startify<CR>
" nnoremap <silent> <F2> :tabe $MYVIMRC<CR>

inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-h> <LEFT>
inoremap <C-l> <RIGHT>
inoremap {<Space> {}<LEFT>
inoremap [<Space> []<LEFT>
inoremap (<Space> ()<LEFT>
inoremap "<Space> ""<LEFT>
inoremap '<Space> ''<LEFT>
inoremap <<Space> <><LEFT>
inoremap <C-f> <PageDown>
inoremap <C-b> <PageUp>

" line yank
" all yank
" rela

autocmd BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd BufRead,BufNewFile,BufWrite *.hs set filetype=haskell

function! Date()
  return strftime("%m/%d/%Y %H:%M")
endfunction

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

command! -nargs=? FiveTenets call Fivetenets(<args>)

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

