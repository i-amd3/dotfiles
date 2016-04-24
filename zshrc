#
# 環境設定
export LANG=ja_JP.UTF-8
export TERM=xterm-256color

export PGDATA=/usr/local/var/postgres
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH

export XDG_CONFIG_HOME=$HOME/dotfiles:$XDG_CONFIG_HOME

# zplug 初期設定(予定)
source $HOME/.zplug/zplug

# plugins=(git git-flow-completion stack cabal brew vagrant)

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

# 履歴に重複したコマンドがある場合は古い方を削除
setopt hist_save_nodups

# 同じコマンドを履歴に保存しない
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# スペースから始まるコマンドは保存しない
setopt hist_ignore_space

# 履歴に保存するときに余分なスペースを削除
setopt hist_reduce_blanks

# vimで新規ファイルを開くときタブで開く
alias vim='nvim'
# alias mvim='mvim --remote-tab-silent'

# alias設定
if [ -x "`which peco`" ]; then
  alias tp='top | peco'
  alias pp='ps aux | peco'
fi

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

alias rm='rm -i'
alias cp='cp'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias sudo='sudo '

alias -g L='| less'
alias -g G='| grep'
alias -g P='| peco'

# 再読み込み
alias reload='source ~/.zshrc'

# Haskell
alias ghc='stack ghc'
alias ghci='stack ghci'
alias runghc='stack runghc'

# peco設定
function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco_select_history
bindkey '^R' peco_select_history

