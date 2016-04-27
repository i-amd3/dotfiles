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

  " Repeatable f, F, t and T
  Plug 'rhysd/clever-f.vim'

call plug#end()


"----------------------------------------
" Vim settings
"---------------------------------------
filetype plugin indent on

colorscheme koehler
syntax on

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"Python support
"let g:python_host_prog = '/usr/local/bin'

"Python3 support
"let g:python3_host_prog = '/usr/local/bin'


"----------------------------------------
" Function
"---------------------------------------
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

