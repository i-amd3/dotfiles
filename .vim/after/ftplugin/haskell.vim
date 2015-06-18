filetype off

if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'ujihisa/unite-haskellimport'
NeoBundle 'scrooloose/syntastic'

filetype plugin indent on
