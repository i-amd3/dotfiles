#
# 環境設定
export LANG=ja_JP.UTF-8
export TERM=xterm-256color

export PGDATA=/usr/local/var/postgres
export PATH=~/.cabal/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/Library/Haskell/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=~/bin:$PATH
export PATH=/usr/local/bin:$PATH

# oh-my-zsh 初期設定
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME='agnoster'

plugins=(git)

source $ZSH/oh-my-zsh.sh

# viライクな操作
bindkey -v

# 履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 色の有効
autoload -Uz colors
colors

# 補完有効
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# cdを使わずディレクトリ移動
setopt auto_cd
alias ...='cd ../../'
alias ....='cd ../../../'

# cd移動先をスタックに追加'cd +<Tab>'
setopt auto_pushd
setopt pushd_ignore_dups

# beepを無効
setopt no_beep

# 同じコマンドを履歴に保存しない
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# スペースから始まるコマンドは保存しない
setopt hist_ignore_space

# 履歴に保存するときに余分なスペースを削除
setopt hist_reduce_blanks

# vimで新規ファイルを開くときタブで開く
alias mvim='mvim --remote-tab-silent'

alias reload='source ~/.zsh'

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias sudo='sudo '

alias -g L='| less'
alias -g G='| grep'

alias reload='source ~/.zshrc'
