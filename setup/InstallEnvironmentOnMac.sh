#!/bin/sh
echo " ==== Start Initialize"

# Install Homebrew
if test ! $(which brew); then
  echo "1. Install Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Ansible
if test ! $(which ansible); then
  echo "1. Install Ansible"
  brew update
  brew install python
  brew install ansible
fi

echo " ==== End Initialize"
