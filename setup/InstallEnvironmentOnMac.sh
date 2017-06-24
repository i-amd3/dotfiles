#!/bin/sh
Install_Num=0

main() {
  echo " ==== Start Initialize\n"

  # Install Homebrew
  next_inst_num
  if test ! $(which brew); then
    install_msg " |=| $Install_Num. Install Homebrew ..."
    run 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  else
    skip_msg $Install_Num "Homebrew"
  fi
  echo ""

  # Install Ansible
  next_inst_num
  if test ! $(which ansible); then
    echo " |=| $Install_Num. Install Ansible ..."
    run "brew update"
    run "brew install python"
    run "brew install ansible"
  else
    skip_msg $Install_Num "Ansible"
  fi
  echo ""

  echo " ==== End Initialize"
}

run() {
  echo "> $1"
  eval $1
  echo ""
}

next_inst_num() {
  Install_Num=$[$Install_Num+1]
}

install_msg() {
  echo " |=| $1. Install $2 ..."
}

skip_msg() {
  echo "$1. Skip: $2 is Already installed !!"
}

main
