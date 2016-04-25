
set encoding=utf8
set fileencoding=utf8

if !1 | finish | endif

if !has('gui_running')
  set t_Co=256
endif

call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'rhysd/clever-f.vim'
call plug#end()

filetype plugin indent on

colorscheme koehler
syntax on

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"Python support
"let g:python_host_prog = '/usr/local/bin'

"Python3 support
"let g:python3_host_prog = '/usr/local/bin'

