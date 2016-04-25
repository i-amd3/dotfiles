
set encoding=utf8
set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif

call plug#begin('~/.vim/plugged')
plug 'rhysd/clever-f.vim'
call plug#end()

"Python support
"let g:python_host_prog = '/usr/local/bin'

"Python3 support
"let g:python3_host_prog = '/usr/local/bin'

filetype plugin indent on

colorscheme koehler
syntax on

