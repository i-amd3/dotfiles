#!/bin/sh
export XDG_CONFIG_HOME = $XDG_CONFIG_HOME:$HOME/dotfiles

# Get dotfiles
git clone https://github.com/i-amd3/dotfiles $HOME/dotfiles

# Create symbolic link
ln -sf $XDG_CONFIG_HOME/nvim          $HOME/.vim
ln -sf $XDG_CONFIG_HOME/nvim/init.vim $HOME/.vimrc
ln -sf $XDG_CONFIG_HOME/zshrc         $HOME/.zshrc

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update, Upgrade homebrew
brew update
brew upgrade

# Install
brew install vim --with-lua
brew install macvim --with-lua
brew install neovim/neovim/neovim
brew install python
brew install python3
brew linkapps
# brew linkapps python
# brew linkapps python3
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

# uprade pip
# pip install --upgrade pip setuptools
# pip3 install --upgrade pip setuptools

# install python plugin for neovim
pip install --user neovim
pip3 install --user neovim

# vim-plug
curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zplug
mkdir -p $XDG_CONFIG_HOME/etc
git clone https://github.com/b4b4r07/zplug $XDG_CONFIG_HOME/etc/zplug
ln -sf $XDG_CONFIG_HOME/etc/zplug $HOME/.zplug

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

