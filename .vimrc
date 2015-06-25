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
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Twinside/vim-hoogle'
NeoBundle 'ujihisa/unite-haskellimport'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'majutsushi/tagbar'

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

autocmd BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd BufRead,BufNewFile,BufWrite *.hs set filetype=haskell

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

nnoremap <F3> :tabe<CR>:VimFiler<CR>
nnoremap <D-e> :VimFilerExplorer -split -winwidth=30 -toggle -no-quit<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <F4> :tabe<CR>:VimShell<CR>
nnoremap ,vs :VimShellPop<CR>

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
autocmd FileType haskell nnoremap <Space>ht :GhcModType<CR>
autocmd FileType haskell nnoremap <Space>hc :GhcModTypeClear<CR>
autocmd FileType haskell nnoremap <Space>hi :GhcModTypeInsert<CR>

let g:neocomplete#enable_at_startup = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell let g:syntastic_check_on_open = 1
autocmd FileType haskell let g:ycm_semantic_triggers = {'haskell' : ['.']}
autocmd FileType haskell let g:necoghc_enable_detailed_browse = 1

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["haskell"],
    \ "passive_filetypes": [] }

autocmd FileType haskell nnoremap <F5>   :Unite haskellimport<CR>
autocmd FileType haskell nnoremap <F6>   :Hoogle
autocmd FileType haskell nnoremap <F7>   :TagbarToggle<CR>

function! RunLushtags ()
    let g:tagbar_type_haskell = {
        \ 'ctagsbin' : 'lushtags',
        \ 'ctagsargs' : '--ignore-parse-error --',
        \ 'kinds' : [
            \ 'm:module:0',
            \ 'e:exports:1',
            \ 'i:imports:1',
            \ 't:declarations:0',
            \ 'd:declarations:1',
            \ 'n:declarations:1',
            \ 'f:functions:0',
            \ 'c:constructors:0'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 'd' : 'data',
            \ 'n' : 'newtype',
            \ 'c' : 'constructor',
            \ 't' : 'type'
        \ },
        \ 'scope2kind' : {
            \ 'data' : 'd',
            \ 'newtype' : 'n',
            \ 'constructor' : 'c',
            \ 'type' : 't'
        \ }
    \ }
endfunction

autocmd FileType haskell :call RunLushtags()

