set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif

let $PATH = $PATH . ':' . expand('$HOME/bin/')
let $PATH = $PATH . ':' . expand('$HOME/.cargo/bin')

augroup _vimrc
  autocmd!
augroup END

"----------------------------------------
" zplug
"---------------------------------------
call plug#begin('$HOME/.vim/plugged')

  " Keyword Auto-completion
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  else
    Plug 'Shougo/neocomplete.vim'
  endif
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'Shougo/unite.vim'

  "----------------------------------
  " util
  "---------------------------------
  " Repeatable f, F, t and T
  Plug 'rhysd/clever-f.vim'

  " Delete/change/add parentheses
  Plug 'tpope/vim-surround'

  " Delete/add comment
  Plug 'tpope/vim-commentary'

  " TODO -> vim-airline
  Plug 'itchyny/lightline.vim'

  " TODO
  Plug 'yuratomo/w3m.vim'

  " TODO
  Plug 'dhruvasagar/vim-table-mode'

  " TODO
  Plug 'i-amd3/BlockDiff'

  "----------------------------------
  " develop
  "---------------------------------
  " Snippet engine | Contains snippets files
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " View the tags of the current file
  Plug 'majutsushi/tagbar'

  " TODO
  Plug 'tpope/vim-fugitive'

  " TODO
  Plug 'tpope/vim-git'

  " TODO
  Plug 'scrooloose/syntastic', { 'for': 'haskell' }

  "----------------------------------
  " haskell
  "---------------------------------
  " Syntax Highlighting and Indentation
  Plug 'dag/vim2hs', { 'for': 'haskell' }

  " ghc-mod plugin
  Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }

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

  "----------------------------------
  " Rust
  "---------------------------------
  " Syntax Highlighting and Indentation
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }

  " Auto-completion for Rust
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }

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
autocmd _vimrc BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd _vimrc BufRead,BufNewFile,BufWrite *.hs set filetype=haskell
autocmd _vimrc BufRead,BufNewFile,BufWrite *.purs set filetype=purescript
autocmd _vimrc BufRead,BufNewFile,BufWrite *.rs set filetype=rust

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

" TODO
set clipboard+=unnamed

" Gui Font
set guifont=Ricty\ Discord:h16
set guifontwide=Ricty\ Discord:h16

" dispay status line
set laststatus=2

" Not create backup
set nobackup

" Not create swap
set noswapfile

" Not create viminfo
set viminfo+=h

" disable beeping
set visualbell t_vb=

" Set tags files
set tags=tags;/,codex.tags;/

" TODO
set ambiwidth=double

"----------------------------------------
" Variable
"---------------------------------------
let mapleader = "\<Space>"

" TODO Use deoplete or.
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
else
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#use_vimproc = 1
endif

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" TODO
let g:w3m#command = '/usr/local/Cellar/w3m/0.5.3/bin/w3m'

" TODO
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" TODO
let g:syntastic_check_on_open = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["haskell","javascript","rust"],
    \ "passive_filetypes": [] }

" TODO
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'filelen', 'date' ],
      \              [ 'syntastic', 'lineinfo' ], ['percent'],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'date': '%{Date()}',
      \   'readonly': '%{&readonly?"x":""}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \ },
      \ 'separator': { 'lef': '', 'right': ''},
      \ 'subseparator': { 'left': '|', 'right': '|'},
      \ }

" -- Rust Settings
" --
autocmd _vimrc FileType rust let g:rustfmt_autosave = 1
autocmd _vimrc FileType rust let g:rustfmt_command = expand('$HOME/.cargo/bin/rustfmt')

" autocmd _vimrc FileType rust set hidden
autocmd _vimrc FileType rust let g:racer_cmd = expand('$HOME/.cargo/bin/racer')
autocmd _vimrc FileType rust let $RUST_SRC_PATH = expand('$HOME/dotfiles/etc/rustc/src/')

" -- Haskell Settings
" --
" run cmd when filetype is haskell
autocmd _vimrc BufWritePost FileType haskell GhcModCheckAndLintAsync

" Setting Auto-completion
autocmd _vimrc FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd _vimrc FileType haskell let g:necoghc_enable_detailed_browse = 1

" Setting Haskell File
autocmd _vimrc FileType haskell let g:haskell_conceal = 0
autocmd _vimrc FileType haskell let g:haskell_conceal_enumerations = 0

" Setting necoghc
autocmd _vimrc FileType haskell let g:haskellmode_completion_ghc = 1
autocm  _vimrc FileType haskell let g:necoghc_enable_detailed_browse = 1

" TODO
autocmd _vimrc FileType haskell let g:tagbar_type_haskell = {
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
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

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

nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gremove<CR>

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

nnoremap <Leader>f :vim<Space>"<C-r><C-w>"<Space><C-r>=getcwd()<CR>/**

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>

" --- Neovim
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" --- Haskell
" ---
autocmd _vimrc FileType haskell nnoremap <buffer> <F5>   :Unite haskellimport<CR>
autocmd _vimrc FileType haskell nnoremap <buffer> <F6>   :Hoogle
autocmd _vimrc FileType haskell nnoremap <buffer> <F7>   :TagbarToggle<CR>

autocmd _vimrc FileType haskell nnoremap <buffer> <Space>ht :GhcModType<CR>
autocmd _vimrc FileType haskell nnoremap <buffer> <Space>hc :GhcModTypeClear<CR>
autocmd _vimrc FileType haskell nnoremap <buffer> <Space>hi :GhcModTypeInsert<CR>
