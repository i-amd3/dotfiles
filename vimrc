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
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
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

  " TODO
  Plug 'itchyny/lightline.vim'
  Plug 'mhinz/vim-startify'
  Plug 'yuratomo/w3m.vim'

  "----------------------------------
  " develop
  "---------------------------------
  " Snippet engine | Contains snippets files
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " View the tags of the current file
  Plug 'majutsushi/tagbar'

  " TODO
  Plug 'tpope/vim-fugitive'
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

let $PATH = $PATH . ':' . expand('$HOME/bin/')
let $PATH = $PATH . ':' . expand('$HOME/.cargo/bin')

let g:git_diff_normal="git-diff-normal"
let g:git_diff_normal_opts=["--diff-algorithm=histogram"]

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'

set hidden
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let $RUST_SRC_PATH="$HOME/dotfiles/etc/rustc-1.9.0/src/"

" run cmd when filetype is haskell
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Setting necoghc
let g:haskellmode_completion_ghc = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:necoghc_enable_detailed_browse = 1

let g:haskell_conceal              = 0
let g:haskell_conceal_enumerations = 0

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
      \   'filelen': '%{b:charCounterCount}',
      \   'readonly': '%{&readonly?"x":""}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \ },
      \ 'separator': { 'lef': '', 'right': ''},
      \ 'subseparator': { 'left': '|', 'right': '|'},
      \ }

let g:vimfiler_ignore_pattern = '\%(\.git\|\.DS_Store\)$'

let g:startify_custom_header = map(split(system('date +"%m/%d/%Y %p %I:%M:%S"'), '\n'), '"   ". v:val') + ['','']

let g:w3m#command = '/usr/local/Cellar/w3m/0.5.3/bin/w3m'

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippets#snippets_directory='$HOME/.vim/bundle/vim-snippets/snippets'

function! RndAlpha()
  let l:xs = []
  let l:ax = "acdfghlmnoprwxzy"
  for i in range(0,strlen(l:ax)-1)
    call add(l:xs, strpart(l:ax,i,1))
  endfor

  let l:yx = []
  for i in range(0,9)
    let l:rnd = system(printf("getRnd %o", len(l:xs)-1-i))
    if l:rnd >= len(l:xs)
      let l:rnd = 0
    endif
    call add(l:yx, remove(l:xs, l:rnd))
  endfor

  return yx
endfunction

let g:startify_custom_indices = RndAlpha()

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
  \ '~/.zshrc',
  \ ]

let g:startify_files_number = 5

let g:syntastic_check_on_open = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["haskell","javascript"],
    \ "passive_filetypes": [] }

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

set guifont=Ricty\ Discord:h16
set guifontwide=Ricty\ Discord:h16

set laststatus=2

set nobackup
set noswapfile

set viminfo+=h

set visualbell t_vb=

" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

vnoremap <Space> <Nop>
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
nnoremap <Space>e :VimFilerExplorer -split -winwidth=30 -toggle -no-quit<CR>

nnoremap <F4> :tabe<CR>:VimShell<CR>
nnoremap <Space>v :VimShellPop<CR><Esc><C-w>Ja

nnoremap <Space>ft :FiveTenets<CR>

nnoremap <Space>ga :Gwrite<CR>
nnoremap <Space>gr :Gread<CR>
nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>gc :Gcommit<CR>
nnoremap <Space>gl :Glog<CR>
nnoremap <Space>gd :Gdiff<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gm :Gremove<CR>

nnoremap <S-h> <S-i>
nnoremap <S-l> <S-a>
vnoremap <S-h> <S-i>
vnoremap <S-l> <S-a>

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
nnoremap <silent> <F2> :tabe<CR>:Startify<CR>
nnoremap <silent> <Space>r :source $MYVIMRC<CR>

nnoremap <silent> <Space>ay :%yank<CR>
nnoremap <silent> <Space>ad :%delete<CR>
nnoremap <silent> <Space>y yiw
nnoremap <silent> <Space>d diw
nnoremap <silent> <Space>i :set invrelativenumber<CR>

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

nnoremap <Space>f :vim<Space>"<C-r><C-w>"<Space><C-r>=getcwd()<CR>/**

nnoremap <Space>c :Codic<Space>

nnoremap bn :bnext<CR>
nnoremap bp :bprevious<CR>

autocmd BufRead,BufNewFile,BufWrite *.md set filetype=markdown
autocmd BufRead,BufNewFile,BufWrite *.hs set filetype=haskell
autocmd QuickFixCmdPost *grep* cwindow

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

inoremap <silent> <C-c>  <C-R>=<SID>codic_complete()<CR>
function! s:codic_complete()
  let line = getline('.')
  let start = match(line, '\k\+$')
  let cand = s:codic_candidates(line[start :])
  call complete(start +1, cand)
  return ''
endfunction
function! s:codic_candidates(arglead)
  let cand = codic#search(a:arglead, 30)
  " error
  if type(cand) == type(0)
    return []
  endif
  " english -> english terms
  if a:arglead =~# '^\w\+$'
    return map(cand, '{"word": v:val["label"], "menu": join(map(copy(v:val["values"]), "v:val.word"), ",")}')
  endif
  " japanese -> english terms
  return s:reverse_candidates(cand)
endfunction
function! s:reverse_candidates(cand)
  let _ = []
  for c in a:cand
    for v in c.values
      call add(_, {"word": v.word, "menu": !empty(v.desc) ? v.desc : c.label })
    endfor
  endfor
  return _
endfunction

