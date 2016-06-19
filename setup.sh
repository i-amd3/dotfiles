#!/bin/sh

# Set Environment Variables
echo "1. Set Environment Variables"
dotfiles="$HOME/dotfiles"
export XDG_CONFIG_HOME=$HOME/.config

# Get dotfiles
echo "2. Download Dotfiles"
if [ -e  $dotfiles ]; then
  rm -rf $dotfiles
fi
git clone https://github.com/i-amd3/dotfiles $dotfiles

SRCPKGS=(
  $dotfiles/vim
  $XDG_CONFIG_HOME
  )

for target in ${SRCPKGS[@]}
do
  if [ -e  $target ]; then
    rm -rf $target
  fi
  mkdir -p $target
done


# Create symbolic link
echo "3. Create symbolic link"
SRCPKGS=(
  $XDG_CONFIG_HOME/nvim
  $XDG_CONFIG_HOME/nvim/init.vim
  $HOME/.vim
  $HOME/.vimrc
  $HOME/.zshrc
  )

for target in ${SRCPKGS[@]}
do
  if [ -e  $target ]; then
    rm -rf $target
  fi
done

ln -sf $dotfiles/vim    ${SRCPKGS[1]}
ln -sf $dotfiles/vimrc  ${SRCPKGS[2]}

ln -sf $dotfiles/vim    ${SRCPKGS[3]}
ln -sf $dotfiles/vimrc  ${SRCPKGS[4]}
ln -sf $dotfiles/zshrc  ${SRCPKGS[5]}

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
  macvim
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
  w3m
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
if [ ! -e  "$dotfiles/vim/autoload/plug.vim" ]; then
  curl -fLo $dotfiles/vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install zplug
echo "10. install zplug"

if [ ! -e  "$dotfiles/etc" ]; then
  # make directory
  mkdir -p $dotfiles/etc
fi

if [ ! -e  "$dotfiles/etc/zplug" ]; then
  # install
  git clone https://github.com/b4b4r07/zplug $dotfiles/etc/zplug
fi

if [ ! -h $dotfiles/.zplug ]; then
  # create symbolic link
  ln -sf $dotfiles/etc/zplug $HOME/.zplug
fi

# Install Rust
echo "11. install Rust"
if test ! $(which rustc); then
  curl -sSf https://static.rust-lang.org/rustup.sh | sh
fi
cargo install rustfmt
cargo install racer

# Install Haskell Library
echo "12. install Haskell Library"
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
echo "13. install purescript dev"
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
echo "14. Setting Hoogle"
if test $(which hoogle); then
  h=`hoogle 'a -> a'`
  if test $? != 0; then
    hoogle data all
  fi
fi


# Ricty
echo "15. Install Ricty"

h=`ls /Library/Fonts | grep "Ricty*"`

if test "$h" = "" ; then
  curl -L 'https://gist.github.com/ysaotome/7286145/raw/installing_ricty_on_MacOSX.sh' | bash
fi


# Git
echo "16. Setting Git"
git config --global user.name "i-amd3"
git config --global user.email d.kupanhy@gmail.com
git config --global core.editor vim

# change shell
echo "17. Change shell"
if test "$SHELL" != "/usr/local/bin/zsh" ; then
  sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi

