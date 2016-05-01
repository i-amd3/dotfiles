#!/bin/sh

# Get dotfiles
echo "1. Download Dotfiles"
if [ ! -e  "$HOME/dotfiles" ]; then
  git clone https://github.com/i-amd3/dotfiles $HOME/dotfiles
fi

# Set Environment Variables
echo "2. Set Environment Variables"
export XDG_CONFIG_HOME=$HOME/dotfiles

# Create symbolic link
echo "3. Create symbolic link"
SRCFILES=(
  nvim
  nvim/init.vim
  zshrc
)

for file in ${SRCFILES[@]}
do
  if [ $file == "nvim" ]; then
    dst=".vim"
  elif [ $file == "nvim/init.vim" ]; then
    dst=".vimrc"
  else
    dst=".${file}"
  fi

  if [ ! -h $HOME/$dst ]; then
    echo "    - $HOME/$dst"
    ln -sf $XDG_CONFIG_HOME/$file $HOME/$dst
  fi
done

# Install Homebrew
echo "4. Install Homebrew"
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update, Upgrade homebrew
echo "5. Update, Upgrade homebrew"
if test $(which brew); then
  brew update
  brew upgrade
fi


# brew install
echo "6. brew install"
SRCPKGS=(
  ctags
  git
  git-flow
  gnu-tar
  haskell-stack
  httpie
  jq
  jo
  neovim
  node
  p7zip
  pandoc
  peco
  purescript
  python
  python3
  tree
  wget
  zsh
)

for target in ${SRCPKGS[@]}
do
  flag="false"

  for pkg in `brew list`
  do
    if [ $pkg == $target ]; then
      flag="true"
    fi
  done

  if [ $flag == "false" ]; then
    if [ $target == "neovim" ]; then
      target="neovim/neovim/neovim"
    fi
    echo "    - $target"
    brew install $target
  fi
done
brew linkapps
brew cleanup

# brew cask install
echo "7. brew install"
brew install brew-cask
brew install caskroom/cask/brew-cask

SRCPKGS=(
  google-chrome
  google-japanese-ime
  iterm2
  virtualbox
  vagrant
  vagrant-manager
)

for target in ${SRCPKGS[@]}
do
  flag="false"

  for pkg in `brew cask list`
  do
    if [ $pkg == $target ]; then
      flag="true"
    fi
  done

  if [ $flag == "false" ]; then
    echo "    - $target"
    brew cask install $target
  fi
done

# Update pkg
for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || brew cask install $c; done
brew cask cleanup


# Setting pip
echo "8. Setting pip"
pip install --upgrade pip setuptools
pip3 install --upgrade pip setuptools
pip install neovim
pip3 install neovim

# install vim-plug
echo "9. install vim-plug"
if [ ! -e  "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" ]; then
  curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


# install zplug
echo "10. install zplug"

if [ ! -e  "$XDG_CONFIG_HOME/etc" ]; then
  # make directory
  mkdir -p $XDG_CONFIG_HOME/etc
fi

if [ ! -e  "$XDG_CONFIG_HOME/etc/zplug" ]; then
  # install
  git clone https://github.com/b4b4r07/zplug $XDG_CONFIG_HOME/etc/zplug
fi

if [ ! -h $HOME/.zplug ]; then
  # create symbolic link
  ln -sf $XDG_CONFIG_HOME/etc/zplug $HOME/.zplug
fi


# Install Haskell Library
echo "11. install Haskell Library"
if test $(which stack); then
  stack update
  stack upgrade

  SRCPKGS=(
    alex
    codex
    ghc-mod
    hoogle
    haddock
    hakyll-init
    hasktags
    hlint
    happy
  )

  for target in ${SRCPKGS[@]}
  do
    flag="false"

    for pkg in `ls $HOME/.local/bin/`
    do
      if [ $pkg == $target ]; then
        flag="true"
      fi
    done

    if [ $flag == "false" ]; then
      if [ $target == "hakyll-init" ]; then
        target="hakyll"
      fi

      echo "    - $target"
      stack install $target --resolver=nightly
    fi
  done
fi


# Install Purescript dev
echo "12. install purescript dev"
if test $(which psc); then
  SRCPKGS=(
    pulp
    bower
  )

  for target in ${SRCPKGS[@]}
  do
    if test ! $(which $target); then
      echo "    - $target"
      npm install -g $target
    fi
  done
fi


# Hoogle
echo "13. Setting Hoogle"
if test $(which hoogle); then
  h=`hoogle 'a -> a'`
  if test $? != 0; then
    hoogle data all
  fi
fi


# Ricty
echo "14. Install Ricty"

h=`ls /Library/Fonts | grep "Ricty*"`

if test "$h" = "" ; then
  curl -L 'https://gist.github.com/ysaotome/7286145/raw/installing_ricty_on_MacOSX.sh' | bash
fi


# Git
echo "15. Setting Git"
git config --global user.name "i-amd3"
git config --global user.email d.kupanhy@gmail.com
git config --global core.editor vim

# change shell
echo "16. Change shell"
if test "$SHELL" != "/usr/local/bin/zsh" ; then
  sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi

