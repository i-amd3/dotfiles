#!/bin/sh

# Get dotfiles
git clone https://github.com/i-amd3/dotfiles $HOME/dotfiles

# Create symbolic link
ln -sf $HOME/dotfiles/.vim $HOME/.vim
ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update, Upgrade homebrew
brew update
brew upgrade

# Install
brew install vim --with-lua
brew install macvim --with-lua
brew linkapps
brew install ctags
brew install git-flow
brew install gnu-tar
brew install haskell-stack
brew install httpie
brew install jq
brew install jo
brew install p7zip
brew install peco
brew install tree
brew install vim
brew install wget
brew install zsh
brew cleanup

# Cask Install
brew install brew-cask
brew install caskroom/cask/brew-cask
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install iterm2
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager
brew cask cleanup

# NeoBundle
mkdir -p $HOME/.vim/bundle/
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
$HOME/.vim/bundle/neobundle.vim/bin/neoinstall

# ZSH
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/dotfiles/.oh-my-zsh
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
chsh -s /usr/local/bin/zsh

# Haskell Library
stack update
stack upgrade
stack install alex
stack install ghc-mod
stack install hoogle
stack install haddock
stack install hakyll
stack install hlint
stack install happy
stack install shelly

# Hoogle
hoogle data all

# Ricty
curl -L 'https://gist.github.com/ysaotome/7286145/raw/installing_ricty_on_MacOSX.sh' | bash

# Git
git config --global user.name "i-amd3"
git config --global user.email d.kupanhy@gmail.com
git config --global core.editor vim

